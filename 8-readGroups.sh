#!/bin/bash
# To add read group tags to deduplicated BAM files using gatk.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=execute_RGArray
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=04:00:00
#SBATCH --output=log_RGArray_%J.txt
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Make an output directory for results:
mkdir ReadGroupsAssigned

# Assign bam variable to first argument passed to script
bam=${1}

# Assign sample ID to variable called 'name'
name=$(basename ${bam} .cfam3.1sorted.bam_dedup_reads.bam)
echo ${name}

# Assign read group tags with gatk
gatk AddOrReplaceReadGroups \
-I ${bam} \
-O ReadGroupsAssigned/${bam}_RG.bam \
-SORT_ORDER coordinate \
-RGID ${name} \
-RGLB ${name} \
-RGPU unit1 \
-RGPL ILLUMINA \
-RGSM ${name} \
--TMP_DIR tmp \
--CREATE_INDEX True