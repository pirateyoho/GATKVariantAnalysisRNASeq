#!/bin/bash
# Purpose: To rename chromosomes in the reference vcf file to a compatible format
# NOTE: This script must be run in a conda environment with bcftools installed

#SBATCH --job-name=RenameChrom

#SBATCH --nodes=1
#SBATCH --ntasks=32       # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=8:00:00   # set time; default = 4 hours
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT   # Keep these two lines of code if you want an e-mail sent to you when it is complete.
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=RenameChrom_%j.txt  # this will capture all output in a logfile with %j as the job #


bcftools annotate --rename-chrs Renam_chromosomes_file.txt broad_umass_canid_variants.1.2.vcf.gz | bgzip > rename.broad_umass_canid_variants.1.2.vcf.gz
