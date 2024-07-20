#!/bin/bash -l

#SBATCH
#SBATCH --job-name=TranspredJob
#SBATCH --partition=bigmem
#SBATCH -t 00-15:00:00
#SBATCH -N 2
#SBATCH --ntasks-per-node=24
#SBATCH --mail-type=end
#SBATCH --mail-user=you

cd $2/$5/Transdecoder

samples=$1
output_folder=$2
scripts=$3
yard=$4
species=$5
CoGAPSmin=$6
CoGAPSmax=$7

export PATH=$yard/TransDecoder-TransDecoder-v5.5.0:$PATH

TransDecoder.Predict -t $output_folder/$species/Trinity.Trinity.fasta --single_best_only

sbatch $scripts/trinity_to_splice_gen_transdecoder_splice_gen.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax