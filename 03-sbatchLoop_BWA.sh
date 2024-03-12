#!/bin/bash
# To loop through paired files and submit a separate job to the Slurm scheduler to run a script for each.

#SBATCH --job-name=LoopJobs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=00:10:00
#SBATCH --output=log_BWALoopJobs_%J.txt
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=edlarsen@colostate.edu

# Initiate a bash array of sample IDs
SAMPLEIDs="BL142643 BL153154 BL154263 BL157282 BL160977 BL161182 BL161183 BL162275 BL162310 BL162313 BL162566 BL163508 BL163511 BL163514 BL165420 BL166083 BL166141 BL166330 BL167494 BL167524 BL168379 BL168653 BL169452 BL169939 BL169941 BL170787 BL171522 BL171980 BL172909 BL172911 BL172913 BL173539 BL173730 BL173989 BL180839 BL181102 BL181219"

# Loop through the sample ID array and submit a batch job for each set of paired fq files:
for SAMPLEID in $SAMPLEIDs
do
echo ${SAMPLEID}
sbatch BWA_CanFam31.sh ${SAMPLEID}_cat_L001_R1_001_val_1.fq.gz ${SAMPLEID}_cat_L001_R2_001_val_2.fq.gz
done