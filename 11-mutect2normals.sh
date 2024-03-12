#!/bin/bash
# To run gatk Mutect2 on BAM files following ApplyBQSR as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=WES_Mutect2
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --time=23:59:59
#SBATCH --output=log_WES_Mutect2_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

#record data
 start=`date +%s`

# Assign bam variable to first argument passed to script
bam=${1}
# Assign the sample ID portion of the BAM filename to a variable called 'name' and print it to the log file
name=$(basename ${bam} _bqsrRecalReads.bam); echo ${name}

#Step 1. Run Mutect2 in tumor-only mode for each normal sample.
gatk Mutect2 \
-R ../../Input/GenomeData/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa \
--germline-resource ../../Input/GenomeData/rename.broad_umass_canid_variants.1.2.vcf.gz \
-max-mnp-distance 0 \
-I ${bam} \
-O ../Mutect2/${name}.vcf.gz