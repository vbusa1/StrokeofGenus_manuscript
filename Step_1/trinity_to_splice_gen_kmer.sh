#!/bin/bash -l

#SBATCH
#SBATCH --job-name=Tri_kmer_Job
#SBATCH --partition=bigmem
#SBATCH -t 00-02:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

cd $4
mkdir $2/$5/Trinity

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
		  --no_run_inchworm \
          --output $output_folder/$species/Trinity
		  
#--CPU needs to match --ntasks-per-node

sbatch $scripts/trinity_to_splice_gen_inchworm.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax
