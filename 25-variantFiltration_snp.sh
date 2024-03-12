#!/bin/bash

#SBATCH --job-name=SNPVariantFiltration
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=01:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_gatkSNPVariantFiltration_%j.txt

#record data
 start=`date +%s`


#Run VariantFiltration with basic filtering thresholds from the GATK documentation: https://gatk.broadinstitute.org/hc/en-us/articles/360035531112--How-to-Filter-variants-either-with-VQSR-or-by-hard-filtering
for file in *snps.vcf; do name=$(basename ${file} .raw_snps.vcf); echo ${name};
gatk VariantFiltration \
-R ../../../../../../Input/GenomeData/CanFam31_FullGenome.fa \
-V ${file} \
-filter "QD < 2.0" --filter-name "QD2" \
-filter "QUAL < 30.0" --filter-name "QUAL30" \
-filter "SOR > 3.0" --filter-name "SOR3" \
-filter "FS > 60.0" --filter-name "FS60" \
-filter "MQ < 40.0" --filter-name "MQ40" \
-filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
-filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
-O ${name}.snps-filtered.vcf
done