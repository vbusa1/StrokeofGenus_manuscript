#!/bin/bash -l

#SBATCH
#SBATCH --job-name=tri_rsem_refJob
#SBATCH --time=0-06:00:00
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH --mail-type=ALL

module load bowtie2/2.4.1
module load cuda/11.1.0 

cd /home/kweir6

singularity exec -e ./trinityrnaseq /home/kweir6/data_sblacks1/Kurt/scripts/yard/trinityrnaseq-trinityrnaseq-519cfb7/util/align_and_estimate_abundance.pl \
--transcripts /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/Trinity-out-dir-13LGS.Trinity.fasta \
--est_method RSEM \
--aln_method bowtie2 \
--gene_trans_map /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/Trinity-out-dir-13LGS.Trinity.fasta.gene_trans_map \
--prep_reference 

sbatch /home/kweir6/data_sblacks1/Kurt/Hibernation/scripts/trinity_N_rsem_abundance.sh
