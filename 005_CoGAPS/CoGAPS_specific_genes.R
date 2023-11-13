library(cowplot)
library(plyr)
library(dplyr)
library(Matrix)
library(ggplot2)
library(SparseM)
library(boot)
library(data.table)
library(stringr)
library(CoGAPS)
library(pracma)

#Heading to the folder with the data that we want to use
cd("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS")

load("../gwCoGAPS_testlog_DjungarianHamster_result_2.RData")
load("../DjungarianHamstercountsframe_filtered_log")
subname <- ""

pattern_ortho <- "Djungarian.Hamster" #.
pattern_numname <- "Djungarian-Hamster" #-

orthopath <- "/home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep/omaDir/Output/"







orthom <- read.table(paste0(orthopath, "OrthologousMatrix.txt"), sep="\t", header=T)
#Taking only the rows that have info for our pattern species
gho <- colnames(orthom)
mark <- paste0("Trinity.out.dir.", pattern_ortho)
n <- match(mark,gho)
orthom <- orthom[which(orthom[ , n] != 0), ]
#Taking only the rows from the subsetted matrix that have info for our target species
mark <- "HUMAN"
h <- match(mark,gho)
orthom <- orthom[which(orthom[ , h] != 0), ]
orthom <- cbind(orthom[ , n], orthom[ , h])
orthom <- as.data.frame(orthom)

numtoname <- read.table(paste0(orthopath, "Map-SeqNum-ID.txt"), sep="\t", quote="", header=F, fill=FALSE)
colnames(numtoname) <- c("species", "genenum", "name")
beardy <- numtoname[which(numtoname$species == paste0("Trinity-out-dir-", pattern_numname)), ]
beardy <- as.data.frame(beardy)
batty <- numtoname[which(numtoname$species == "HUMAN"), ]
batty <- as.data.frame(batty)

colnames(orthom) <- c("genenum", "Bat")
orthobe <- left_join(orthom, beardy, by="genenum")
colnames(orthobe) <- c("Be.genenum", "genenum", "Bearded", "Be.name")
orthobe <- left_join(orthobe, batty, by="genenum")
colnames(orthobe) <- c("Be.genenum", "Ba.genenum", "Bearded", "Be.name", "Bat", "Ba.name")
orthobe$Ba.name <- str_split(orthobe$Ba.name, "_i", simplify=T)[,1]
orthobe$Be.name <- str_split(orthobe$Be.name, "_i", simplify=T)[,1]


weight <- result@featureLoadings
rownames(weight) <- rownames(ctsboimatlo)


nMeasurements <- nrow(weight)
nPatterns <- ncol(weight)
rowMax <- t(apply(weight, 1, function(x) x / max(x)))
sstat <- matrix(NA, nrow=nMeasurements, ncol=nPatterns, dimnames=dimnames(weight))
ssranks <- matrix(NA, nrow=nMeasurements, ncol=nPatterns, dimnames=dimnames(weight))
ssgenes <- matrix(NA, nrow=nMeasurements, ncol=nPatterns, dimnames=NULL)
for (i in 1:nPatterns)
        {
            lp <- rep(0,nPatterns)
            lp[i] <- 1
            sstat[,i] <- unlist(apply(rowMax, 1, function(x) sqrt(t(x-lp) %*% (x-lp))))
            ssranks[,i] <- rank(sstat[,i])
            ssgenes[,i] <- names(sort(sstat[,i], decreasing=FALSE, na.last=TRUE))
        }
        {
            geneThresh <- sapply(1:nPatterns, function(x) min(which(ssranks[ssgenes[,x],x] > apply(ssranks[ssgenes[,x],],1,min))))
            ssgenes.th <- sapply(1:nPatterns, function(x) ssgenes[1:geneThresh[x],x])
        }
#ssgenes.th <- list(ssgenes.th[ ,1], ssgenes.th[ ,2])
ghorman <- t(plyr::ldply(ssgenes.th, rbind))
write.csv(ghorman, file=paste0(pattern_numname, "_", subname, "_patterngenes.csv", sep=""))

orthobe$Be.name <- as.character(orthobe$Be.name)
for(y in 1:length(ssgenes.th)){
ssgenes.th[[y]] <- ssgenes.th[[y]][which(ssgenes.th[[y]] %in% orthobe$Be.name)]
}
ghorman <- t(plyr::ldply(ssgenes.th, rbind))
write.csv(ghorman, file=paste0(pattern_numname, "_", subname, "_patterngenes_filtered.csv", sep=""))

for(j in 1:length(ssgenes.th)){
for(n in 1:length(ssgenes.th[[j]])){
ssgenes.th[[j]][n] <- orthobe[which(orthobe$Be.name == ssgenes.th[[j]][n]), "Ba.name"]
}
}
ghorman <- t(plyr::ldply(ssgenes.th, rbind))
write.csv(ghorman, file=paste0(pattern_numname, "_", subname, "_patterngenes_filtered_names.csv", sep=""))



useful <- read.table("SyrianHamster_patterngenes_filtered_names.csv", sep=",", header=T)
namesie <- read.table("mart_export (4).txt", sep="\t", header=T)
namesie <- namesie[ , c(1,3)]
printme <- list()
for(n in 2:ncol(useful)){
useful2 <- unlist(str_split(useful[ ,n], " | "))
useful3 <- as.data.frame(str_extract(grep(pattern = "ENSG", x = useful2, value = TRUE), ".*(?=\\.)"))
colnames(useful3) <- "Gene.stable.ID"
useful3 <- left_join(useful3, namesie, by = "Gene.stable.ID")
printme[[n-1]] <- useful3[,2]
}

ghorman <- t(plyr::ldply(printme, rbind))
write.csv(ghorman, file="SyrianHamster_patterngenes_filtered_names_better.csv")

