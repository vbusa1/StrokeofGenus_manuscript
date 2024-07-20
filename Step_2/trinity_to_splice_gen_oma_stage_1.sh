#!/bin/bash

#SBATCH
#SBATCH --job-name=omaJob
#SBATCH --partition=parallel
#SBATCH -t 3-0:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --array=1-300%300
#SBATCH --mail-type=end
#SBATCH --mail-user=you

output_folder=$1
scripts=$2
yard=$3

cd $output_folder/OMA/omaDir

export NR_PROCESSES=300

# run OMA
$yard/OMA.2.5.0/bin/oma -s



