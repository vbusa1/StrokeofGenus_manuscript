#!/bin/bash -l

#SBATCH
#SBATCH --job-name=Tri_inchw_Job
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH -t 02-00:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mail-type=ALL


module load cuda/11.1.0 

cd /home/kweir6

singularity exec -e ./trinityrnaseq Trinity \
          --seqType fq \
          --samples_file /home/kweir6/data_sblacks1/Kurt/Hibernation/scripts/trinity_samples_bearded_dragon.txt \
          --max_memory 300G --CPU 20 \
		  --no_run_chrysalis \
          --output /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-Bearded-Dragon \
		  
sbatch /home/kweir6/data_sblacks1/Kurt/Hibernation/scripts/trinity_N_chrysalis.sh
