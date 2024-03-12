#!/bin/bash
# Purpose: To annotate variant calls with snpEff. This step should follow gatk VariantFiltration.
# NOTE: This script must be run in a conda environment with snpEff installed. 

#SBATCH --job-name=snpEffAnnotate
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=00:30:00 # in my experience, took ~10 min for ~100 samples
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_snpEffAnnotation_%j.txt

#record data
 start=`date +%s`
 
# Annotate variants in vcf files with snpEff using their pre-built CanFam3.1 database, Canis_familaris
for file in *-filtered.vcf; do name=$(basename ${file} .vcf); echo ${name};
snpEff -stats ${name}_snpEff_summary.html -v CanFam3.1.99 ${file} > ${name}.ann.vcf
done