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

###input variables here
###Update the variables to select the dataset and number of patterns that you want to present
experiment_name<-"ProjectR_13LGS_Blackshaw_into_13LGS_Brain"
outdir<-"/home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/CoGAPS/ProjectR/"
colorse <- c("#ca46c4", "#d96bc9", "#e68ccd")
shapese <- c(16, 7, 15, 12, 17, 16)

nerfy_t <- read.table(paste0(experiment_name, ".txt"))
###Visualization

#Here we are filling in the condition and tissue for each sample. This will be a pain, probably
rnerfy_t$condition <- c(rep(c(rep("Summer Active", 5), rep("Arousal", 5), rep("Interbout Arousal", 5), rep("Entrance", 5), rep("Late Torpor", 5), rep("Spring Dark", 5)), 3))
rnerfy_t$tissue <- c(rep("Hypothalamus", 30), rep("Forebrain", 30), rep("Medulla", 30))











rnerfy_t$condition <- factor(rnerfy_t$condition, levels=c("Summer Active", "Prehibernation", "Arousal", "Interbout Arousal", "Entrance", "Late Torpor", "Spring Dark"))
rnerfy_t$tissue <- factor(rnerfy_t$tissue, levels=c("Hypothalamus", "Forebrain", "Medulla"))

pdf(paste0(experiment_name, "_dotplots.pdf"), height = 4, width = 5)
for(n in 1:(ncol(rnerfy_t)-2)){
z <- colnames(rnerfy_t)[n]
print(
ggplot(data=rnerfy_t, aes_string(x="condition", y= z))+
facet_wrap(~tissue)+
geom_point(size = 4, aes(shape = condition , colour= tissue, fill=tissue))+
theme_classic() +

#This is setting the color of the data points based off of their tissue
scale_color_manual(guide=NULL, values = colorse) +
scale_fill_manual(guide=NULL, values = colorse) +

#This is setting the shape of data points based off their timepoint
scale_shape_manual(guide=NULL, values = shapese) +
theme(axis.text.x = element_text(angle = 90, h = 1))
)
}
dev.off()
