#!/bin/bash

#SBATCH --job-name=INDELVariantFiltration
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=01:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --mail-type=BEGIN,FAIL,END,TIME_LIMIT
#SBATCH --mail-user=edlarsen@colostate.edu
#SBATCH --output=log_gatkINDELVariantFiltration_%j.txt

#record data
 start=`date +%s`


#Run VariantFiltration with basic filtering thresholds from the GATK documentation: https://gatk.broadinstitute.org/hc/en-us/articles/360035890471-Hard-filtering-germline-short-variants
for file in *indels.vcf; do name=$(basename ${file} .raw_indels.vcf); echo ${name};
gatk VariantFiltration \
-R ../../../../../../Input/GenomeData/CanFam31_FullGenome.fa \
-V ${file} \
-filter "QD < 2.0" --filter-name "QD2" \
-filter "FS > 200" --filter-name "FS200" \
-filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
-O ${name}.indels-filtered.vcf
done
