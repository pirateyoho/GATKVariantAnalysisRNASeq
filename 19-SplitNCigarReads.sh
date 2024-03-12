#!/bin/bash
# To split reads containing Ns in their cigar string as part of the GATK variant analysis pipeline.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=SplitNCigarReads
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=4:00:00
#SBATCH --output=log_SplitNCigarReads_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Make an output directory for results and storage of tmp files:
mkdir SplitReads
mkdir temp

# Assign bam variable to first argument passed to script
bam=${1}

# Run SplitNCigarReads with gatk. Make sure directory paths to reference genome files are consistent with your project’s file structure.
gatk SplitNCigarReads \
--tmp-dir temp \
-R ../../../Input/GenomeData/referenceGenome.fa \
-I ${bam} \
-O SplitReads/${bam}_splitreads.bam