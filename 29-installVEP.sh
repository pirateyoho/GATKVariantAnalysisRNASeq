#!/bin/bash
# Purpose: To install the Ensembl variant effect predictor tool locally
# NOTE: This script is intended to be run locally, not on an HPC cluster. Instructions apply to Macbook computers and may not work as intended on a PC.

# Navigate to home directory
cd ~

# Clone Ensembl VEP 
git clone https://github.com/Ensembl/ensembl-vep.git

# Install VEP. Replace 'yourname' with your username (if you do not know your username, check it with pwd ~)
cd ensemble-vep
export DYLD_LIBRARY_PATH=/Users/yourname/ensembl-vep/htslib
export PERL5LIB=/Users/yourname/ensembl-vep
perl INSTALL.pl

# Download Ensembl VEP cache for CanFam3.1 
cd $HOME/.vep
curl -O https://ftp.ensembl.org/pub/release-104/variation/indexed_vep_cache/canis_lupus_familiaris_vep_104_CanFam3.1.tar.gz
tar xzf canis_lupus_familiaris_vep_104_CanFam3.1.tar.gz 