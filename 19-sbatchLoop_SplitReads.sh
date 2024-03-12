#!/bin/bash
# To loop through BAM files and submit a separate job to the Slurm scheduler to run gatk SplitNCigarReads for each.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=LoopJobs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=1:00:00
#SBATCH --output=log_LoopJobs_ %J.txt
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT
#SBATCH --mail-user=eid@colostate.edu

# Loop through all bam files in the directory and submit a gatk SplitNCigarReads job for each:
for file in $(ls *.bam)
do
echo ${file}
sbatch SplitNCigarReads.sh ${file}
done