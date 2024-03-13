# Background
This repository contains various bash scripts for calling variants in canine RNA-sequencing data using the GATK pipeline: https://gatk.broadinstitute.org/hc/en-us. This repository is intended for internal use by members of the Clinical Hematopathology Laboratory at Colorado State University and their collaborators. 
# Scripts
Scripts are numbered in the order they should be run. Scripts with the same number are meant to be run simultaneously.
Scripts labeled 1-13 were used to prepare a panel of normals for variant analysis from whole exome sequencing data of canine blood. Scripts 14+ were used for performing variant analysis on bam files generated from bulk RNA-sequencing data from 96 canine CD4+ PTCLs, 2 sorted control CD4+ thymocytes, and 5 sorted CD4+ nodal lymphocytes, utilizing the panel of normals generated in steps 1-13.
# Software requirements
Bash scripts (.sh) in this pipeline are intended to be run on the CURC Alpine supercomputer in a dedicated conda environment containing the software packages gatk4, picard, samtools, star, snpeff, and tabix.
# Raw data for creation of panel of normals
This pipeline assumes you have access to raw whole exome sequencing data from normal dog blood, available from two CSU shared drives: the Nas drive for members of the Clinical Hematopathology Laboratory, or the Avery lab RSTOR shared drive.
## Nas
M:\CHLab data\Sequencing Data\221011_ACUTE_WEX_Harris and M:\CHLab data\Sequencing Data\220505_ACUTE_WEX_HARRIS
## RStor
O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230724_A00405_0714_BH55GNDSX7 and O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230801_A00405_0717_BH55FFDSX7)
# Supplementary files
intervals.list is required for mutect2PON.sh.

The 'List of filenames for GenomicsDBImport.txt' file was created for ease of pasting in -V {file1} -V {file2} -V {file3} etc. for the gatk GenomicsDBImport tool. Filenames were exported from Alpine by ls *.vcf.gz > vcf_filenames_list.txt. This list of filenames was copied into one column in an Excel worksheet. Another column was inserted to the left, and in this column, a -V was added for each row containing a filename. This was then exported as a tab-delimited .txt file, opened in Notepad, and pasted into a web tool (Browserling) to convert tab-delimited to space-delimited, then new line to space-delimited . The final product could then be pasted into the mutect2PON.sh script as a space-delimited list of filenames with the -V flag.

WES_filenames_version3.txt contains a list of .fastq filenames for whole exome sequencing data on normal canine blood.

Other required files include:
1. The CanFam 3.1 reference genome fasta file from Ensembl: https://ftp.ensembl.org/pub/release-104/fasta/canis_lupus_familiaris/dna/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa.gz
2. A reference panel of known short variants generated from 676 whole-genome sequences of dogs, wolves, and other canids: https://drive.google.com/file/d/15-fFEk6yB9YCe9Ve5YNaX6hCkRlGIu-X/view?usp=drive_link
3. A reference panel of known germline variants in dogs, https://drive.google.com/file/d/1JY2xyMblLkRaqckzhc3HWIZ8O2NdMwX4/view?usp=sharing, and its index file: https://drive.google.com/file/d/1QIWHj0Rz0IovaUBVePNN-uirKdJQU8gl/view?usp=sharing
