#!/bin/bash
# Purpose: To filter intronic and splite site variants and variants predicted to have low modifier effects in a maf file, to reduce the size of the maf file before merging and downstream analysis.
# Should be run after Ensembl Variant Effect Predictor tool and vcf2maf

# make output directory
mkdir FilteredMAFs

# loop through each maf file in the current directory and keep only the lines that do not contain the pattern "Intron", "MODIFIER", "Splice_Site", "Splice_Region", or "LOW"
for file in *.vep.maf; do name=$(basename ${file} .maf);
grep -v -e "Intron" -e "Splice_Site" -e "Splice_Region" -e "MODIFIER" -e "LOW" ${file} > FilteredMAFs/${name}.filtered.maf
done
