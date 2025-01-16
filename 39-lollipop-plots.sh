#!/bin/bash

# Install lollipops package (first time only):
wget https://github.com/joiningdata/lollipops/releases/download/v1.7.2/lollipops_1.7.2_linux_amd64.tar.gz
tar -xzf lollipops_1.7.2_linux_amd64.tar.gz

# Space-delimited list of mutations for 1 gene from maf file
## Format: <AMINO><CODON><AMINO><#COLOR><@COUNT>
mutations="E230K M1571Ifs*52@3 C1368W Q743H Y2005H R1224P"

# Space-delimited list of Uniprot IDs for that gene
uniprots="A0A8P0NCQ6 A0A8I3Q1L1 A0A8I3Q267 A0A8P0T2E3 A0A8C0PHT6 A0A8C0T0I2"

#### Draw plots ####
## Format: lollipops [options] {-U UNIPROT_ID | GENE_SYMBOL} [PROTEIN CHANGES ...]
# Plots saved as SVG files by default
for uniprot in $uniprots
do
./lollipops -legend -labels -w=700 -U ${uniprot} ${mutations}
done
