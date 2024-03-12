#!/bin/bash
# To mark duplicated reads in BAM files sorted by coordinate using Picard.
## NOTE: This script must be run in a conda environment with Picard installed.

#SBATCH --job-name=PicardDedup
#SBATCH --nodes=1
#SBATCH --ntasks=8 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=16:00:00 # up to 24 hours
#SBATCH --output=log_PicardDedup_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Make an output directory for results and for storage of tmp files (if TMP_DIR is not changed, you will likely run out of space trying to run this script)
mkdir ../Output/PicardDedupOutput
mkdir tmp

# Assign bam variable to first argument passed to script
bam=${1}

# Mark duplicate reads with Picard
picard MarkDuplicates \
TMP_DIR=tmp \
INPUT=${bam} \
OUTPUT=../Output/PicardDedupOutput/${bam}_dedup_reads.bam \
METRICS_FILE=../Output/PicardDedupOutput/${bam}_metrics.txt