#!/bin/bash
# Purpose: To compress filtered and annotated vcf files to the vcf.gz format and index them. This step should follow variant annotation with snpEff.
# NOTE: This script must be run in a conda environment with samtools installed. 

#SBATCH --job-name=vcfCompress
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=23:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_vcfCompressAndIndex_%j.txt

#record data
 start=`date +%s`
 
# loop through filtered and annotated vcf files, compressing each to vcf.gz format, then indexing.
for file in *ann.vcf; do bgzip -c ${file} > ${file}.gz;
tabix -f -p vcf ${file}.gz
done