#!/bin/bash -l

#SBATCH
#SBATCH --job-name=Tri_kmer_Job
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH -t 00-03:00:00
#SBATCH --mail-type=ALL


module load cuda/11.1.0 # also locates matching $CUDA_DRIVER location

Borg=/home/kweir6

cd $Borg

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER

singularity pull --name trinityrnaseq docker://trinityrnaseq/trinityrnaseq


