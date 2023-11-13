#Libraries bebe
library("CoGAPS")
library("Matrix")
library("projectR")
library("plyr")
library("dplyr")
library("stringr")
library("ggplot2")
library("cowplot")
library("pheatmap")
library("RColorBrewer")
library("fgsea")

#This section before the big break in code is the only section that should need to be edited. You shouldn't have to touch the rest of it

pattern_species <- "13LGS_Liver"
pattern_ortho <- "13LGS" #Note the difference from pattern_species. You may have to look this one up
pattern_numname <- "13LGS" #Not the difference from pattern_ortho. I think this will be consistent
pattern_num <- 3 #We will have agreed on this number beforehand

orthopath <- "/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/Output/"

pattern_path <- "/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/"

experiment_name<-"ProjectR_13LGSliver_into_Bear"

orthopath2 <- "/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/omaDir4/Output/"





#Loading the patterns
load(paste0(pattern_path, "gwCoGAPS_testlog_", pattern_species, "_result_", pattern_num, ".RData"))
load(paste0(pattern_path, pattern_species, "countsframe_filtered_log"))
shine <- ctsboimatlo

#Gathering human orthology information
orthom2 <- read.table(paste0(orthopath2, "OrthologousMatrix.txt"), sep="\t", header=T)
#Taking only the rows that have info for our pattern species
gho <- colnames(orthom2)
mark <- paste0("Trinity.out.dir.", pattern_ortho)
n <- match(mark,gho)
orthom2 <- orthom2[which(orthom2[ , n] != 0), ]
#Taking only the rows from the subsetted matrix that have info for human
mark <- paste0("HUMAN")
h <- match(mark,gho)
orthom2 <- orthom2[which(orthom2[ , h] != 0), ]
#Now just taking the columns that interest us
orthom2 <- cbind(orthom2[ , n], orthom2[ , h])
orthom2 <- as.data.frame(orthom2)

#Matching the orthology information to the gene names for reference dataset and human
numtoname <- read.table(paste0(orthopath2, "Map-SeqNum-ID.txt"), sep="\t", quote="", header=T, fill=FALSE)
colnames(numtoname) <- c("species", "genenum", "name")
beardy <- numtoname[which(numtoname$species == paste0("Trinity-out-dir-", pattern_numname)), ]
beardy <- as.data.frame(beardy)
batty <- numtoname[which(numtoname$species == "HUMAN"), ]
batty <- as.data.frame(batty)

colnames(orthom2) <- c("genenum", "Bat")
orthobe2 <- left_join(orthom2, beardy, by="genenum")
colnames(orthobe2) <- c("Be.genenum", "genenum", "Bearded", "Be.name")
orthobe2 <- left_join(orthobe2, batty, by="genenum")
colnames(orthobe2) <- c("Be.genenum", "Ba.genenum", "Bearded", "Be.name", "Bat", "Ba.name")
orthobe2$Ba.name <- str_split(orthobe2$Ba.name, "_i", simplify=T)[,1]
orthobe2$Be.name <- str_split(orthobe2$Be.name, "_i", simplify=T)[,1]

#Pulling out the z-scores for the genes
#These can be fed into like GSEA and stuff
genesie<-result@featureLoadings
rownames(genesie) <- rownames(shine)

genesie <- genesie[which(rownames(genesie) %in% orthobe2$Be.name), ]

useful2 <- unlist(str_split(orthobe2$Ba.name, " | "))
useful3 <- as.data.frame(str_extract(grep(pattern = "ENSG", x = useful2, value = TRUE), ".*(?=\\.)"))
colnames(useful3) <- "genename"
orthobe2$genename <- useful3$genename
orthobe3 <- orthobe2[ , c(4,7)]

genesie <- as.data.frame(genesie)
genesie$Be.name <- rownames(genesie)
genesie <- left_join(genesie, orthobe3, by="Be.name")

namesie <- read.table("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/Rearrange/mart_export (4).txt", sep="\t", header=T)
namesie <- namesie[ , c(1,3)]

colnames(genesie)[ncol(genesie)] <- "Gene.stable.ID"
genesie <- left_join(genesie, namesie, by="Gene.stable.ID")


#Looking at euthermia pattern
mark <- genesie[order(genesie$Pattern_3, decreasing=TRUE), ]
ranks <- mark$Pattern_3
names(ranks) <- mark$Gene.name

# this file of GO terms was downloaded from msigdb
pathways <- gmtPathways("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR/c5.go.bp.v2023.2.Hs.symbols.gmt")

gsea <- fgsea(pathways,
                  ranks, 
                  minSize = 25, 
                  maxSize = 500,
				  scoreType="pos")
gsea <- gsea[order(NES), ]
gsea
gsea <- apply(gsea,2,as.character)
write.table(gsea, file= "13LGSliver_into_bear_gsea_liver_euthermia.tsv", sep="\t", row.names=F, quote=F)


#Looking at torpid pattern
mark <- genesie[order(genesie$Pattern_1, decreasing=TRUE), ]
ranks <- mark$Pattern_1
names(ranks) <- mark$Gene.name

# this file of GO terms was downloaded from msigdb
pathways <- gmtPathways("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR/c5.go.bp.v2023.2.Hs.symbols.gmt")

gsea <- fgsea(pathways,
                  ranks, 
                  minSize = 25, 
                  maxSize = 500,
				  scoreType="pos")
gsea <- gsea[order(NES), ]
gsea
gsea <- apply(gsea,2,as.character)
write.table(gsea, file= "13LGSliver_into_bear_gsea_liver_torpor.tsv", sep="\t", row.names=F, quote=F)