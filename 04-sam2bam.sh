#!/bin/bash
# Purpose: To convert .sam files to .bam files. NOTE: This script must be run in a conda environment where samtools is installed.
###Input: .sam alignment files
###Output: Unsorted .bam alignment files 

#SBATCH --job-name=SAM2BAM

#SBATCH --nodes=1
#SBATCH --ntasks=4       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=04:00:00   # set time; default = 4 hours
#SBATCH --mail-type=FAIL,TIME_LIMIT 
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=SAM2BAM_%j.txt  # this will capture all output in a logfile with %j as the job #

#export PATH=/projects/edlarsen@colostate.edu/bin:$PATH

#record data
 start=`date +%s`
 

# Assign sam variable to first argument passed to script (from sbatchLoop_sam2bam.sh)
sam=${1}

# Assign the sample ID portion of the filename to a variable called 'name' to use for naming the output file
name=$(basename ${sam} .sam)
# Print sample ID at the top of the log file
echo ${name}

# Run samtools to view and convert SAM file to BAM file
samtools view -S -b ${sam} > ${name}.bam

#SORT AFTER BAM is CREATED
