#!/bin/bash

# Install lollipops package (first time only):
wget https://github.com/joiningdata/lollipops/releases/download/v1.7.2/lollipops_1.7.2_linux_amd64.tar.gz
tar -xzf lollipops_1.7.2_linux_amd64.tar.gz

# Space-delimited list of mutations for 1 gene from maf file
## Format: <AMINO><CODON><AMINO><#COLOR><@COUNT>
mutations="V48A E198K@2 A439T V669A V744M W780R@3 C846Y"

# Space-delimited list of Uniprot IDs for that gene
uniprots="A0A8C0MAP0 A0A8I3SA17 A0A8C0QMZ5"

#### Draw plots ####
## Format: lollipops [options] {-U UNIPROT_ID | GENE_SYMBOL} [PROTEIN CHANGES ...]
# Plots saved as SVG files by default
for uniprot in $uniprots
do
./lollipops -legend -labels -w=700 -U ${uniprot} ${mutations}
done
