#!/bin/bash -l

#SBATCH
#SBATCH --job-name=oma_start_Job
#SBATCH --partition=bigmem
#SBATCH -t 00-00:03:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

###Fill in these variables

output_folder=/path/to/StrokeofGenus
scripts=/path/to/StrokeofGenus/scripts
yard=path/to/yard

sbatch $scripts/trinity_to_splice_gen_oma_stage_1.sh $output_folder $scripts $yard
#sbatch $scripts/trinity_to_splice_gen_oma_stage_2.sh $output_folder $scripts $yard

