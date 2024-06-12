#!/bin/sh
# Purpose: To convert vcf to maf files using the vcf2maf tool. Should be done after running Ensembl Variant Effect Predictor on vcf files.
# This script should be run locally in the directory where vcf2maf was installed

# loop through vcf files and run vcf2maf on each
for file in /Users/eileen/VariantAnalysis/Output/*.vep.fixed.vcf; do name=$(basename ${file} .vep.fixed.vcf); echo ${name};  
perl vcf2maf.pl \
--input-vcf /Users/eileen/VariantAnalysis/Output/${name}.vep.fixed.vcf \
--output-maf /Users/eileen/VariantAnalysis/Output/${name}.vep.maf \
--inhibit-vep \
--tumor-id ${name} \
--species Canis_lupus_familiaris \
--ncbi-build CanFam31 \
-ref-fasta /Users/eileen/ensembl-vep/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa \
--retain-fmt GT,AD,AF,DP,F1R2,F2R1,SB; 
done
