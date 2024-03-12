#!/bin/bash
# To mark duplicated reads in BAM files sorted by coordinate using gatk.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=gatkDedup
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=4:00:00 # up to 24 hours
#SBATCH --output=log_gatkDedup_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

#record data
 start=`date +%s`

# Make an output directory for results and for storage of tmp files (if TMP_DIR is not changed, you will likely run out of space trying to run this script)
mkdir ../../gatkDedupOutput
mkdir tmp

# Assign bam variable to first argument passed to script
bam=${1}

# Mark duplicate reads with Picard
gatk MarkDuplicates \
-I ${bam} \
-O ../../gatkDedupOutput/${bam}_dedup_reads.bam \
--TMP_DIR tmp \
--METRICS_FILE ../../gatkDedupOutput/${bam}_metrics.txt