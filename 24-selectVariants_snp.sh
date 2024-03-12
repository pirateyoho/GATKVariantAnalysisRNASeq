#!/bin/bash

#SBATCH --job-name=Mutect2TumorFilter
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=07:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=Mutect2SelectSNPs_%j.txt

# make output directory
mkdir CSPipeline

#record data
 start=`date +%s`
 
#Run gatk SelectVariants to separate SNPs and INDELs into their own vcf files
for file in *_filteredcalls.vcf.gz; do name=$(basename ${file} _filteredcalls.vcf.gz); echo ${name};
gatk SelectVariants \
-R ../../../../../Input/GenomeData/CanFam31_FullGenome.fa \
-V ${name}_filteredcalls.vcf.gz \
--select-type-to-include SNP \
-O CSPipeline/${name}.raw_snps.vcf
done