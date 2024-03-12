#!/bin/bash
### Purpose: To sort BAM files with samtools. NOTE: Must be run in a conda environment where samtools is installed.
###Input: .bam alignment file
###Output: Sorted .bam alignment file

#SBATCH --job-name=BAMsort
#SBATCH --nodes=1
#SBATCH --ntasks=4       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=8:00:00   # set time; default = 4 hours
#SBATCH --mail-type=END,FAIL,TIME_LIMIT  
#SBATCH --mail-user=edlarsen@colostate.edu

#SBATCH --output=log_BAMsort_%j.txt  # this will capture all output in a logfile with %j as the job #

#export PATH=/projects/edlarsen@colostate.edu/bin:$PATH

#record data
 start=`date +%s`

# Assign bam variable to first argument passed to script (from sbatchLoop_bamSort.sh)
bam=${1}

# Assign the sample ID portion of the filename to a variable called 'name' to use for naming the output file
name=$(basename ${bam} .bam)
# Print sample ID at the top of the log file
echo ${name}

# Run samtools to sort bam file
samtools sort ${bam} -@ 4 -o ${name}_sorted.bam