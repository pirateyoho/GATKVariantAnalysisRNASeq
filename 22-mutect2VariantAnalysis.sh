#!/bin/bash

#SBATCH --job-name=Mutect2PTCL
#SBATCH --nodes=1
#SBATCH --ntasks=16 # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=16:00:00 # set time; default = 4 hours
#SBATCH --partition=amilan # alpine's general compute node
#SBATCH --qos=normal # modify this to reflect which queue you want to use. Options are 'normal' and 'testing'
#SBATCH --mail-type=FAIL,TIME_LIMIT # desired email alerts
#SBATCH --mail-user=edlarsen@colostate.edu # your email address
#SBATCH --output=log_Mutect2PTCL_%j.txt  # this will capture all output in a logfile with %j as the job


#record data
 start=`date +%s`
 
# Make output directory
mkdir VariantCalling

# Assign bam variable to first argument passed to script
bam=${1}

# Assign the sample ID portion of the BAM filename to a variable called 'name' and print it to the log file
name=$(basename ${bam} Aligned.sortedByCoord.out.bam_dedup_reads.bam_dedup_reads_RG1.bam_splitreads.bam_recal_reads.bam); echo ${name}
 
#Run Mutect2 to conduct variant analysis on these samples, utilizing the PON vcf that was previously generated with normal blood WES data
gatk Mutect2 \
-R ../../../../Input/GenomeData/CanFam31_FullGenome.fa \
--panel-of-normals ../../../../WES/Mutect2/pon.vcf.gz \
--germline-resource ../../../../Input/GenomeData/rename.broad_umass_canid_variants.1.2.vcf.gz \
-max-mnp-distance 0 \
-I ${bam} \
-O VariantCalling/${name}_CanFam31.vcf.gz