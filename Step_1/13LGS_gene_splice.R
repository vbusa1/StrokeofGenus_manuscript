library(plyr)
library(dplyr)
library(seqinr)
library(phylotools)
library(tidyr)

GTF <- rtracklayer::import("GCF_016881025.1_HiC_Itri_2_genomic.gtf")

fasta <- seqinr::read.fasta(file="GCF_016881025.1_HiC_Itri_2_rna.fna", seqtype = "DNA", as.string = T, whole.header = T)
peps <- seqinr::read.fasta(file="GCF_016881025.1_HiC_Itri_2_translated_cds.faa", seqtype = "AA", as.string = T, whole.header = T

bob <- names(fasta)

kevin <- strsplit(bob, split= ".", fixed = T, perl = FALSE, useBytes = FALSE)
levin <- sapply(kevin,"[[",1)

vevin <- strsplit(bob, split= " ", fixed = T, perl = FALSE, useBytes = FALSE)
mevin <- sapply(vevin,"[[",1)

mlorp <- cbind(levin, mevin)

write.table(mlorp, file="GCF_016881025.1_HiC_Itri_2_rna.gene_trans_map", sep="\t", quote=F, row.names=F, col.names=F)

george <- 1:length(mevin)
for(n in 1:length(mevin)){
george[n] <- paste0(mevin[n], " ", "len=", nchar(fasta[[n]]), " ", "path=[0:0-", nchar(fasta[[n]])-1, "}", sep="")
}

morg <- as.data.frame(cbind(names(fasta), george))

rename.fasta(infile = "GCF_016881025.1_HiC_Itri_2_rna.fna", 
ref_table = morg, 
outfile = "GCF_016881025.1_HiC_Itri_2_rna.fna.Trinity.fasta")

