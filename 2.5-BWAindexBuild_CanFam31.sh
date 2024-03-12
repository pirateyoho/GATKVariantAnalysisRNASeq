#!/bin/bash

#SBATCH --job-name=BAMalignWES

#SBATCH --nodes=1
#SBATCH --ntasks=4       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=8:00:00   # set time; default = 4 hours
#SBATCH --mem=32GB
#SBATCH --mail-type=END,FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_BWAindex_%j.txt  # this will capture all output in a logfile with %j as the job #

### NOTE: Run this script in an activated conda environment where BWA is installed.

# index reference genome fasta file
bwa index Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa