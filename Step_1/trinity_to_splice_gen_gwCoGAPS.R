###Loading in the RSEM output for gene quantification for all samples
variables <- read.table("variables.txt")
samples <- read.table(variables[1,1])
shflist <- paste0(samples[,2], "/RSEM.genes.results", sep="")
shflist <- as.data.frame(shflist)

#Put the  Trinity output folder here
shflist$shflist <- paste0(variables[2,1], variables[5,1], "/RSEM/", shflist$shflist)

for (n in shflist$shflist) {assign(paste("A",n, sep=""), (read.table(n, header = TRUE)))}

list_of_variables <- list()

#This function will count up how many samples you have, that's how many iterations through this for loop it will do
j <- nrow(shflist)

for (n in 1:j) {
  sSRR <- shflist$shflist[n]
  list_of_variables[[sSRR]] <- get(paste0("A", shflist$shflist[n]))
}

shflist$shflist<-paste0("A", shflist$shflist)
list_of_names <- shflist$shflist

###Constructing and saving a single counts data frame for all samples for downstream analysis

#We'll count up the number of genes to see how big this dataframe should be
k <- nrow(list_of_variables[[1]])
ctse <- data.frame(1:k)

#Again this number will change with how many samples you have
for (n in 1:j){
  ctse[ , n] <- list_of_variables[[n]]$TPM
}

row.names(ctse) = list_of_variables[[1]]$gene_id

for (n in 1:length(list_of_names)) {
  ctse[ , n] <- as.integer(ctse[ ,n])
}

shflist1 <- as.data.frame(paste0(samples[,2], "_RSEM.genes.results"))

colnames(shflist1) <- "names"
colnames(ctse) <- shflist1$names

#Update the name of this count frame
save(ctse, file=paste0(variables[2,1], variables[5,1], "/CoGAPS/", variables[5,1], "countsframe"))


###Prefiltering genes with a count of less than 10 across all of the samples and converting the counts dataframe to a matrix
###Its better to give machine learning programs as much information as possible, so I give CoGAPS the entire counts matrix for the whole study.
ctse$total <- rowSums(ctse)
ctsyo <- ctse[which(ctse$total>10), ]

#This number will be determined by how many columns you have. Automatically determined
ctsboi <- ctsyo[ , -(j+1)]
#Update the name of the filtered counts frame
save(ctsboi, file=paste0(variables[2,1], variables[5,1], "/CoGAPS/", variables[5,1], "countsframe_filtered"))

ctsboimat <- as.matrix(ctsboi)

ctsboimatlo <- log2(ctsboimat)
ctsboimatlo[ctsboimatlo == '-Inf'] <- 0
#Update the name of the log transformed counts frame
save(ctsboimatlo, file=paste0(variables[2,1], variables[5,1], "/CoGAPS/", variables[5,1], "countsframe_filtered_log"))

#boxplot to see distribution of gene counts
#Update the name
pdf(paste0(variables[5,1], "_matslog.pdf"))
boxplot(ctsboimatlo)
dev.off()






library("Matrix")
library("SparseM")
#Converting my log-transformed counts matrix to a sparsematrix because NMF likes sparse matrices
ctsboimatlosparse <- as(ctsboimatlo, "sparseMatrix")
#Update the name
writeMM(ctsboimatlosparse, paste0(variables[2,1], variables[5,1], "/CoGAPS/", variables[5,1], "log.mtx"))






library("CoGAPS")
#input variables here
#Update the name
experiment_name<-paste0("gwCoGAPS_testlog_", variables[5,1])
nsets<-24
outdir<-paste0(variables[2,1], variables[5,1],"/CoGAPS/")

for(n in variables[6,1]:variables[7,1]){
nPatterns <- n
#Keep this code the same
params <- new("CogapsParams")
params <- setParam(params, "nPatterns", nPatterns)
params <- setDistributedParams(params, nSets=nsets)
#nsets should be less than or equal to the number of nodes/cores that are available
#The general rule of thumb is to set nSets so that each subset has between 1000 and 5000 genes or cells

###Running CoGAPS
#Update the matrix name
result <- CoGAPS(paste0(variables[2,1], variables[5,1], "/CoGAPS/", variables[5,1], "log.mtx"), 
params, checkpointInterval=100, checkpointOutFile=paste0(nPatterns, "_patterns.out"), distributed="genome-wide")
#In general it is preferred to pass a file name to GWCoGAPS/scCoGAPS
#otherwise the entire data set must be copied across multiple processes which will slow things down
#potentially causing an out-of-memory error

save(result, file=paste(outdir, experiment_name, "_result_", nPatterns, ".RData", sep=""))







library("pheatmap")
library("RColorBrewer")
library("plyr")
library("dplyr")
###Visualization
###Here I'm adding the sample names back on
height <- result@sampleFactors
row.names(height) <- colnames(ctsboimatlo)

###Here I'm adding the names of the genes back on for downstream use
weight <- result@featureLoadings
rownames(weight) <- rownames(ctsboimatlo)
weight <- as.data.frame(weight)



###This should generate a heatmap of all of the patterns at once and dotplots for each pattern
#Update the name
pdf(paste0(outdir, variables[5,1], "_", nPatterns, "patternslog.pdf"))
breaksList <- seq(0, 1, by = 0.001)
pheatmap(height, fontsize = 6, angle_col = 45,
         fontsize_col = 8, cluster_rows = F, cluster_cols = T, cellwidth = ,
         color = colorRampPalette(rev(brewer.pal(n = 11, name ="RdYlBu")))(length(breaksList)),
         show_rownames = T,
         breaks = breaksList)
dev.off()
}
