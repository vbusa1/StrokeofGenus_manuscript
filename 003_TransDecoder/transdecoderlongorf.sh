#!/bin/bash -l

#SBATCH
#SBATCH --job-name=TranslongJob
#SBATCH --partition=bigmem
#SBATCH -A sblacks1_bigmem
#SBATCH -t 00-15:00:00
#SBATCH -N 2
#SBATCH --ntasks-per-node=24
#SBATCH --mail-type=end

export PATH=/home/kweir6/data_sblacks1/Kurt/scripts/yard/TransDecoder-TransDecoder-v5.5.0:$PATH

cd /home/kweir6/data_sblacks1/Kurt/Hibernation/transdecoder_out/13LGS

TransDecoder.LongOrfs -t /home/kweir6/scr4_sblacks1/Kurt/outputs/Hibernation/Trinity_output/Trinity-out-dir-13LGS/Trinity-out-dir-13LGS.Trinity.fasta

sbatch /home/kweir6/data_sblacks1/Kurt/Hibernation/scripts/transdecoderpredict.sh
