#!/bin/bash
# To run gatk ApplyBQSR on BAM files following BaseRecalibrator as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=WES_BQSR
#SBATCH --nodes=1
#SBATCH --ntasks=2 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=23:59:59
#SBATCH --output=log_WES_gatkBQSR_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

# # Make an output directory for results:
mkdir RecalibratedBases

# Make directory for storage of tmp files
mkdir tmp

# Assign bam variable to first argument passed to script
bam=${1}
# Assign the sample ID portion of the BAM filename to a variable called 'name' and print it to the log file
name=$(basename ${bam} _sorted.bam_dedup_reads.bam_RG.bam); echo ${name}

# Run ApplyBQSR with gatk. Make sure directory paths to reference genome files are consistent with your project’s file structure.
gatk ApplyBQSR \
-R /scratch/alpine/$USER/2023_PTCL_RNASeq/gatk/Input/GenomeData/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa \
-I ${bam} \
--bqsr-recal-file ${name}_recal_data.table \
--tmp-dir tmp \
-O RecalibratedBases/${name}_bqsrRecalReads.bam