#Libraries bebe
library("CoGAPS")
library("Matrix")
library("projectR")
library("plyr")
library("dplyr")
library("stringr")
library("pheatmap")
library("RColorBrewer")

#This section before the big break in code is the only section that should need to be edited. You shouldn't have to touch the rest of it

variables <- read.table("variables.txt")

pattern_species <- variables[1,1]
target_species <- variables[2,1]
pattern_num <- variables[3,1]
orthopath <- paste0(variables[4,1], "/OMA/omaDir/Output/")
pattern_path <- paste0(variables[4,1], pattern_species, "/CoGAPS/")
target_path <- paste0(variables[4,1], target_species, "/CoGAPS/")


















#Loading the patterns
load(paste0(pattern_path, "gwCoGAPS_testlog_", pattern_species, "_result_", pattern_num, ".RData"))
load(paste0(pattern_path, pattern_species, "countsframe_filtered_log"))
shine <- ctsboimatlo

#Loading the target dataset
load(paste0(target_path, target_species, "countsframe_filtered_log"))
target <- ctsboimatlo
rm(ctsboimatlo)

#Gathering orthology information
#One of the above two go in the line below
orthom <- read.table(paste0(orthopath, "OrthologousMatrix.txt"), sep="\t", header=T)
#Taking only the rows that have info for our pattern species
gho <- colnames(orthom)
mark <- pattern_species
n <- match(mark,gho)
orthom <- orthom[which(orthom[ , n] != 0), ]
#Taking only the rows from the subsetted matrix that have info for our target species
mark <- target_species
h <- match(mark,gho)
orthom <- orthom[which(orthom[ , h] != 0), ]
#Now just taking the columns that interest us
orthom <- cbind(orthom[ , n], orthom[ , h])
orthom <- as.data.frame(orthom)

#Matching the orthology information to the gene names
numtoname <- read.table(paste0(orthopath, "Map-SeqNum-ID.txt"), sep="\t", quote="", header=T, fill=FALSE)
colnames(numtoname) <- c("species", "genenum", "name")
beardy <- numtoname[which(numtoname$species == pattern_species), ]
beardy <- as.data.frame(beardy)
batty <- numtoname[which(numtoname$species == target_species), ]
batty <- as.data.frame(batty)

colnames(orthom) <- c("genenum", "Bat")
orthobe <- left_join(orthom, beardy, by="genenum")
colnames(orthobe) <- c("Be.genenum", "genenum", "Bearded", "Be.name")
orthobe <- left_join(orthobe, batty, by="genenum")
colnames(orthobe) <- c("Be.genenum", "Ba.genenum", "Bearded", "Be.name", "Bat", "Ba.name")
orthobe$Ba.name <- str_split(orthobe$Ba.name, "_i", simplify=T)[,1]
orthobe$Be.name <- str_split(orthobe$Be.name, "_i", simplify=T)[,1]

#Trimming the target dataset down to just the rows that match the orthology information
target <- target[which(rownames(target) %in% orthobe$Ba.name), ]

#Changing the gene names in the target dataset to match those in the patterns
for (n in 1:nrow(target)) {
z <- rownames(target)[n]
q <- orthobe[which(orthobe$Ba.name == z), 4]
rownames(target)[n] <- q
}

###ProjectR
nerfy <- projectR(data = target, loadings=result, dataNames = NULL, loadingsNames = rownames(shine), NP = NA, full = FALSE)
nerfy_t <- t(nerfy)
pdf(paste0(variables[4, 1], "/ProjectR/", "ProjectR_", pattern_species, "_", variables[3, 1], "_into_", target_species, ".pdf"))
breaksList <- seq(-0.5, 1, by = 0.001)
pheatmap(nerfy_t, fontsize = 6, angle_col = 45,
         fontsize_col = 8, cluster_rows = F, cluster_cols = T, cellwidth = ,
         color = colorRampPalette(rev(brewer.pal(n = 11, name ="RdYlBu")))(length(breaksList)),
         show_rownames = T,
         breaks = breaksList)
dev.off()

write.table(nerfy_t, file = paste0(variables[4, 1], "/ProjectR/", "ProjectR_", pattern_species, "_", variables[3, 1], "_into_", target_species, ".txt"), quote = FALSE)
