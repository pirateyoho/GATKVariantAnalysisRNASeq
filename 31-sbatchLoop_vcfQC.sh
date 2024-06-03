#!/bin/bash
# To loop through annotated vcf files and submit a separate job to the Slurm scheduler to run gatk CollectVariantCallingMetrics for each.
## NOTE: This script must be run in a conda environment with gatk4 installed.

#SBATCH --job-name=LoopJobs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=1:00:00
#SBATCH --output=log_LoopJobs_vcfQC_%J.txt
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu

# Loop through all ann.vcf files in the directory and submit a gatk CollectVariantCallingMetrics job for each
for file in *vep.vcf
do
echo ${file}
sbatch vcfQualityControl.sh ${file}
done
