#!/bin/bash

#SBATCH
#SBATCH --job-name=omaJob
#SBATCH --partition=parallel
#SBATCH -t 00-72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --mail-type=end
#SBATCH --mail-user=you

output_folder=$1
scripts=$2
yard=$3

cd $output_folder/OMA/omaDir

# run OMA
$yard/OMA.2.5.0/bin/oma -n 48

#-n needs to match --ntasks-per-node
