#!/bin/bash
# To run gatk GenomicsDBImport on vcf.gz files following Mutect2 tumor-only mode as part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=Mutect2PON
#SBATCH --nodes=1
#SBATCH --ntasks=16 # Previous attempts to run with fewer threads resulted in 'out of memory' errors
#SBATCH --time=4:00:00 # For 37 vcf files, this took 2 hrs to run when given 16 threads
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --output=log_Mutect2NormPON_%j.txt
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

# make tmp directory
mkdir tmp


#Step 2. Create database for panel of normals.
#Intervals file is required and includes intervals of all chromosomal locations, note: should be named the same way as gtf
gatk GenomicsDBImport -R ../../Input/GenomeData/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa --tmp-dir tmp -L intervals.list --genomicsdb-workspace-path pon_db_standard -V BL142643_cfam3.1.vcf.gz -V BL153154_cfam3.1.vcf.gz -V BL154263_cfam3.1.vcf.gz -V BL157282_cfam3.1.vcf.gz -V BL160977_cfam3.1.vcf.gz -V BL161182_cfam3.1.vcf.gz -V BL161183_cfam3.1.vcf.gz -V BL162275_cfam3.1.vcf.gz -V BL162310_cfam3.1.vcf.gz -V BL162313_cfam3.1.vcf.gz -V BL162566_cfam3.1.vcf.gz -V BL163508_cfam3.1.vcf.gz -V BL163511_cfam3.1.vcf.gz -V BL163514_cfam3.1.vcf.gz -V BL165420_cfam3.1.vcf.gz -V BL166083_cfam3.1.vcf.gz -V BL166141_cfam3.1.vcf.gz -V BL166330_cfam3.1.vcf.gz -V BL167494_cfam3.1.vcf.gz -V BL167524_cfam3.1.vcf.gz -V BL168379_cfam3.1.vcf.gz -V BL168653_cfam3.1.vcf.gz -V BL169452_cfam3.1.vcf.gz -V BL169939_cfam3.1.vcf.gz -V BL169941_cfam3.1.vcf.gz -V BL170787_cfam3.1.vcf.gz -V BL171522_cfam3.1.vcf.gz -V BL171980_cfam3.1.vcf.gz -V BL172909_cfam3.1.vcf.gz -V BL172911_cfam3.1.vcf.gz -V BL172913_cfam3.1.vcf.gz -V BL173539_cfam3.1.vcf.gz -V BL173730_cfam3.1.vcf.gz -V BL173989_cfam3.1.vcf.gz -V BL180839_cfam3.1.vcf.gz -V BL181102_cfam3.1.vcf.gz -V BL181219_cfam3.1.vcf.gz