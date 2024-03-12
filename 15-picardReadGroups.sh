#!/bin/bash
# To add read group tags to deduplicated BAM files using Picard.
## NOTE: This script must be run in a conda environment with Picard installed.

#SBATCH --job-name=execute_PicardGroupTag
#SBATCH --nodes=1
#SBATCH --ntasks=8 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=12:00:00
#SBATCH --output=log_PicardGroupTag_%J.txt
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Make an output directory for results:
mkdir ReadGroupsAssigned

# Assign bam variable to first argument passed to script
bam=${1}

# Assign read group tags with Picard
picard AddOrReplaceReadGroups \
I=${bam} \
O=ReadGroupsAssigned/${bam}_RG.bam \
RGID=4 \
RGLB=lib1 \
RGPL=ILLUMINA \
RGPU=unit1 \
RGSM=20