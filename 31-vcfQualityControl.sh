#!/bin/bash
# Purpose: To assess the quality of the called variants using the evaluation criteria Number of Indels & SNPs, Indel Ratio, and TiTv Ratio using gatk CollectVariantCallingMetrics. This step should be done after compressing and indexing filtered and annotated vcf files.
# NOTE: This script must be run in a conda environment with gatk4 installed. 

#SBATCH --job-name=vcfQC
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=2:00:00 # in my experience, takes about 1 hr per vcf.gz file
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_gatkCollectVariantCallingMetrics_%j.txt

#record data
 start=`date +%s`
 
# # Assign vcf variable to first argument passed to script
vcf=${1}

# Assign the sample ID portion of the vcf filename to a variable called 'name' and print it to the log file
name=$(basename ${vcf} .vcf); echo ${name}

# Run gatk CollectVariantCallingMetrics. DBSNP is a vcf file of known variants.
gatk CollectVariantCallingMetrics \
-INPUT ${vcf} \
-OUTPUT ${name}_eval \
-DBSNP ../../../../../../Input/GenomeData/rename.broad_umass_canid_variants.1.2.vcf.gz
