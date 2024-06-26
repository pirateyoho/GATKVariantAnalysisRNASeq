#!/bin/bash
# Purpose: To merge indel and snp vcf files for each sample into one vcf file. Should be performed after vcf filtration steps.
# NOTE: This script must be run in a conda environment with gatk4 installed. 

#SBATCH --job-name=vcfMerge
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=01:00:00 
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_vcfMerge_%j.txt

#record data
 start=`date +%s`

# make output directory
mkdir CombinedSNPandINDEL

# loop through samples and run gatk MergeVcf to merge the indel vcf and snp vcf for each sample
for file in *.snps-filtered.pass.vcf; do name=$(basename ${file} .snps-filtered.pass.vcf); echo ${name};
gatk MergeVcfs \
-I ${name}.snps-filtered.pass.vcf \
-I ${name}.indels-filtered.pass.vcf \
-O CombinedSNPandINDEL/${name}.filtered.all.vcf
done
