#!/bin/bash
# To run gatk BaseRecalibrator on BAM files as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=BaseRecal
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=23:59:59
#SBATCH --output=log_BaseRecal_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

# Assign bam variable to first argument passed to script
bam=${1}

# Make directory for storage of tmp files
mkdir tmp

# Assign the sample ID portion of the BAM filename to a variable called 'name' and print it to the log file
name=$(basename ${bam} _sorted.bam_dedup_reads.bam_RG.bam); echo ${name}

# Run BaseRecalibrator with gatk. Make sure directory paths to reference genome files are consistent with your project’s file structure.
gatk BaseRecalibrator \
-I ${bam} \
-R /scratch/alpine/$USER/2023_PTCL_RNASeq/gatk/Input/GenomeData/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa \
--known-sites ../../Input/GenomeData/rename.broad_umass_canid_variants.1.2.vcf.gz \
--known-sites ../../Input/GenomeData/canis_lupus_familiaris.vcf.gz \
-O ${name}_recal_data.table \
--tmp-dir tmp