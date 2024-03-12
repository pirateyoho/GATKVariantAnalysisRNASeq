#!/bin/bash
### Purpose: To align whole exome sequencing reads to the CanFam 3.1 reference genome with the Burrows-Wheeler Aligner (BWA). BWA index must be performed prior to this step.
###Input: 1) Genome .fa file and its index 2) Paired, trimmed .fq sequencing files.
###Output: .sam alignment files 

#SBATCH --job-name=BWAalignWES

#SBATCH --nodes=1
#SBATCH --ntasks=8       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=4:00:00  # set time; default = 4 hours
#SBATCH --mem=16GB
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_BWAalignWES_%j.txt  # this will capture all output in a logfile with %j as the job #

### NOTE: Run this script in an activated conda environment where BWA is installed.

#record data
 start=`date +%s`

# Assign read1 variable to first argument passed to script
read1=${1}

# Assign read2 variable to second argument passed to script
read2=${2}

# Assign the sample ID portion of the filename to a variable called 'name' to use for naming the output file
name=$(basename ${read1} _cat_L001_R1_001_val_1.fq.gz)
# Print sample ID at the top of the log file
echo ${name}

#align files with BWA-MEM algorithm. Usage: bwa mem ref.fa read1.fq read2.fq > aln-pe.sam. --t sets the number of threads.
bwa mem -t 8 \
../../Input/GenomeData/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa \
${read1} ${read2} > ../BWAOutput/${name}_cfam3.1.sam