#!/bin/bash
# Purpose: To add sample name to vcf files for each PTCL sample before merging into one vcf file
# NOTE: This script must be run in a conda environment with gatk4 installed. 

# make output directory
mkdir SampleNameInHeader

# loop through vcf files and run gatk RenameSampleInVcf for each. Adjust the basename so that the 'name' variable contains only the sample ID
for file in *.vcf; do name=$(basename ${file} _CanFam31.filtered.all.vcf);
gatk RenameSampleInVcf \
INPUT=${file} \
OUTPUT=SampleNameInHeader/${name}.CanFam31.vcf \
NEW_SAMPLE_NAME=${name}
done