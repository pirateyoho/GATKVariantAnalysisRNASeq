#!/bin/bash
# Purpose: To remove variants that failed the filters specified in gatk VariantFiltration

# make output directory
mkdir PassedFiltering

# loop through each vcf file in the current directory and keep only the lines that do not contain "my_filter1"
for file in *.vcf; do name=$(basename ${file} .vcf);
bcftools view -i 'FILTER="PASS"' ${file} > PassedFiltering/${name}.pass.vcf
done
