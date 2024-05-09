# Background
This repository contains scripts that were used for calling variants in canine RNA-sequencing data using the GATK pipeline: https://gatk.broadinstitute.org/hc/en-us. This repository is intended for internal use by members of the Clinical Hematopathology Laboratory at Colorado State University and their collaborators. 
# Scripts
Scripts are numbered in the order they were run. Scripts with the same number were run simultaneously; most often, these consist of 1) an "sbatchLoop" script designed to submit a batch job to the job scheduler for each file in a directory, and 2) the script being executed in that job.
Scripts labeled 1-13 were used to prepare a panel of normals (pon.vcf.gz) for variant analysis from whole exome sequencing data of canine blood. Scripts 14+ were used for performing variant analysis on bam files generated from bulk RNA-sequencing data from 96 canine CD4+ PTCLs, 2 sorted control CD4+ thymocytes, and 5 sorted CD4+ nodal lymphocytes, utilizing the panel of normals generated in steps 1-13.
# Software requirements
Bash scripts (.sh) in this pipeline were run on the CURC Alpine supercomputer in a dedicated conda environment containing the software packages gatk4 (v 4.4.0.0), picard (v 2.18.29), samtools (v 1.6), bwa (v 0.7.17), snpeff (v 5.2), and tabix (v 0.2.6).
# Raw data for creation of panel of normals
This pipeline utilized raw whole exome sequencing data from normal dog blood for the creation of a panel of normals. This data is available from two CSU shared drives: the Nas drive for members of the Clinical Hematopathology Laboratory, or the Avery lab RSTOR shared drive.
## Nas
M:\CHLab data\Sequencing Data\221011_ACUTE_WEX_Harris and M:\CHLab data\Sequencing Data\220505_ACUTE_WEX_HARRIS
## RStor
O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230724_A00405_0714_BH55GNDSX7 and O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230801_A00405_0717_BH55FFDSX7
# Supplementary files
pon.vcf.gz and its associated index file (.tbi) provided in this repository were generated with scripts 1-13. You may use these provided files to skip scripts 1-13 and start directly with script 14 (picardDedup.sh).

intervals.list is required for mutect2PON.sh.

The 'List of filenames for GenomicsDBImport.txt' file was created for ease of pasting in -V {file1} -V {file2} -V {file3} etc. for the gatk GenomicsDBImport tool.

WES_filenames_version3.txt contains a list of .fastq filenames for whole exome sequencing data on normal canine blood.

Other required files include:
1. The CanFam 3.1 reference genome fasta file from Ensembl: https://ftp.ensembl.org/pub/release-104/fasta/canis_lupus_familiaris/dna/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa.gz
2. A reference panel of known short variants generated from 676 whole-genome sequences of dogs, wolves, and other canids: https://drive.google.com/file/d/15-fFEk6yB9YCe9Ve5YNaX6hCkRlGIu-X/view?usp=drive_link
3. A reference panel of known germline variants in dogs, https://drive.google.com/file/d/1JY2xyMblLkRaqckzhc3HWIZ8O2NdMwX4/view?usp=sharing, and its index file: https://drive.google.com/file/d/1QIWHj0Rz0IovaUBVePNN-uirKdJQU8gl/view?usp=sharing
