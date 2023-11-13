#!/bin/bash

#SBATCH
#SBATCH --job-name=omaJob
#SBATCH --partition=defq
#SBATCH -A sblacks1_bigmem
#SBATCH -t 00-72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --mail-type=end

cd omaDir

# run OMA
/home/kweir6/data_sblacks1/Kurt/scripts/yard/OMA.2.5.0/bin/oma -n 48
