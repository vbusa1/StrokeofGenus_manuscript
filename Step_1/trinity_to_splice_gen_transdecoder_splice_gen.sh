#!/bin/bash -l

#SBATCH
#SBATCH --job-name=splice_Job
#SBATCH --partition=defq
#SBATCH -t 00-0:30:00
#SBATCH --nodes=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

cd $2/$5/Transdecoder

samples=$1
output_folder=$2
scripts=$3
yard=$4
species=$5
CoGAPSmin=$6
CoGAPSmax=$7

touch variables.txt
echo $samples > variables.txt
echo $output_folder >> variables.txt
echo $scripts >> variables.txt
echo $yard >> variables.txt
echo $species >> variables.txt

#Run the R script
time Rscript $scripts/trinity_to_splice_gen_transdecoder_splice_gen.R

rm variables.txt

sbatch $scripts/trinity_to_splice_gen_rsem_abundance.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax