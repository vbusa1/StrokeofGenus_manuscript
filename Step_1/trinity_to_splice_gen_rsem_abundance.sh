#!/bin/bash -l

#SBATCH
#SBATCH --job-name=tri_rsemJob
#SBATCH --time=02-0:0:0
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --mail-type=ALL
#SBATCH --mail-user=you

#Export allowed thread number
#Match --ntasks-per-node
export OMP_NUM_THREADS=12

mkdir $2/$5/RSEM
cd $2/$5/RSEM

samples=$1
output_folder=$2
scripts=$3
yard=$4
species=$5
CoGAPSmin=$6
CoGAPSmax=$7

singularity exec -e $4/trinityrnaseq $3/align_and_estimate_abundance.pl \
--transcripts $output_folder/$species/Trinity.Trinity.fasta \
--seqType fq \
--samples_file $samples \
--est_method RSEM \
--aln_method bowtie2 \
--prep_reference \
--gene_trans_map $output_folder/$species/Trinity.Trinity.fasta.gene_trans_map \
--output_dir $output_folder/$species/RSEM \
--thread_count 12

sbatch $scripts/trinity_to_splice_gen_gwCoGAPS.sh $samples $output_folder $scripts $yard $species $CoGAPSmin $CoGAPSmax

