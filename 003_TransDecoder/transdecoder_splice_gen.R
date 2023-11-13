library(plyr)
library(dplyr)
library(seqinr)
library(phylotools)
library(tidyr)


species <- "bear"

#Reading in fasta of interest
peps <- seqinr::read.fasta(file=paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/", species, "/Trinity-out-dir-", species, ".Trinity.fasta.transdecoder.pep", sep=""), seqtype = "AA", as.string = T, whole.header = T)

#Adjusting the resultant object for gene name manipulations
pepnames <- as.data.frame(names(peps))
pepnames$`names(peps)` <- as.character(pepnames$`names(peps)`)

#Applying some string manipulations to make the gene name match what will be in the splice file
pepnames_split <- separate(data=pepnames, col = 'names(peps)', into = c("prot_name", "other"), sep = " ")
pepnames_split$prot_name <- substr(pepnames_split$prot_name,1,nchar(pepnames_split$prot_name)-3)
pepnames <- cbind(pepnames, pepnames_split$prot_name)

#Resaving the fasta with corrected names 
rename.fasta(infile = paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/", species, "/Trinity-out-dir-", species, ".Trinity.fasta.transdecoder.pep", sep=""), ref_table = pepnames, outfile = paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/", species, "/Trinity-out-dir-", species, ".Trinity.fasta.transdecoder.rename.fa", sep=""))



###Okay, here we're making the splice file
#Reading in the gene_trans_map of interest
gene_trans_map <- read.delim(paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/MARCC-produced/Natasha/Trinity-out-dir-", species, "/Trinity-out-dir-", species, ".Trinity.fasta.gene_trans_map", sep=""), header=F, sep="\t")
gene_trans_map$V2 <- as.character(gene_trans_map$V2)
gene_trans_map$V1 <- as.character(gene_trans_map$V1)

#filtering to match single orf stuff
peps_rename <- seqinr::read.fasta(file=paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/", species, "/Trinity-out-dir-", species, ".Trinity.fasta.transdecoder.rename.fa", sep=""), seqtype = "AA", as.string = T, whole.header = T)
peprenames <- as.character(names(peps_rename))
gene_trans_map <- subset(gene_trans_map, V2 %in% peprenames)


#collapsing
gorl <- as.data.frame(table(gene_trans_map$V1))
gorl <- gorl[which(gorl$Freq > 1), ]
gorl$Var1 <- as.character(gorl$Var1)
gorl$trans <- NA
for (n in (1:length(gorl$Var1))){
  j <- gorl$Var1[n]
  gorl$trans[n] <- paste(gene_trans_map[which(gene_trans_map$V1==j), "V2"], sep =";", collapse=";")
}
write.table(gorl$trans, file=paste0("/home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/", species, "/Trinity-out-dir-", species, ".Trinity.fasta.transdecoder.splice", sep=""), sep="", row.names=F, col.names=F, quote=F)