#!/bin/bash

#SBATCH --job-name=gatkIndex

#SBATCH --nodes=1
#SBATCH --ntasks=24       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=8:00:00   # set time; default = 4 hours
#SBATCH --mem=64GB
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT   # Keep these two lines of code if you want an e-mail sent to you when it is complete.
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=gatkIndex_%j.txt  # this will capture all output in a logfile with %j as the job 

## Execute this script in a conda environment containing samtools
for vcf in $(ls *.vcf.gz)
do
tabix -f -p vcf ${vcf}
done