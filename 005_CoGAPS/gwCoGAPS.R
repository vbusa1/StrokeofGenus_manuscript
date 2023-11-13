

###Loading in the RSEM output for gene quantification for all samples

#Put the RSEM sample folders here
shflist <- c("Cortex_2Dayspost_Rep1/RSEM.genes.results",
"Cortex_2Dayspost_Rep2/RSEM.genes.results",
"Cortex_2Dayspost_Rep3/RSEM.genes.results",
"Cortex_14Dayspost_Rep1/RSEM.genes.results",
"Cortex_14Dayspost_Rep2/RSEM.genes.results",
"Cortex_14Dayspost_Rep3/RSEM.genes.results",
"Cortex_Prehibernation_Rep1/RSEM.genes.results",
"Cortex_Prehibernation_Rep2/RSEM.genes.results",
"Cortex_Prehibernation_Rep3/RSEM.genes.results",
"Cortex_Torpor_Rep1/RSEM.genes.results",
"Cortex_Torpor_Rep2/RSEM.genes.results",
"Cortex_Torpor_Rep3/RSEM.genes.results",
"Hypothalamus_2Dayspost_Rep1/RSEM.genes.results",
"Hypothalamus_2Dayspost_Rep2/RSEM.genes.results",
"Hypothalamus_2Dayspost_Rep3/RSEM.genes.results",
"Hypothalamus_14Dayspost_Rep1/RSEM.genes.results",
"Hypothalamus_14Dayspost_Rep2/RSEM.genes.results",
"Hypothalamus_14Dayspost_Rep3/RSEM.genes.results",
"Hypothalamus_Prehibernation_Rep1/RSEM.genes.results",
"Hypothalamus_Prehibernation_Rep2/RSEM.genes.results",
"Hypothalamus_Prehibernation_Rep3/RSEM.genes.results",
"Hypothalamus_Torpor_Rep1/RSEM.genes.results",
"Hypothalamus_Torpor_Rep2/RSEM.genes.results",
"Hypothalamus_Torpor_Rep3/RSEM.genes.results",
"Liver_2Dayspost_Rep1/RSEM.genes.results",
"Liver_2Dayspost_Rep2/RSEM.genes.results",
"Liver_2Dayspost_Rep3/RSEM.genes.results",
"Liver_14Dayspost_Rep1/RSEM.genes.results",
"Liver_14Dayspost_Rep2/RSEM.genes.results",
"Liver_14Dayspost_Rep3/RSEM.genes.results",
"Liver_Prehibernation_Rep1/RSEM.genes.results",
"Liver_Torpor_Rep1/RSEM.genes.results",
"Liver_Torpor_Rep2/RSEM.genes.results",
"Liver_Torpor_Rep3/RSEM.genes.results",
"Retina_2Dayspost_Rep1/RSEM.genes.results",
"Retina_2Dayspost_Rep2/RSEM.genes.results",
"Retina_2Dayspost_Rep3/RSEM.genes.results",
"Retina_2Dayspost_Rep4/RSEM.genes.results",
"Retina_2Dayspost_Rep5/RSEM.genes.results",
"Retina_2Dayspost_Rep6/RSEM.genes.results",
"Retina_14Dayspost_Rep1/RSEM.genes.results",
"Retina_14Dayspost_Rep2/RSEM.genes.results",
"Retina_14Dayspost_Rep3/RSEM.genes.results",
"Retina_14Dayspost_Rep4/RSEM.genes.results",
"Retina_14Dayspost_Rep5/RSEM.genes.results",
"Retina_14Dayspost_Rep6/RSEM.genes.results",
"Retina_Prehibernation_Rep1/RSEM.genes.results",
"Retina_Prehibernation_Rep2/RSEM.genes.results",
"Retina_Prehibernation_Rep3/RSEM.genes.results",
"Retina_Prehibernation_Rep4/RSEM.genes.results",
"Retina_Prehibernation_Rep5/RSEM.genes.results",
"Retina_Prehibernation_Rep6/RSEM.genes.results",
"Retina_Torpor_Rep1/RSEM.genes.results",
"Retina_Torpor_Rep2/RSEM.genes.results",
"Retina_Torpor_Rep3/RSEM.genes.results",
"Retina_Torpor_Rep4/RSEM.genes.results",
"Retina_Torpor_Rep5/RSEM.genes.results",
"Retina_Torpor_Rep6/RSEM.genes.results",
"RPE_2Dayspost_Rep1/RSEM.genes.results",
"RPE_2Dayspost_Rep2/RSEM.genes.results",
"RPE_2Dayspost_Rep3/RSEM.genes.results",
"RPE_2Dayspost_Rep4/RSEM.genes.results",
"RPE_2Dayspost_Rep5/RSEM.genes.results",
"RPE_2Dayspost_Rep6/RSEM.genes.results",
"RPE_14Dayspost_Rep1/RSEM.genes.results",
"RPE_14Dayspost_Rep2/RSEM.genes.results",
"RPE_14Dayspost_Rep3/RSEM.genes.results",
"RPE_14Dayspost_Rep4/RSEM.genes.results",
"RPE_14Dayspost_Rep5/RSEM.genes.results",
"RPE_14Dayspost_Rep6/RSEM.genes.results",
"RPE_Prehibernation_Rep1/RSEM.genes.results",
"RPE_Prehibernation_Rep2/RSEM.genes.results",
"RPE_Prehibernation_Rep3/RSEM.genes.results",
"RPE_Prehibernation_Rep4/RSEM.genes.results",
"RPE_Prehibernation_Rep5/RSEM.genes.results",
"RPE_Prehibernation_Rep6/RSEM.genes.results",
"RPE_Torpor_Rep1/RSEM.genes.results",
"RPE_Torpor_Rep2/RSEM.genes.results",
"RPE_Torpor_Rep3/RSEM.genes.results",
"RPE_Torpor_Rep4/RSEM.genes.results",
"RPE_Torpor_Rep5/RSEM.genes.results",
"RPE_Torpor_Rep6/RSEM.genes.results")
			 
shflist <- as.data.frame(shflist)

#Put the  Trinity output folder here
shflist$shflist <- paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/13LGS_Blackshaw/", shflist$shflist)

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

shflist1 <- as.data.frame(c("C2D_rep1_RSEM.genes.results",
"C2D_rep2_RSEM.genes.results",
"C2D_rep3_RSEM.genes.results",
"C14D_rep1_RSEM.genes.results",
"C14D_rep2_RSEM.genes.results",
"C14D_rep3_RSEM.genes.results",
"CPH_rep1_RSEM.genes.results",
"CPH_rep2_RSEM.genes.results",
"CPH_rep3_RSEM.genes.results",
"CT_rep1_RSEM.genes.results",
"CT_rep2_RSEM.genes.results",
"CT_rep3_RSEM.genes.results",
"H2D_rep1_RSEM.genes.results",
"H2D_rep2_RSEM.genes.results",
"H2D_rep3_RSEM.genes.results",
"H14D_rep1_RSEM.genes.results",
"H14D_rep2_RSEM.genes.results",
"H14D_rep3_RSEM.genes.results",
"HPH_rep1_RSEM.genes.results",
"HPH_rep2_RSEM.genes.results",
"HPH_rep3_RSEM.genes.results",
"HT_rep1_RSEM.genes.results",
"HT_rep2_RSEM.genes.results",
"HT_rep3_RSEM.genes.results",
"L2D_rep1_RSEM.genes.results",
"L2D_rep2_RSEM.genes.results",
"L2D_rep3_RSEM.genes.results",
"L14D_rep1_RSEM.genes.results",
"L14D_rep2_RSEM.genes.results",
"L14D_rep3_RSEM.genes.results",
"LPH_rep1_RSEM.genes.results",
"LT_rep1_RSEM.genes.results",
"LT_rep2_RSEM.genes.results",
"LT_rep3_RSEM.genes.results",
"R2D_rep1_RSEM.genes.results",
"R2D_rep2_RSEM.genes.results",
"R2D_rep3_RSEM.genes.results",
"R2D_rep4_RSEM.genes.results",
"R2D_rep5_RSEM.genes.results",
"R2D_rep6_RSEM.genes.results",
"R14D_rep1_RSEM.genes.results",
"R14D_rep2_RSEM.genes.results",
"R14D_rep3_RSEM.genes.results",
"R14D_rep4_RSEM.genes.results",
"R14D_rep5_RSEM.genes.results",
"R14D_rep6_RSEM.genes.results",
"RPH_rep1_RSEM.genes.results",
"RPH_rep2_RSEM.genes.results",
"RPH_rep3_RSEM.genes.results",
"RPH_rep4_RSEM.genes.results",
"RPH_rep5_RSEM.genes.results",
"RPH_rep6_RSEM.genes.results",
"RT_rep1_RSEM.genes.results",
"RT_rep2_RSEM.genes.results",
"RT_rep3_RSEM.genes.results",
"RT_rep4_RSEM.genes.results",
"RT_rep5_RSEM.genes.results",
"RT_rep6_RSEM.genes.results",
"RPE2D_rep1_RSEM.genes.results",
"RPE2D_rep2_RSEM.genes.results",
"RPE2D_rep3_RSEM.genes.results",
"RPE2D_rep4_RSEM.genes.results",
"RPE2D_rep5_RSEM.genes.results",
"RPE2D_rep6_RSEM.genes.results",
"RPE14D_rep1_RSEM.genes.results",
"RPE14D_rep2_RSEM.genes.results",
"RPE14D_rep3_RSEM.genes.results",
"RPE14D_rep4_RSEM.genes.results",
"RPE14D_rep5_RSEM.genes.results",
"RPE14D_rep6_RSEM.genes.results",
"RPEPH_rep1_RSEM.genes.results",
"RPEPH_rep2_RSEM.genes.results",
"RPEPH_rep3_RSEM.genes.results",
"RPEPH_rep4_RSEM.genes.results",
"RPEPH_rep5_RSEM.genes.results",
"RPEPH_rep6_RSEM.genes.results",
"RPET_rep1_RSEM.genes.results",
"RPET_rep2_RSEM.genes.results",
"RPET_rep3_RSEM.genes.results",
"RPET_rep4_RSEM.genes.results",
"RPET_rep5_RSEM.genes.results",
"RPET_rep6_RSEM.genes.results"))

colnames(shflist1) <- "names"

colnames(ctse) <- shflist1$names

#Update the name of this count frame
save(ctse, file="/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshawcountsframe")


###Prefiltering genes with a count of less than 10 across all of the samples and converting the counts dataframe to a matrix
###Its better to give machine learning programs as much information as possible, so I give CoGAPS the entire counts matrix for the whole study. 
ctse$total <- rowSums(ctse)
ctsyo <- ctse[which(ctse$total>10), ]

#This number will be determined by how many columns you have. Automatically determined
ctsboi <- ctsyo[ , -(j+1)]
#Update the name of the filtered counts frame
save(ctsboi, file="/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshawcountsframe_filtered")

ctsboimat <- as.matrix(ctsboi)

ctsboimatlo <- log2(ctsboimat)
ctsboimatlo[ctsboimatlo == '-Inf'] <- 0
#Update the name of the log transformed counts frame
save(ctsboimatlo, file="/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshawcountsframe_filtered_log")

#boxplot to see distribution of gene counts
#Update the name
pdf("13LGS_Blackshaw_matslog.pdf")
boxplot(ctsboimatlo)
dev.off()






library("Matrix")
library("SparseM")
#Converting my log-transformed counts matrix to a sparsematrix because NMF likes sparse matrices
ctsboimatlosparse <- as(ctsboimatlo, "sparseMatrix")
#Update the name
writeMM(ctsboimatlosparse, "/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshawlog.mtx")






library("CoGAPS")
#input variables here
#Update the name
experiment_name<-"gwCoGAPS_testlog_13LGS_Blackshaw"
nPatterns<-10
nsets<-24
outdir<-"/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/"

#Keep this code the same
params <- new("CogapsParams")
params <- setParam(params, "nPatterns", nPatterns)
params <- setDistributedParams(params, nSets=nsets)
#nsets should be less than or equal to the number of nodes/cores that are available
#The general rule of thumb is to set nSets so that each subset has between 1000 and 5000 genes or cells

###Running CoGAPS
#Update the matrix name
result <- GWCoGAPS("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshawlog.mtx", params, checkpointInterval=100, checkpointOutFile="10_patterns.out")
#In general it is preferred to pass a file name to GWCoGAPS/scCoGAPS 
#otherwise the entire data set must be copied across multiple processes which will slow things down 
#potentially causing an out-of-memory error

save(result, file=paste(outdir, experiment_name, "_result_", nPatterns, ".RData", sep=""))






library("ggplot2")
library("cowplot")
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
pdf("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/13LGS_Blackshaw_noeuthermia_10patternslog.pdf")
breaksList <- seq(0, 1, by = 0.001)
pheatmap(height, fontsize = 6, angle_col = 45, 
         fontsize_col = 8, cluster_rows = F, cluster_cols = T, cellwidth = , 
         color = colorRampPalette(rev(brewer.pal(n = 11, name ="RdYlBu")))(length(breaksList)),
         show_rownames = T,
         breaks = breaksList)
for (n in (1:10)){
  plot(height[ ,n])
}
dev.off()
