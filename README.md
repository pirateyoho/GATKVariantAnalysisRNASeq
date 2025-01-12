# Background
This repository contains scripts that were used for calling variants in canine RNA-sequencing data using the GATK pipeline: https://gatk.broadinstitute.org/hc/en-us. This repository is intended for internal use by members of the Clinical Hematopathology Laboratory at Colorado State University and their collaborators. 
# Scripts
Scripts are numbered in the order they were run. Scripts with the same number were run simultaneously; most often, these consist of 1) an "sbatchLoop" script designed to submit a batch job to the job scheduler for each file in a directory, and 2) the script being executed in that job.
Scripts labeled 1-13 were used to prepare a panel of normals (pon.vcf.gz) for variant analysis from whole exome sequencing data of canine blood. Scripts 14+ were used for performing variant analysis on bam files generated from bulk RNA-sequencing data from 96 canine CD4+ PTCLs, 2 sorted control CD4+ thymocytes, and 5 sorted CD4+ nodal lymphocytes, utilizing the panel of normals generated in steps 1-13.
# Software requirements
* gatk4 (v 4.4.0.0)
* picard (v 2.18.29)
* samtools (v 1.6)
* bwa (v 0.7.17)
* tabix (v 0.2.6)
* R packages: maftools, RColorBrewer, ggplot2, dplyr, VennDiagram 
# Supplementary files
pon.vcf.gz and its associated index file (.tbi) provided in this repository were generated with scripts 1-13. You may use these provided files to skip scripts 1-13 and start directly with script 14 (picardDedup.sh).

intervals.list is required for mutect2PON.sh.

The 'List of filenames for GenomicsDBImport.txt' file was created for ease of pasting in -V {file1} -V {file2} -V {file3} etc. for the gatk GenomicsDBImport tool.

The 'CanFam31_Rename_chromosomes.txt' is required by the 16-CanFam31_Rename_chroms.sh script to fix the format of the chromosome names in the broad_umass_canid_variants.1.2.vcf.gz file linked below.

WES_filenames_version3.txt contains a list of .fastq filenames for whole exome sequencing data on normal canine blood.

Other required files include:
1. The CanFam 3.1 reference genome fasta file from Ensembl: https://ftp.ensembl.org/pub/release-104/fasta/canis_lupus_familiaris/dna/Canis_lupus_familiaris.CanFam3.1.dna.toplevel.fa.gz
2. A reference panel of known short variants generated from 676 whole-genome sequences of dogs, wolves, and other canids: https://drive.google.com/file/d/15-fFEk6yB9YCe9Ve5YNaX6hCkRlGIu-X/view?usp=drive_link
3. A reference panel of known germline variants in dogs, https://drive.google.com/file/d/1JY2xyMblLkRaqckzhc3HWIZ8O2NdMwX4/view?usp=sharing, and its index file: https://drive.google.com/file/d/1QIWHj0Rz0IovaUBVePNN-uirKdJQU8gl/view?usp=sharing
# Raw data for creation of panel of normals
This pipeline utilized raw whole exome sequencing data from normal dog blood for the creation of a panel of normals. This data is available from two CSU shared drives: the Nas drive for members of the Clinical Hematopathology Laboratory, or the Avery lab RSTOR shared drive.
## Nas
M:\CHLab data\Sequencing Data\221011_ACUTE_WEX_Harris and M:\CHLab data\Sequencing Data\220505_ACUTE_WEX_HARRIS
## RStor
O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230724_A00405_0714_BH55GNDSX7 and O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230801_A00405_0717_BH55FFDSX7
# Raw RNA-seq BAM files
This pipeline utilized BAM files of bulk RNA-seq data aligned to the CanFam3.1 reference genome for 96 canine CD4+ PTCLs, 2 sorted control CD4+ thymocytes, and 5 sorted CD4+ nodal lymphocytes. This data may be accessed here: https://drive.google.com/drive/folders/1-nK8wQdaxqEnkQVbfdiFNg59SuCtAsh5?usp=sharing.
## Sample details
| Avery lab number | Experiment group                | Breed                          | Sex    | Age (yrs) | Sample location        |
| ---------------- | ------------------------------- | ------------------------------ | ------ | --------- | ---------------------- |
| 101495           |  CD4+ PTCL                      | Mixed breed                    | MC     | 8         | Lymph node             |
| 102794           |  CD4+ PTCL                      | Papillon                       | MC     | 11        | Mediastinum            |
| 104568           |  CD4+ PTCL                      | Australian Shepherd            | FS     | 5         | Lymph node             |
| 104569           |  CD4+ PTCL                      | English Cocker Spaniel         | FS     | 6         | Lymph node             |
| 104689           |  CD4+ PTCL                      | Boykin Spaniel                 | M      | 6         | Lymph node             |
| 105160           |  CD4+ PTCL                      | Labrador retriever             | M      | 4         | Lymph node             |
| 105374           |  CD4+ PTCL                      | Mixed breed                    | MC     | 2         | Lymph node             |
| 105488           |  CD4+ PTCL                      | Yorkshire Terrier              | MC     | 7         | Lymph node             |
| 105552           |  CD4+ PTCL                      | Mixed breed                    | MC     | 12        | Lymph node             |
| 105669           |  CD4+ PTCL                      | Golden Retriever               | MC     | 7         | Lymph node             |
| 105719           |  CD4+ PTCL                      | Mixed breed                    | FS     | 5         | Lymph node             |
| 105729           |  CD4+ PTCL                      | Golden Retriever               | MC     | 5         | Lymph node             |
| 105804           |  CD4+ PTCL                      | Mixed breed                    | MC     | 4         | Lymph node             |
| 105835           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 106316           |  CD4+ PTCL                      | Australian Shepherd            | MC     | 5         | Lymph node             |
| 106347           |  CD4+ PTCL                      | Saint Bernard                  | MC     | 9         | Lymph node             |
| 106392           |  CD4+ PTCL                      | Border Collie                  | MC     | 7         | Lymph node             |
| 106419           |  CD4+ PTCL                      | Boxer                          | FS     | 4         | Lymph node             |
| 124711           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 124777           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 124799           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 124809           |  CD4+ PTCL                      | Boxer                          | F      | 4         | Lymph node             |
| 149694           |  CD4+ PTCL                      | Boxer                          | FS     | 7         | Lymph node             |
| 149695           |  CD4+ PTCL                      | Old English Sheepdog           | FS     | 4         | Lymph node             |
| 150394           |  CD4+ PTCL                      | Labradoodle                    | MC     | 5         | Lymph node             |
| 150689           |  CD4+ PTCL                      | German Shepherd                | MC     | 7         | Lymph node             |
| 150972           |  CD4+ PTCL                      | Mixed breed                    | FS     | 6         | Lymph node             |
| 151879           |  CD4+ PTCL                      | Pit Bull Terrier               | MC     | 5         | Lymph node             |
| 152043           |  CD4+ PTCL                      | Mixed breed                    | MC     | 4         | Lymph node             |
| 152139           |  CD4+ PTCL                      | Springer Spaniel               | MC     | 6         | Lymph node             |
| 152256           |  CD4+ PTCL                      | Siberian Husky                 | MC     | 4         | Lymph node             |
| 152603           |  CD4+ PTCL                      | Australian Shepherd            | MC     | 9         | Lymph node             |
| 152610           |  CD4+ PTCL                      | Mixed breed                    | FS     | 5         | Lymph node-mesenteric  |
| 152824           |  CD4+ PTCL                      | Bullmastiff                    | F      | 4         | Lymph node             |
| 152837           |  CD4+ PTCL                      | Boxer                          | MC     | 4         | Lymph node             |
| 153051           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 153070           |  CD4+ PTCL                      | Welsh Corgi                    | FS     | 8         | Lymph node             |
| 153316           |  CD4+ PTCL                      | Golden Doodle                  | FS     | 6         | Lymph node             |
| 153427           |  CD4+ PTCL                      | American Staffordshire terrier | MC     | 3         | Lymph node             |
| 153429           |  CD4+ PTCL                      | Boxer                          | FS     | 5         | Lymph node             |
| 154958           |  CD4+ PTCL                      | Mixed breed                    | MC     | 8         | Lymph node             |
| 154980           |  CD4+ PTCL                      | Shih Tzu                       | MC     | 9         | Lymph node             |
| 155416           |  CD4+ PTCL                      | English Setter                 | F      | 5         | Lymph node             |
| 155427           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 155939           |  CD4+ PTCL                      | Boxer                          | FS     | 8         | Lymph node             |
| 156336           |  CD4+ PTCL                      | Catahoula                      | MC     | 7         | Lymph node-mesenteric  |
| 156355           |  CD4+ PTCL                      | Golden Retriever               | M      | 5         | Mediastinum            |
| 158400           |  CD4+ PTCL                      | Airedale Terrier               | MC     | 10        | Lymph node             |
| 158477           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 158538           |  CD4+ PTCL                      | Cane Corso                     | MC     | 10        | Lymph node             |
| 158606           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 158821           |  CD4+ PTCL                      | Mixed breed                    | MC     | 6         | Lymph node             |
| 159153           |  CD4+ PTCL                      | Labrador retriever             | FS     | 10        | Lymph node             |
| 160115           |  CD4+ PTCL                      | Golden Doodle                  | MC     | 4         | Lymph node             |
| 160275           |  CD4+ PTCL                      | Boxer                          | FS     | 10        | Lymph node             |
| 161206           |  CD4+ PTCL                      | Weimaraner                     | FS     | 5         | Lymph node             |
| 161277           |  CD4+ PTCL                      | Boxer                          | MC     | 5         | Lymph node             |
| 161398           |  CD4+ PTCL                      | German Shepherd                | FS     | 10        | Lymph node             |
| 162673           |  CD4+ PTCL                      | Mixed breed                    | MC     | 7         | Lymph node             |
| 163077           |  CD4+ PTCL                      | Boxer                          | MC     | 10        | Lymph node             |
| 163081           |  CD4+ PTCL                      | Australian Cattle Dog          | MC     | 4         | Lymph node             |
| 163085           |  CD4+ PTCL                      | Boxer                          | FS     | 5         | Lymph node             |
| 164032           |  CD4+ PTCL                      | Yorkshire Terrier              | FS     | 9         | Lymph node             |
| 164076           |  CD4+ PTCL                      | Welsh Corgi                    | MC     | 5         | Lymph node-mediastinal |
| 164535           |  CD4+ PTCL                      | Boxer                          | FS     | 4         | Lymph node             |
| 164787           |  CD4+ PTCL                      | Mixed breed                    | FS     | 11        | Lymph node             |
| 164790           |  CD4+ PTCL                      | Australian Shepherd            | FS     | 5         | Lymph node             |
| 164860           |  CD4+ PTCL                      | Mixed breed                    | FS     | 5         | Lymph node             |
| 164934           |  CD4+ PTCL                      | Mixed breed                    | MC     | 8         | Lymph node             |
| 164968           |  CD4+ PTCL                      | Mixed breed                    | FS     | 3         | Lymph node             |
| 165162           |  CD4+ PTCL                      | Boxer                          | MC     | 8         | Lymph node             |
| 165189           |  CD4+ PTCL                      | Boxer                          | FS     | 7         | Lymph node             |
| 165411           |  CD4+ PTCL                      | Boxer                          | FS     | 5         | Lymph node             |
| 165426           |  CD4+ PTCL                      | Golden Retriever               | FS     | 6         | Lymph node             |
| 165577           |  CD4+ PTCL                      | Mixed breed                    | MC     | 8         | Lymph node             |
| 165644           |  CD4+ PTCL                      | Blue Heeler                    | FS     | 4         | Lymph node             |
| 165769           |  CD4+ PTCL                      | Pit Bull Terrier               | FS     | 3         | Lymph node             |
| 165776           |  CD4+ PTCL                      | American Bulldog               | FS     | 5         | Lymph node             |
| 166151           |  CD4+ PTCL                      | Golden Retriever               | MC     | 8         | Lymph node             |
| 166393           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 166465           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 166472           |  CD4+ PTCL                      | Australian Shepherd            | MC     | 12        | Lymph node             |
| 166556           |  CD4+ PTCL                      | Mixed breed                    | MC     | 13        | Lymph node             |
| 166625           |  CD4+ PTCL                      | Mixed breed                    | MC     | 8         | Lymph node             |
| 167185           |  CD4+ PTCL                      | Boxer                          | FS     | 6         | Lymph node             |
| 169715           |  CD4+ PTCL                      | Old English Sheepdog           | MC     | 3         | Lymph node             |
| 171323           |  CD4+ PTCL                      | Mixed breed                    | MC     | 4         | Lymph node             |
| 171436           |  CD4+ PTCL                      | Mixed breed                    | MC     | 5         | Lymph node             |
| 171487           |  CD4+ PTCL                      | Boxer                          | MC     | 7         | Lymph node             |
| 171535           |  CD4+ PTCL                      | Golden Doodle                  | FS     | 8         | Lymph node             |
| 171729           |  CD4+ PTCL                      | Mixed breed                    | FS     | 6         | Lymph node             |
| 171788           |  CD4+ PTCL                      | Boxer                          | MC     | 9         | Lymph node             |
| 171792           |  CD4+ PTCL                      | Boxer                          | MC     | 11        | Lymph node             |
| 171818           |  CD4+ PTCL                      | Newfoundland                   | MC     | 4         | Lymph node             |
| 171906           |  CD4+ PTCL                      | Mixed breed                    | M-     | 5         | Lymph node             |
| 172331           |  CD4+ PTCL                      | Golden Doodle                  | MC     | 7         | Lymph node             |
| 80397            |  Control CD4+ nodal lymphocytes | Mixed breed                    | Female | 1         | Lymph node             |
| 80399            |  Control CD4+ nodal lymphocytes | Mixed breed                    | Female | 1         | Lymph node             |
| 80400            |  Control CD4+ nodal lymphocytes | Mixed breed                    | Female | 1         | Lymph node             |
| 156615           |  Control CD4+ thymocytes        | Mixed breed                    | Female | 0.66      | Thymus                 |
| 156616           |  Control CD4+ nodal lymphocytes | Mixed breed                    | Female | 0.66      | Lymph node             |
| 157907           |  Control CD4+ nodal lymphocytes | Mixed breed                    | Female | 0.73      | Lymph node             |
| 157953           |  Control CD4+ thymocytes        | Mixed breed                    | Female | 0.73      | Thymus                 |

# Software
The following packages were installed into conda (Anaconda, Inc.) environments on the CU Research Computing Alpine High Performance Computing Cluster:
| Name                         | Version      | Build               | Channel     |
| ---------------------------- | ------------ | ------------------- | ----------- |
| _libgcc_mutex                | 0.1          | conda_forge         | conda-forge |
| _openmp_mutex                | 4.5          | 2_kmp_llvm          | conda-forge |
| _openmp_mutex                | 4.5          | 2_gnu               | conda-forge |
| alsa-lib                     | 1.2.10       | hd590300_0          | conda-forge |
| bcftools                     | 1.19         | h8b25389_0          | bioconda    |
| bedtools                     | 2.31.1       | hf5e1c6e_1          | bioconda    |
| bzip2                        | 1.0.8        | hd590300_5          | conda-forge |
| ca-certificates              | 2024.6.2     | hbcca054_0          | conda-forge |
| cairo                        | 1.18.0       | h3faef2a_0          | conda-forge |
| c-ares                       | 1.19.1       | h5eee18b_0          |             |
| c-ares                       | 1.24.0       | hd590300_0          | conda-forge |
| curl                         | 8.4.0        | hdbd6064_1          |             |
| expat                        | 2.5.0        | h6a678d5_0          |             |
| fontconfig                   | 2.14.2       | h14ed4e7_0          | conda-forge |
| fonts-anaconda               | 1            | h8fa9717_0          |             |
| fonts-conda-ecosystem        | 1            | hd3eb1b0_0          |             |
| font-ttf-dejavu-sans-mono    | 2.37         | hd3eb1b0_0          |             |
| font-ttf-inconsolata         | 2.001        | hcb22688_0          |             |
| font-ttf-source-code-pro     | 2.03         | hd3eb1b0_0          |             |
| font-ttf-ubuntu              | 0.83         | h8b1ccd4_0          |             |
| freetype                     | 2.12.1       | h4a9f257_0          |             |
| gatk4                        | 4.4.0.0      | py36hdfd78af_0      | bioconda    |
| gettext                      | 0.21.1       | h27087fc_0          | conda-forge |
| giflib                       | 5.2.1        | h5eee18b_3          |             |
| graphite2                    | 1.3.14       | h295c915_1          |             |
| gsl                          | 2.7          | he838d99_0          | conda-forge |
| harfbuzz                     | 8.3.0        | h3d44ed6_0          | conda-forge |
| htslib                       | 1.17         | h81da01d_2          | bioconda    |
| htslib                       | 1.19         | h81da01d_0          | bioconda    |
| icu                          | 73.2         | h59595ed_0          | conda-forge |
| keyutils                     | 1.6.1        | h166bdaf_0          | conda-forge |
| krb5                         | 1.20.1       | h143b758_1          |             |
| krb5                         | 1.21.2       | h659d440_0          | conda-forge |
| lcms2                        | 2.16         | hb7c19ff_0          | conda-forge |
| ld_impl_linux-64             | 2.38         | h1181459_1          |             |
| lerc                         | 4.0.0        | h27087fc_0          | conda-forge |
| libblas                      | 3.9.0        | 20_linux64_openblas | conda-forge |
| libcblas                     | 3.9.0        | 20_linux64_openblas | conda-forge |
| libcups                      | 2.3.3        | h36d4200_3          | conda-forge |
| libcurl                      | 8.4.0        | h251f7ec_1          |             |
| libcurl                      | 8.5.0        | hca28451_0          | conda-forge |
| libdeflate                   | 1.19         | hd590300_0          | conda-forge |
| libedit                      | 3.1.20230828 | h5eee18b_0          |             |
| libedit                      | 3.1.20191231 | he28a2e2_2          | conda-forge |
| libev                        | 4.33         | hd590300_2          | conda-forge |
| libffi                       | 3.4.4        | h6a678d5_0          |             |
| libgcc                       | 7.2.0        | h69d50b8_2          |             |
| libgcc-ng                    | 13.2.0       | h807b86a_3          | conda-forge |
| libgfortran5                 | 13.2.0       | ha4646dd_3          | conda-forge |
| libgfortran-ng               | 13.2.0       | h69a702a_3          | conda-forge |
| libglib                      | 2.78.3       | h783c2da_0          | conda-forge |
| libgomp                      | 13.2.0       | h807b86a_3          | conda-forge |
| libiconv                     | 1.17         | hd590300_2          | conda-forge |
| libjpeg-turbo                | 3.0.0        | hd590300_1          | conda-forge |
| libnghttp2                   | 1.57.0       | h2d74bed_0          |             |
| libnghttp2                   | 1.58.0       | h47da74e_1          | conda-forge |
| libopenblas                  | 0.3.25       | pthreads_h413a1c8_0 | conda-forge |
| libpng                       | 1.6.39       | h5eee18b_0          |             |
| libssh2                      | 1.11.0       | h0841786_0          | conda-forge |
| libstdcxx-ng                 | 13.2.0       | h7e041cc_3          | conda-forge |
| libtiff                      | 4.6.0        | ha9c0a0a_2          | conda-forge |
| libuuid                      | 2.38.1       | h0b41bf4_0          | conda-forge |
| libwebp-base                 | 1.3.2        | h5eee18b_0          |             |
| libxcb                       | 1.15         | h7f8727e_0          |             |
| libxcrypt                    | 4.4.36       | hd590300_1          | conda-forge |
| libzlib                      | 1.2.13       | hd590300_5          | conda-forge |
| libzlib                      | 1.2.13       | hd590300_5          | conda-forge |
| llvm-openmp                  | 14.0.6       | h9e868ea_0          |             |
| lz4-c                        | 1.9.4        | h6a678d5_0          |             |
| ncurses                      | 6.4          | h6a678d5_0          |             |
| ncurses                      | 6.2          | h58526e2_4          | conda-forge |
| openjdk                      | 17.0.9       | h4260e57_0          | conda-forge |
| openssl                      | 3.3.1        | h4ab18f5_0          | conda-forge |
| openssl                      | 3.3.0        | h4ab18f5_3          | conda-forge |
| pcre2                        | 10.42        | hebb0a14_0          |             |
| perl                         | 5.32.1       | 7_hd590300_perl5    | conda-forge |
| perl-archive-zip             | 1.68         | pl5321hdfd78af_0    | bioconda    |
| perl-carp                    | 1.5          | pl5321hd8ed1ab_0    | conda-forge |
| perl-compress-raw-zlib       | 2.202        | pl5321h166bdaf_0    | conda-forge |
| perl-constant                | 1.33         | pl5321hd8ed1ab_0    | conda-forge |
| perl-cpan-meta               | 2.15001      | pl5321hdfd78af_1    | bioconda    |
| perl-cpan-meta-requirements  | 2.143        | pl5321hdfd78af_0    | bioconda    |
| perl-cpan-meta-yaml          | 0.018        | pl5321hd8ed1ab_0    | conda-forge |
| perl-data-dumper             | 2.183        | pl5321h166bdaf_0    | conda-forge |
| perl-dbi                     | 1.643        | pl5321hec16e2b_1    | bioconda    |
| perl-encode                  | 3.19         | pl5321h166bdaf_0    | conda-forge |
| perl-exporter                | 5.74         | pl5321hd8ed1ab_0    | conda-forge |
| perl-extutils-cbuilder       | 0.28023      | pl5321hdfd78af_2    | bioconda    |
| perl-extutils-makemaker      | 7.7          | pl5321hd8ed1ab_0    | conda-forge |
| perl-extutils-manifest       | 1.73         | pl5321hdfd78af_0    | bioconda    |
| perl-extutils-parsexs        | 3.44         | pl5321hdfd78af_0    | bioconda    |
| perl-file-path               | 2.18         | pl5321hd8ed1ab_0    | conda-forge |
| perl-file-temp               | 0.2304       | pl5321hd8ed1ab_0    | conda-forge |
| perl-getopt-long             | 2.54         | pl5321hdfd78af_0    | bioconda    |
| perl-ipc-cmd                 | 1.04         | pl5321hdfd78af_0    | bioconda    |
| perl-json-pp                 | 4.11         | pl5321hd8ed1ab_0    | conda-forge |
| perl-locale-maketext-simple  | 0.21         | pl5321hdfd78af_3    | bioconda    |
| perl-module-build            | 0.4231       | pl5321hdfd78af_0    | bioconda    |
| perl-module-corelist         | 5.2022062    | pl5321hdfd78af_0    | bioconda    |
| perl-module-load             | 0.34         | pl5321hdfd78af_0    | bioconda    |
| perl-module-load-conditional | 0.68         | pl5321hdfd78af_3    | bioconda    |
| perl-module-metadata         | 1.000038     | pl5321hdfd78af_0    | bioconda    |
| perl-params-check            | 0.38         | pl5321hdfd78af_2    | bioconda    |
| perl-parent                  | 0.241        | pl5321hd8ed1ab_0    | conda-forge |
| perl-perl-ostype             | 1.01         | pl5321hd8ed1ab_0    | conda-forge |
| perl-scalar-list-utils       | 1.63         | pl5321h166bdaf_0    | conda-forge |
| perl-storable                | 3.15         | pl5321h166bdaf_0    | conda-forge |
| perl-text-abbrev             | 1.02         | pl5321hd8ed1ab_0    | conda-forge |
| perl-text-parsewords         | 3.31         | pl5321hd8ed1ab_0    | conda-forge |
| perl-time-local              | 1.35         | pl5321hdfd78af_0    | bioconda    |
| perl-version                 | 0.9929       | pl5321h166bdaf_0    | conda-forge |
| picard                       | 2.18.29      | 0                   | bioconda    |
| pip                          | 23.3.1       | py39h06a4308_0      |
| pixman                       | 0.42.2       | h59595ed_0          | conda-forge |
| python                       | 3.9.18       | h955ad1f_0          |             |
| readline                     | 8.2          | h5eee18b_0          |             |
| samtools                     | 1.11         | h6270b1f_0          | bioconda    |
| setuptools                   | 68.2.2       | py39h06a4308_0      |
| snpeff                       | 5.2          | hdfd78af_0          | bioconda    |
| snpsift                      | 5.2          | hdfd78af_0          | bioconda    |
| sqlite                       | 3.41.2       | h5eee18b_0          |             |
| tabix                        | 0.2.6        | ha92aebf_0          | bioconda    |
| tk                           | 8.6.12       | h1ccaba5_0          |             |
| tzdata                       | 2023c        | h04d1e81_0          |             |
| vcf2maf                      | 1.6.21       | hdfd78af_0          | bioconda    |
| vcftools                     | 0.1.16       | pl5321hdcf5f25_10   | bioconda    |
| wheel                        | 0.41.2       | py39h06a4308_0      |
| xorg-fixesproto              | 5            | h7f98852_1002       | conda-forge |
| xorg-inputproto              | 2.3.2        | h7f98852_1002       | conda-forge |
| xorg-kbproto                 | 1.0.7        | h7f98852_1002       | conda-forge |
| xorg-libice                  | 1.1.1        | hd590300_0          | conda-forge |
| xorg-libsm                   | 1.2.4        | h7391055_0          | conda-forge |
| xorg-libx11                  | 1.8.7        | h8ee46fc_0          | conda-forge |
| xorg-libxext                 | 1.3.4        | h0b41bf4_2          | conda-forge |
| xorg-libxfixes               | 5.0.3        | h7f98852_1004       | conda-forge |
| xorg-libxi                   | 1.7.10       | h7f98852_0          | conda-forge |
| xorg-libxrender              | 0.9.11       | hd590300_0          | conda-forge |
| xorg-libxt                   | 1.3.0        | hd590300_1          | conda-forge |
| xorg-libxtst                 | 1.2.3        | h7f98852_1002       | conda-forge |
| xorg-recordproto             | 1.14.2       | h7f98852_1002       | conda-forge |
| xorg-renderproto             | 0.11.1       | h7f98852_1002       | conda-forge |
| xorg-xextproto               | 7.3.0        | h0b41bf4_1003       | conda-forge |
| xorg-xproto                  | 7.0.31       | h27cfd23_1007       |             |
| xz                           | 5.4.5        | h5eee18b_0          |             |
| xz                           | 5.2.6        | h166bdaf_0          | conda-forge |
| zlib                         | 1.2.13       | hd590300_5          | conda-forge |
| zstd                         | 1.5.5        | hfc55251_0          | conda-forge |

The following packages were installed and run in RStudio (version 0.16.0) using R (version 4.4.0):
| Name          | Version |
| ------------- | ------- |
| RColorBrewer  | 1.1-3   |
| futile.logger | 1.4.3   |
| knitr         | 1.46    |
| ggplot2       | 3.5.1   |
| dplyr         | 1.1.4   |
| VennDiagram   | 1.7.3   |
| maftools      | 2.20.0  |
