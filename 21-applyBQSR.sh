#!/bin/bash
# To run gatk ApplyBQSR on BAM files following BaseRecalibrator as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=BaseRecal
#SBATCH --nodes=1
#SBATCH --ntasks=16 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=23:59:59
#SBATCH --output=log_BaseRecal_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# # Make an output directory for results:
mkdir RecalibratedBases
# Assign bam variable to first argument passed to script
bam=${1}

# Run ApplyBQSR with gatk. Make sure directory paths to reference genome files are consistent with your project’s file structure.
gatk ApplyBQSR \
-R ../../../Input/GenomeData/CanFam31_FullGenome.fa \
-I ${bam} \
--bqsr-recal-file ${bam}_recal_data.table \
-O RecalibratedBases/${bam}_recal_reads.bam