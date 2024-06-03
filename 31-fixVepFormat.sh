#!/bin/sh
# Purpose: To fix the format of Ensembl VEP vcf files to a format that the vcf2maf tool can read
# This script should be run in the directory containing the vep.vcf files output by Ensemble VEP

# Loop through vep.vcf files in the current directory and fix format of each
for file in *.vep.vcf; do name=$(basename ${file} .vep.vcf); echo ${name};
perl -lne 's/\r//; print "$_";' ${name}.vep.vcf > ${name}.vep.fixed.vcf
done