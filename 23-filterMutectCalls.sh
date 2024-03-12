#!/bin/bash

#SBATCH --job-name=Mutect2TumorFilter
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=01:00:00 # In my experience, takes only a few minutes per file
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_Mutect2TumorFilter_%j.txt

#record data
 start=`date +%s`
 
# Filter vcf files previously generated with Mutect2. -R = reference sequence file. -V = VCF file containing variants. --stats = Mutect stats file output by Mutect2. -O = output filtered VCF file
for file in *.vcf.gz; do name=$(basename ${file} .vcf.gz); echo ${name};
gatk FilterMutectCalls \
-R ../../../../../Input/GenomeData/CanFam31_FullGenome.fa \
-V ${name}.vcf.gz \
--stats ${name}.vcf.gz.stats \
-O ${name}_filteredcalls.vcf.gz
done