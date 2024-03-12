#!/bin/bash
# To run gatk CreateSomaticPanelofNormals on a database created with gatk GenomicsDBImport. Part of the GATK pipeline for variant analysis.
## NOTE: This script must be run in a conda environment with gatk4 installed.


#SBATCH --job-name=Mutect2PONstep3
#SBATCH --nodes=1
#SBATCH --ntasks=4 # number of cores to use
#SBATCH --time=12:00:00   # set time; default = 4 hours
#SBATCH --partition=amilan  # alpine's general compute node
#SBATCH --qos=normal      # modify this to reflect which queue you want to use. Options are 'normal' and 'testing'
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT # email updates
#SBATCH --mail-user=edlarsen@colostate.edu # email
#SBATCH --output=log_Mutect2somaticPON_%j.txt  # this will capture all output in a logfile with %j as the job


#record data
 start=`date +%s`
 
#Step 3. Combine the normal calls using CreateSomaticPanelOfNormals.
gatk CreateSomaticPanelOfNormals -R /projects/adh91@colostate.edu/references/Ensembl.CanFam3.1/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa -V gendb://pon_db -O pon.vcf.gz

sleep 5s
