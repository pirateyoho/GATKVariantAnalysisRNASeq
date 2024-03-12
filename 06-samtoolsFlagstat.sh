#!/bin/bash
### Purpose: To count the number of alignments for each flag type using samtools. NOTE: Must be run in a conda environment where samtools is installed. Perform after sorting.
###Input: Sorted .bam alignment file
###Output: .txt file of number of alignments for each FLAG type


#SBATCH --job-name=SAMTFlag

#SBATCH --nodes=1
#SBATCH --ntasks=4       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=4:00:00   # set time; default = 4 hours
#SBATCH --mail-type=END,FAIL,TIME_LIMIT  
#SBATCH --mail-user=edlarsen@colostate.edu

#SBATCH --output=log_SAMTFlag_%j.txt  # this will capture all output in a logfile with %j as the job #

#export PATH=/projects/edlarsen@colostate.edu/bin:$PATH

#record data
 start=`date +%s`

# Loop through all BAM files in the directory and submit a job to run bamSort.sh for each:
for bam in *sorted.bam
do
echo ${bam}
samtools flagstat ${bam} -@ 4 > ${bam}.fs.txt
done