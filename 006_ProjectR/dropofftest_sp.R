## visualize ortholog drop-off
library("CoGAPS")
library("Matrix")
library("projectR")
library("plyr")
#library("tidyverse")
library(plyr)
library(dplyr)
library(stringr)
library("cowplot")
library("pheatmap")
library("RColorBrewer")

out <- "/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR"


# Chinese Alligator 2 into Grizzly
load("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/gwCoGAPS_testlog_ChineseAlligatorDS2_result_31.RData")
load("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ChineseAlligatorDS2countsframe_filtered_log")
orthom <- read.table("/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/omaDir10/Output/OrthologousMatrix.txt",
                     sep="\t", header=T)

n <- match("Trinity.out.dir.Chinese.Alligator", colnames(orthom))
h <- match("Trinity.out.dir.bear", colnames(orthom))

orthom <- orthom[which(orthom[ , n] != 0 &
                       orthom[ , h] != 0), ]
orthom <- cbind(orthom[ , n], orthom[ , h]) %>%
    as.data.frame()

numtoname <- read.table("/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/omaDir10/Output/Map-SeqNum-ID.txt", 
                        sep="\t", quote="", header=F, fill=F)
colnames(numtoname) <- c("species", "genenum", "name")
beardy <- numtoname[which(numtoname$species == "Trinity-out-dir-Chinese-Alligator"), ] %>%
    as.data.frame()
batty <- numtoname[which(numtoname$species == "Trinity-out-dir-Grizzly"), ] %>%
    as.data.frame()

colnames(orthom) <- c("genenum", "Bat")
orthobe <- left_join(orthom, beardy, by="genenum")
colnames(orthobe) <- c("Be.genenum", "genenum", "Bearded", "Be.name")
orthobe <- left_join(orthobe, batty, by="genenum")
colnames(orthobe) <- c("Be.genenum", "Ba.genenum", "Bearded", "Be.name", "Bat", "Ba.name")
orthobe$Ba.name <- str_split(orthobe$Ba.name, "_i", simplify=T)[,1]
orthobe$Be.name <- str_split(orthobe$Be.name, "_i", simplify=T)[,1]

genesie<-result@featureLoadings %>%
    as.data.frame()
rownames(genesie) <- rownames(ctsboimatlo)

conservie <- data.frame(matrix(NA,
                               nrow = nrow(genesie),
                               ncol = ncol(genesie)))

for (x in 1:ncol(conservie)){
    maxie <- slice_max(genesie, n=nrow(genesie), order_by=genesie[ , x])
    namesie <- rownames(maxie)
    presentie <- namesie %in% orthobe$Be.name
    
    v=0
    bosch <- c(rep(NA, nrow(genesie)))
    for (q in 1:nrow(genesie)) {
        if(presentie[q] == "TRUE"){
            v <- v+1
        }
        bosch[q] <- v
    }
    
    conservie[ , x] <- bosch
}

pdf("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR/dropoff_Chinese_Alligator_D2_into_Grizzly.pdf",
    width = 4, height = 4)
plot(conservie[ , 2], type="l", col="gray")
for(n in 3:ncol(conservie)){
    points(conservie[ , n], type="l", col="gray")
}
points(conservie[ , 1], type="l", col="red", lwd = 3)
points(conservie[ , 5], type="l", col="red", lwd = 3)
points(conservie[ , 8], type="l", col="red", lwd = 3)
points(conservie[ , 16], type="l", col="red", lwd = 3)
points(conservie[ , 21], type="l", col="red", lwd = 3)
points(conservie[ , 28], type="l", col="red", lwd = 3)
points(conservie[ , 30], type="l", col="red", lwd = 3)
points(conservie[ , 19], type="l", col="blue", lwd = 3)
dev.off()

##############################################
# Chinese Alligator 2 into Bearded Dragon
load("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/gwCoGAPS_testlog_ChineseAlligatorDS2_result_31.RData")
load("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ChineseAlligatorDS2countsframe_filtered_log")
orthom <- read.table("/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/omaDir10/Output/OrthologousMatrix.txt",
                     sep="\t", header=T)

n <- match("Trinity.out.dir.Chinese.Alligator", colnames(orthom))
h <- match("Trinity.out.dir.Bearded.Dragon", colnames(orthom))

orthom <- orthom[which(orthom[ , n] != 0 &
                           orthom[ , h] != 0), ]
orthom <- cbind(orthom[ , n], orthom[ , h]) %>%
    as.data.frame()

numtoname <- read.table("/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir5/omaDir10/Output/Map-SeqNum-ID.txt", 
                        sep="\t", quote="", header=F, fill=F)
colnames(numtoname) <- c("species", "genenum", "name")
beardy <- numtoname[which(numtoname$species == "Trinity-out-dir-Chinese-Alligator"), ] %>%
    as.data.frame()
batty <- numtoname[which(numtoname$species == "Trinity-out-dir-Bearded-Dragon"), ] %>%
    as.data.frame()

colnames(orthom) <- c("genenum", "Bat")
orthobe <- left_join(orthom, beardy, by="genenum")
colnames(orthobe) <- c("Be.genenum", "genenum", "Bearded", "Be.name")
orthobe <- left_join(orthobe, batty, by="genenum")
colnames(orthobe) <- c("Be.genenum", "Ba.genenum", "Bearded", "Be.name", "Bat", "Ba.name")
orthobe$Ba.name <- str_split(orthobe$Ba.name, "_i", simplify=T)[,1]
orthobe$Be.name <- str_split(orthobe$Be.name, "_i", simplify=T)[,1]

genesie<-result@featureLoadings %>%
    as.data.frame()
rownames(genesie) <- rownames(ctsboimatlo)

conservie <- data.frame(matrix(NA,
                               nrow = nrow(genesie),
                               ncol = ncol(genesie)))

for (x in 1:ncol(conservie)){
    maxie <- slice_max(genesie, n=nrow(genesie), order_by=genesie[ , x])
    namesie <- rownames(maxie)
    presentie <- namesie %in% orthobe$Be.name
    
    v=0
    bosch <- c(rep(NA, nrow(genesie)))
    for (q in 1:nrow(genesie)) {
        if(presentie[q] == "TRUE"){
            v <- v+1
        }
        bosch[q] <- v
    }
    
    conservie[ , x] <- bosch
}

pdf("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR/dropoff_Chinese_Alligator_D2_into_Bearded_Dragon.pdf",
    width = 4, height = 4)
plot(conservie[ , 1], type="l", col="gray")
for(n in 2:ncol(conservie)){
    points(conservie[ , n], type="l", col="gray")
}
points(conservie[ , 4], type="l", col="red", lwd = 3)
points(conservie[ , 24], type="l", col="red", lwd = 3)
points(conservie[ , 25], type="l", col="blue", lwd = 3)
points(conservie[ , 27], type="l", col="blue", lwd = 3)
dev.off()




