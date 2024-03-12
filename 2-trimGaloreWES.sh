#!/bin/bash
### Purpose: To trim raw whole exome sequencing reads with TrimGalore
###Input: Paired .fastq files
###Output: Trimmed .fq files and fastQC report

#SBATCH --job-name=TrimWES

#SBATCH --nodes=1
#SBATCH --ntasks=4       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=4:00:00   # set time; default = 4 hours
#SBATCH --mem=16GB
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_TrimGaloreWES_%j.txt  # this will capture all output in a logfile with %j as the job #

### NOTE: Run this script in an activated conda environment where Trim-Galore is installed.

#Print TrimGalore version
trim_galore --version

# Assign read1 variable to first argument passed to script
read1=${1}

# Assign read2 variable to second argument passed to script
read2=${2}

# Assign the sample ID portion of the read1 filename to a variable called 'name' and print it to the log file
name=$(basename ${read1} _cat_L001_R1_001.fastq); echo ${name}

#run Trimgalore. --q trims low-quality ends from reads in addition to adapter removal. --gzip compresses output file. --cores sets how many threads to use. --output_dir creates and writes all output to this directory. --fastqc runs FastQC in the default mode on the Fastq file once trimming is complete.
trim_galore \
    --paired ${read1} ${read2} \
    --q 30 \
    --gzip \
    --cores 4 \
    --output_dir ../TrimGaloreOutput \
    --fastqc