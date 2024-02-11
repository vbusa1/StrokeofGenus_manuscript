#!/bin/bash -l

#SBATCH
#SBATCH --job-name=ProjectRJob
#SBATCH --partition=bigmem
#SBATCH -t 00-00:30:00
#SBATCH --nodes=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

###Fill in these variables

pattern_species=MCF7
target_species=MCF7
pattern_num=2
output_folder=/path/to/StrokeofGenus
scripts=/path/to/StrokeofGenus/scripts

#make and change to the desired directory
mkdir $output_folder/ProjectR
cd $output_folder/ProjectR

touch variables.txt
echo $pattern_species > variables.txt
echo $target_species >> variables.txt
echo $pattern_num >> variables.txt
echo $output_folder>> variables.txt

#Run the R script
time Rscript $scripts/trinity_to_splice_gen_ProjectR.R

rm variables.txt