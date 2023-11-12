library(tidyverse)

setwd("/Users/veronica/Documents/GO_hibernation/")

files <- list.files(pattern = ".tsv")


muscle <- grep("muscle", files, value = T)
muscle_data <- data.frame(pathway = c(),
                          pval = c(), 
                          padj = c(), 
                          log2err = c(),
                          ES = c(),   
                          NES = c(),    
                          size = c(),
                          sample = c())
for(m in muscle){
    data <- read_delim(m, delim = "\t")[,1:7] %>% as.data.frame()
    data <- data[which(grepl("GOBP", data$pathway) == T),]
    data$pathway <- gsub("GOBP_", "", data$pathway)
    data$pathway <- gsub("_", " ", data$pathway)
    data$sample = gsub(".tsv", "", m)
    muscle_data <- rbind(muscle_data, data)
}

muscle_diff <- data.frame(pathway = c(),
                          diff = c())
for(p in unique(muscle_data$pathway)){
    if(nrow(filter(muscle_data, pathway == p)) < 3){
        next()
    }
    find_diff_euthermia <- filter(muscle_data, 
                                  pathway == p, 
                                  sample %in% unique(grep("euthermia", muscle_data$sample, value = T)))$NES %>%
        mean()
    find_diff_torpor <- filter(muscle_data, 
                               pathway == p, 
                               sample %in% unique(grep("torpor", muscle_data$sample, value = T)))$NES %>%
        mean() 
    data <- data.frame(pathway = p,
                       diff = find_diff_euthermia - find_diff_torpor)
    muscle_diff <- rbind(muscle_diff, data)
}
muscle_interest_GO <- c(
    "REGULATION OF EXTENT OF CELL GROWTH",
    #"NEGATIVE REGULATION OF SMALL MOLECULE METABOLIC PROCESS",
    "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS",
    #"CIRCADIAN REGULATION OF GENE EXPRESSION",
    "POSITIVE REGULATION OF AUTOPHAGY",
    "REGULATION OF LIPID TRANSPORT",
    "NEGATIVE REGULATION OF CELL DEVELOPMENT",
    "MAINTENANCE OF CELL NUMBER",
    "ATP METABOLIC PROCESS",
    "REGULATION OF RELEASE OF SEQUESTERED CALCIUM ION INTO CYTOSOL",
    #"MUSCLE CELL MIGRATION",
    "SKELETAL MUSCLE ORGAN DEVELOPMENT",
    #"CELLULAR COMPONENT ASSEMBLY INVOLVED IN MORPHOGENESIS",
    #"MUSCLE ORGAN DEVELOPMENT",
    "STRIATED MUSCLE CELL DIFFERENTIATION",
    #"STRIATED MUSCLE CONTRACTION",
    "MUSCLE TISSUE DEVELOPMENT"
    )
muscle_plot <- muscle_data %>% filter(pathway %in% muscle_interest_GO)
ggplot(muscle_plot,
       aes(x = factor(sample, levels = c(
           "BeardedDragon_into_CA1_gsea_muscle_euthermia",
           "BeardedDragon_into_CA1_gsea_muscle_torpor", 
           "CA1_into_BeardedDragon_gsea_muscle_euthermia",
           "CA1_into_BeardedDragib_gsea_muscle_torpor")),
           y = factor(pathway, levels = c(
               # tissue maintenance
               "STRIATED MUSCLE CELL DIFFERENTIATION",
               "SKELETAL MUSCLE ORGAN DEVELOPMENT",
               "REGULATION OF RELEASE OF SEQUESTERED CALCIUM ION INTO CYTOSOL",
               "MUSCLE TISSUE DEVELOPMENT",
               "REGULATION OF EXTENT OF CELL GROWTH",
               "NEGATIVE REGULATION OF CELL DEVELOPMENT",
               "MAINTENANCE OF CELL NUMBER",
               # metabolism
               "ATP METABOLIC PROCESS",
               "REGULATION OF LIPID TRANSPORT",
               "POSITIVE REGULATION OF AUTOPHAGY",
               "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS"
           )),
           size = NES)) +
    geom_point(aes(alpha = -log(pval)),
               color = "#008000"
               ) +
    geom_point(shape = 1, stroke = 0.1) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 60, h = 1)) +
    scale_size(range = c(0.2, 10), limits = c(0.64, 1.96)) +
    scale_alpha(range = c(0.4, 1), limits = c(0, 10)) +
    labs(y = NULL, x = NULL) +
    scale_x_discrete(labels = c("Bearded Dragon Euthermia",
                                "Bearded Dragon Torpor",
                                "Alligator 1 Euthermia",
                                "Alligator 1 Torpor"))
ggsave("Muscle_GO.pdf", height = 4, width = 7)
#ggsave("legend.GO.pdf") # save plot without color





liver <- grep("liver", files, value = T)
liver_data <- data.frame(pathway = c(),
                          pval = c(), 
                          padj = c(), 
                          log2err = c(),
                          ES = c(),   
                          NES = c(),    
                          size = c(),
                          sample = c())
for(l in liver){
    data <- read_delim(l, delim = "\t")[,1:7] %>% as.data.frame()
    data <- data[which(grepl("GOBP", data$pathway) == T),]
    data$pathway <- gsub("GOBP_", "", data$pathway)
    data$pathway <- gsub("_", " ", data$pathway)
    data$sample = gsub(".tsv", "", l)
    liver_data <- rbind(liver_data, data)
}

liver_diff <- data.frame(pathway = c(),
                          diff = c())
for(p in unique(liver_data$pathway)){
    if(nrow(filter(liver_data, pathway == p)) < 3){
        next()
    }
    find_diff_euthermia <- filter(liver_data, 
                                  pathway == p, 
                                  sample %in% unique(grep("euthermia", liver_data$sample, value = T)))$NES %>%
        mean()
    find_diff_torpor <- filter(liver_data, 
                               pathway == p, 
                               sample %in% unique(grep("torpor", liver_data$sample, value = T)))$NES %>%
        mean() 
    data <- data.frame(pathway = p,
                       diff = find_diff_euthermia - find_diff_torpor)
    liver_diff <- rbind(liver_diff, data)
}
liver_interest_GO <- c(
    "REGULATION OF MYELOID LEUKOCYTE DIFFERENTIATION",
    #"NEGATIVE REGULATION OF MYELOID CELL DIFFERENTIATION",
    "NEGATIVE REGULATION OF T CELL PROLIFERATION",
    #"NEGATIVE REGULATION OF LEUKOCYTE PROLIFERATION",
    #"AMINO ACID BIOSYNTHETIC PROCESS",
    "AMINO ACID CATABOLIC PROCESS",
    #"HEPATICOBILIARY SYSTEM DEVELOPMENT",
    "CELLULAR LIPID CATABOLIC PROCESS",
    #"LIPID STORAGE",
    #"LIPID OXIDATION",
    "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS",
    "CARBOHYDRATE CATABOLIC PROCESS",
    #"REGULATION OF ORGAN GROWTH",
    #"NEGATIVE REGULATION OF CELL GROWTH",
    #"NEGATIVE REGULATION OF GROWTH",
    #"NEGATIVE REGULATION OF DEVELOPMENTAL GROWTH"
    "ELECTRON TRANSPORT CHAIN",
    #"REGULATION OF VASCULATURE DEVELOPMENT",
    #"NEGATIVE REGULATION OF VASCULATURE DEVELOPMENT",
    #"PROTEIN MONOUBIQUITINATION",
    #"PROTEIN K63 LINKED UBIQUITINATION",
    #"LEUKOCYTE CELL CELL ADHESION",
    #"POSITIVE REGULATION OF CELL CELL ADHESION",
    #"HETEROTYPIC CELL CELL ADHESION",
    "APICAL JUNCTION ASSEMBLY",
    "TIGHT JUNCTION ORGANIZATION",
    "DICARBOXYLIC ACID METABOLIC PROCESS",
    "POSITIVE REGULATION OF TORC1 SIGNALING"
)
liver_plot <- liver_data %>% filter(pathway %in% liver_interest_GO)
ggplot(liver_plot,
       aes(x = factor(sample, levels = c(
           "13LGSliver_into_bear_gsea_liver_euthermia",
           "13LGSliver_into_bear_gsea_liver_torpor",   
           "Bear_into_13LGSliver_gsea_liver_euthermia",
           "Bear_into_13LGSliver_gsea_liver_torpor")),
           y = factor(pathway, levels = c(
               # cell-cell interaction
               "APICAL JUNCTION ASSEMBLY",
               "TIGHT JUNCTION ORGANIZATION",
               # immune
               "REGULATION OF MYELOID LEUKOCYTE DIFFERENTIATION",
               "NEGATIVE REGULATION OF T CELL PROLIFERATION",
               # metabolism
               "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS",
               "POSITIVE REGULATION OF TORC1 SIGNALING",
               "AMINO ACID CATABOLIC PROCESS",
               "CELLULAR LIPID CATABOLIC PROCESS",
               "CARBOHYDRATE CATABOLIC PROCESS",
               "ELECTRON TRANSPORT CHAIN",
               "DICARBOXYLIC ACID METABOLIC PROCESS"
           )),
           size = NES)) +
    geom_point(aes(alpha = -log(pval)),
               color = "#FFD700") +
    geom_point(shape = 1, stroke = 0.1) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 60, h = 1)) +
    scale_size(range = c(0.2, 10), limits = c(0.64, 1.96)) +
    scale_alpha(range = c(0.4, 1), limits = c(0, 10)) +
    labs(y = NULL, x = NULL) +
    scale_x_discrete(labels = c("13 LGS Euthermia",
                                "13 LGS Torpor",
                                "Bear Euthermia",
                                "Bear Torpor"))
ggsave("Liver_GO.pdf", height = 4, width = 6)





fat <- grep("fat", files, value = T)
fat_data <- data.frame(pathway = c(),
                          pval = c(), 
                          padj = c(), 
                          log2err = c(),
                          ES = c(),   
                          NES = c(),    
                          size = c(),
                          sample = c())
for(f in fat){
    data <- read_delim(f, delim = "\t")[,1:7] %>% as.data.frame()
    data <- data[which(grepl("GOBP", data$pathway) == T),]
    data$pathway <- gsub("GOBP_", "", data$pathway)
    data$pathway <- gsub("_", " ", data$pathway)
    data$sample = gsub(".tsv", "", f)
    fat_data <- rbind(fat_data, data)
}

fat_diff <- data.frame(pathway = c(),
                          diff = c())
for(p in unique(fat_data$pathway)){
    if(nrow(filter(fat_data, pathway == p)) < 3){
        next()
    }
    find_diff_euthermia <- filter(fat_data, 
                                  pathway == p, 
                                  sample %in% unique(grep("euthermia", fat_data$sample, value = T)))$NES %>%
        mean()
    find_diff_torpor <- filter(fat_data, 
                               pathway == p, 
                               sample %in% unique(grep("torpor", fat_data$sample, value = T)))$NES %>%
        mean() 
    data <- data.frame(pathway = p,
                       diff = find_diff_euthermia - find_diff_torpor)
    fat_diff <- rbind(fat_diff, data)
}
fat_interest_GO <- c(
    #"THIOESTER BIOSYNTHETIC PROCESS",
    "FATTY ACID DERIVATIVE METABOLIC PROCESS",
    "THIOESTER METABOLIC PROCESS",
    #"OXIDATIVE PHOSPHORYLATION",
    "OLEFINIC COMPOUND METABOLIC PROCESS",
    "STEROL METABOLIC PROCESS",
    "UNSATURATED FATTY ACID METABOLIC PROCESS",
    "POSITIVE REGULATION OF STRESS FIBER ASSEMBLY",
    "POSITIVE REGULATION OF ACTIN FILAMENT BUNDLE ASSEMBLY",
    #"REGULATION OF ACTIN FILAMENT BUNDLE ASSEMBLY",
    #"PROTEIN AUTOUBIQUITINATION",
    "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS",
    "LONG CHAIN FATTY ACID METABOLIC PROCESS"
    #"CYCLIC NUCLEOTIDE MEDIATED SIGNALING"
)
fat_plot <- fat_data %>% filter(pathway %in% fat_interest_GO)
ggplot(fat_plot,
       aes(x = factor(sample, levels = c(
           "Bear_into_CA2_gsea_fat_euthermia",
           "Bear_into_CA2_gsea_fat_torpor",
           "CA2_into_Bear_gsea_fat_euthermia",
           "CA2_into_Bear_gsea_fat_torpor" )),
           y = factor(pathway, levels = c(
               # stress response
               "POSITIVE REGULATION OF STRESS FIBER ASSEMBLY",
               "POSITIVE REGULATION OF ACTIN FILAMENT BUNDLE ASSEMBLY",
               # metabolism
               "FATTY ACID DERIVATIVE METABOLIC PROCESS",
               "THIOESTER METABOLIC PROCESS",
               "OLEFINIC COMPOUND METABOLIC PROCESS",
               "STEROL METABOLIC PROCESS",
               "UNSATURATED FATTY ACID METABOLIC PROCESS",
               "LONG CHAIN FATTY ACID METABOLIC PROCESS",
               "NEGATIVE REGULATION OF MRNA METABOLIC PROCESS"
           )),
           size = NES)) +
    geom_point(aes(alpha = -log(pval)),
               color = "#94AD00") +
    geom_point(shape = 1, stroke = 0.1) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 60, h = 1)) +
    scale_size(range = c(0.2, 10), limits = c(0.64, 1.96)) +
    scale_alpha(range = c(0.4, 1), limits = c(0, 10)) +
    labs(y = NULL, x = NULL) +
    scale_x_discrete(labels = c("Bear Euthermia",
                                "Bear Torpor",
                                "Alligator 2 Euthermia",
                                "Alligator 2 Torpor"))
ggsave("Fat_GO.pdf", height = 3.5, width = 6.3)





brain <- grep("brain", files, value = T)
brain_data <- data.frame(pathway = c(),
                          pval = c(), 
                          padj = c(), 
                          log2err = c(),
                          ES = c(),   
                          NES = c(),    
                          size = c(),
                          sample = c())
for(b in brain){
    data <- read_delim(b, delim = "\t")[,1:7] %>% as.data.frame()
    data <- data[which(grepl("GOBP", data$pathway) == T),]
    data$pathway <- gsub("GOBP_", "", data$pathway)
    data$pathway <- gsub("_", " ", data$pathway)
    data$sample = gsub(".tsv", "", b)
    brain_data <- rbind(brain_data, data)
}

brain_diff <- data.frame(pathway = c(),
                          diff = c())
for(p in unique(brain_data$pathway)){
    if(nrow(filter(brain_data, pathway == p)) < 3){
        next()
    }
    find_diff_euthermia <- filter(brain_data, 
                                  pathway == p, 
                                  sample %in% unique(grep("euthermia", brain_data$sample, value = T)))$NES %>%
        mean()
    find_diff_torpor <- filter(brain_data, 
                               pathway == p, 
                               sample %in% unique(grep("torpor", brain_data$sample, value = T)))$NES %>%
        mean() 
    data <- data.frame(pathway = p,
                       diff = find_diff_euthermia - find_diff_torpor)
    brain_diff <- rbind(brain_diff, data)
}
brain_interest_GO <- c(
    #"REGULATION OF TISSUE REMODELING",
    #"POSITIVE REGULATION OF PHAGOCYTOSIS",
    "PROGRAMMED NECROTIC CELL DEATH",
    "NEGATIVE REGULATION OF SYNAPTIC TRANSMISSION",
    #"MAINTENANCE OF CELL NUMBER",
    #"REGULATION OF NEURON MIGRATION",
    "REGULATION OF ACTION POTENTIAL",
    #"ELECTRON TRANSPORT CHAIN",
    "NEUROTRANSMITTER UPTAKE",
    #"GLYCOLYTIC PROCESS",
    "FEEDING BEHAVIOR",
    #"REGULATION OF POSTSYNAPSE ORGANIZATION",
    #"SYNAPTIC SIGNALING",
    "DICARBOXYLIC ACID METABOLIC PROCESS",
    "POSITIVE REGULATION OF CARBOHYDRATE METABOLIC PROCESS",
    "REGULATION OF MITOCHONDRIAL MEMBRANE POTENTIAL",
    "REGULATION OF AXON EXTENSION",
    "OLIGODENDROCYTE DIFFERENTIATION"
)
brain_plot <- brain_data %>% filter(pathway %in% brain_interest_GO)
ggplot(brain_plot,
       aes(x = factor(sample, levels = c(
           "BeardedDragon_into_CA2_gsea_brain_euthermia",
           "BeardedDragon_into_CA2_gsea_brain_torpor",    
           "CA2_into_BeardedDragon_gsea_brain_euthermia",  
           "CA2_into_BeardedDragib_gsea_brain_torpor")),
           y = factor(pathway, levels = c(
               # neuron maintenance
               "PROGRAMMED NECROTIC CELL DEATH",
               "REGULATION OF AXON EXTENSION",
               "REGULATION OF ACTION POTENTIAL",
               "OLIGODENDROCYTE DIFFERENTIATION",
               "NEUROTRANSMITTER UPTAKE",
               "NEGATIVE REGULATION OF SYNAPTIC TRANSMISSION",
               # metabolism
               "FEEDING BEHAVIOR",
               "DICARBOXYLIC ACID METABOLIC PROCESS",
               "POSITIVE REGULATION OF CARBOHYDRATE METABOLIC PROCESS",
               "REGULATION OF MITOCHONDRIAL MEMBRANE POTENTIAL"
           )),
           size = NES)) +
    geom_point(aes(alpha = -log(pval)),
               color = "#BA00BE") +
    geom_point(shape = 1, stroke = 0.1) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 60, h = 1)) +
    scale_size(range = c(0.2, 10), limits = c(0.64, 1.96)) +
    scale_alpha(range = c(0.4, 1), limits = c(0, 10)) +
    labs(y = NULL, x = NULL) +
    scale_x_discrete(labels = c("Bearded Dragon Euthermia",
                                "Bearded Dragon Torpor",
                                "Alligator 2 Euthermia",
                                "Alligator 2 Torpor"))
ggsave("Brain_GO.pdf", height = 4, width = 6.5)


save.image("visualize_GO.RData")

