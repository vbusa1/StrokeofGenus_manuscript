#!/bin/bash -l

#SBATCH
#SBATCH --job-name=tri_rsemJob
#SBATCH --time=02-0:0:0
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --mail-type=ALL

#Export allowed thread number
export OMP_NUM_THREADS=12

module load bowtie2/2.4.1
module load cuda/11.1.0 

cd /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/13LGS_Liver

singularity exec -e /home/kweir6/trinityrnaseq /home/kweir6/data_sblacks1/Kurt/scripts/yard/trinityrnaseq-trinityrnaseq-519cfb7/util/align_and_estimate_abundance.pl \
--transcripts /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/Trinity-out-dir-13LGS.Trinity.fasta \
--seqType fq \
--samples_file /home/kweir6/data_sblacks1/Kurt/Hibernation/scripts/trinity_samples_13LGS_liver.txt \
--est_method RSEM \
--aln_method bowtie2 \
--gene_trans_map /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/Trinity-out-dir-13LGS.Trinity.fasta.gene_trans_map \
--output_dir /home/kweir6/data_sblacks1/Kurt/Hibernation/Trinity_output/Trinity-out-dir-13LGS/13LGS_Liver/rsem_outdir \
--thread_count 12

