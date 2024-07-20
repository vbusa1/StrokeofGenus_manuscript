#!/bin/bash -l

#SBATCH
#SBATCH --job-name=Tri_distr_Job
#SBATCH --partition=bigmem
#SBATCH -t 00-15:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mail-type=end
#SBATCH --mail-user=you

cd $4

samples=$1
output_folder=$2
scripts=$3
yard=$4
species=$5
CoGAPSmin=$6
CoGAPSmax=$7

singularity exec -e ./trinityrnaseq Trinity \
          --seqType fq \
          --samples_file $samples \
          --max_memory 300G --CPU 20 \
          --output $output_folder/$species/Trinity

#--CPU needs to match --ntasks-per-node

sbatch $scripts/trinity_to_splice_gen_transdecoder_longorf.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax
