#!/bin/bash

#SBATCH --job-name=RenameChrom

#SBATCH --nodes=1
#SBATCH --ntasks=32       # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --time=23:55:00   # set time; default = 4 hours
#SBATCH --partition=amilan
#SBATCH --mem=64GB
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT   # Keep these two lines of code if you want an e-mail sent to you when it is complete.
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_RenameChrom_%j.txt  # this will capture all output in a logfile with %j as the job #



## Execute this script in a conda environment containing samtools, or un-comment and run the following 2 lines of code: 
#module purge ## purge all existing modules
#module load gatk

bcftools annotate --rename-chrs CanFam4_Renam_chromosomes_file.txt SV-genotype.merge.vcf.gz | bgzip > rename.SV-genotype.merge.vcf.gz