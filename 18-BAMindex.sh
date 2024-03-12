#!/bin/bash
# To index de-duplicated BAM files with read groups assigned as part of the GATK variant analysis pipeline.
## NOTE: This script must be run in a conda environment with Picard installed.

#SBATCH --job-name=execute_PicardBAMIndex
#SBATCH --nodes=1
#SBATCH --ntasks=8 # modify this number to reflect how many cores you want to use (up to 32), and update the --runThreadN command below to match
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=12:00:00 # Adjust based on the number of samples, keeping in mind it takes ~2 min/sample. Max allowed is 24 hrs.
#SBATCH --output=log_PicardBAMIndex_%J.txt
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Make a BAM index file with Picard, looping through each BAM file in the directory where this script is executed.
for bam in $(ls *.bam)
do
picard BuildBamIndex INPUT=${bam}
done