Scripts labeled 1-11 were used to prepare a panel of normals for variant analysis from whole exome sequencing data of canine blood (located here: M:\CHLab data\Sequencing Data\221011_ACUTE_WEX_Harris and M:\CHLab data\Sequencing Data\220505_ACUTE_WEX_HARRIS, or O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230724_A00405_0714_BH55GNDSX7 and O:\RSTOR-Avery\230728_ACUTE_WEX_HarrisA\230801_A00405_0717_BH55FFDSX7). Scripts are numbered in the order they should be run.

intervals.list is required for mutect2PON.sh.

The 'List of filenames for GenomicsDBImport.txt' file was created for ease of pasting in -V {file1} -V {file2} -V {file3} etc. for the gatk GenomicsDBImport tool. Filenames were exported from Alpine by ls *.vcf.gz > vcf_filenames_list.txt. This list of filenames was copied into one column in an Excel worksheet. Another column was inserted to the left, and in this column, a -V was added for each row containing a filename. This was then exported as a tab-delimited .txt file, opened in Notepad, and pasted into a web tool (Browserling) to convert tab-delimited to space-delimited, then new line to space-delimited . The final product could then be pasted into the mutect2PON.sh script as a space-delimited list of filenames with the -V flag.

WES_filenames_version3.txt contains a list of .fastq filenames for whole exome sequencing data on normal canine blood.
