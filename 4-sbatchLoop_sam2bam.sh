#!/bin/bash
# To loop through SAM files and submit a separate job to the Slurm scheduler to convert each to BAM file with samtools.
## NOTE: This script must be run in a conda environment with samtools installed.

#SBATCH --job-name=LoopJobs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=00:10:00
#SBATCH --output=log_LoopJobs_%J.txt
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=edlarsen@colostate.edu


# Loop through all SAM files in the directory and submit a job to run sam2bam.sh for each:
for file in $(ls *.sam)
do
echo ${file}
sbatch sam2bam.sh ${file}
done
