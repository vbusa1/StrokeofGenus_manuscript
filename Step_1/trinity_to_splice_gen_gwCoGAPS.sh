#!/bin/bash -l

#SBATCH
#SBATCH --job-name=gwCoGAPSJob
#SBATCH --partition=bigmem
#SBATCH -t 00-02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

samples=$1
output_folder=$2
scripts=$3
yard=$4
species=$5
CoGAPSmin=$6
CoGAPSmax=$7

mkdir $2/$5/CoGAPS
cd $2/$5/CoGAPS

touch variables.txt
echo $samples > variables.txt
echo $output_folder >> variables.txt
echo $scripts >> variables.txt
echo $yard >> variables.txt
echo $species >> variables.txt
echo $CoGAPSmin >> variables.txt
echo $CoGAPSmax >> variables.txt

#Run the R script
time Rscript $scripts/trinity_to_splice_gen_gwCoGAPS.R

rm variables.txt
