#!/bin/bash -l

#SBATCH
#SBATCH --job-name=Tri_start_Job
#SBATCH --partition=bigmem
#SBATCH -t 00-00:03:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

###Fill in these variables

samples=path/to/StrokeofGenus/scripts/samples.txt
output_folder=path/to/StrokeofGenus/
scripts=path/to/StrokeofGenus/scripts/
yard=path/to/yard
species=MCF7
CoGAPSmin=2
CoGAPSmax=10

sbatch $scripts/trinity_to_splice_gen_kmer.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax