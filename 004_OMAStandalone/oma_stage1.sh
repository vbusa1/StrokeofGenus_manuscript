#!/bin/bash

#SBATCH
#SBATCH --job-name=omaJob
#SBATCH --partition=defq
#SBATCH -A sblacks1_bigmem
#SBATCH -t 3-0:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --array=1-300%300
#SBATCH --mail-type=end

cd /home/kweir6/data_sblacks1/Kurt/Hibernation/OMA/downloaded_pep

# create working directory
mkdir omaDir
cd omaDir

# create DB directory in working directory
mkdir DB

# copy FASTA files into DB directory
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/HUMAN.fa DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/HUMAN.splice DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/MOUSE.fa DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/MOUSE.splice DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/CAEEL.fa DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/CAEEL.splice DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/DROME.fa DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/DROME.splice DB/
cp /home-3/kweir6@jhu.edu/work/Kurt/downloaded_pep/omapeps/YEASO.fa DB/


# generate default parameter file

cp /home-3/work/Kurt/downloaded_pep/omaDir/parameters.drw .

# adjust parameters
vim parameters.drw

export NR_PROCESSES=300

# run OMA
/home/kweir6/data_sblacks1/Kurt/scripts/yard/OMA.2.5.0/bin/oma -s

