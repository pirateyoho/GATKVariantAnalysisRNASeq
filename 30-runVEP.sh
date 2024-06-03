#!/bin/sh
# Purpose: To run Ensembl variant effect predictor tool on vcf files
# This script should be run in the local ensembl-vep directory where VEP is installed

# loop through vcf files and run vep on each. Adjust paths to where your vcf files are stored locally.
for file in /Users/eileen/VariantAnalysis/Input/*.vcf; do name=$(basename ${file} .vcf); echo ${name}; ./vep -i /Users/eileen/VariantAnalysis/Input/${name}.vcf -o /Users/eileen/VariantAnalysis/Output/${name}.vep.vcf --everything --species "canis_lupus_familiaris" --fork 4 --offline --cache --dir_cache "/Users/eileen/.vep" --cache_version "104" --fasta Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa --vcf
done
