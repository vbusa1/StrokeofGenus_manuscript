library("Matrix")
library("SparseM")
library("CoGAPS")
library("ggplot2")
library("cowplot")
library("pheatmap")
library("RColorBrewer")
library("plyr")
library("dplyr")

#input variables here
#Update the name
experiment_name<-"gwCoGAPS_testlog_13LGS_Blackshaw"
nPatterns<-10
outdir<-"/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/"

load(paste(outdir, experiment_name, "_result_", nPatterns, ".RData", sep=""))


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
