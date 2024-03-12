#!/bin/bash
# To run gatk BaseRecalibrator on BAM files following SplitNCigarReads as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=BaseRecal
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=4:00:00
#SBATCH --output=log_BaseRecal_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Assign bam variable to first argument passed to script
bam=${1}

# Run BaseRecalibrator with gatk. Make sure directory paths to reference genome files are consistent with your project’s file structure.
gatk BaseRecalibrator \
-I ${bam} \
-R ../../../../Input/GenomeData/referenceGenome.fa \
--known-sites ../../../../Input/GenomeData/filename.vcf.gz \
-O recal_data.table