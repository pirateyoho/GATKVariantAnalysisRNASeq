#!/bin/bash
# Purpose: To convert a VCF file to TSV format that can be visualized in programs like Excel
# NOTE: This script must be run in a conda environment with gatk4 installed. 

#SBATCH --job-name=VCFtoTSV
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=01:00:00 
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_VCFtoTSV_%j.txt

#record data
 start=`date +%s`
 
# Loop through vcf files and run gatk VariantsToTable on each
for file in *filtered.ann.all.vcf.gz; do name=$(basename ${file} .vcf.gz); echo ${name};
gatk VariantsToTable \
-R ../../../../../../Input/GenomeData/CanFam31_FullGenome.fa \
-V ${file} \
-F CHROM -F POS -F FILTER -F TYPE -GF AD -GF DP \
--show-filtered \
-O ${name}.tsv 
done