#!/bin/bash

#SBATCH --job-name=lollipops
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 32)
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --time=1:00:00
#SBATCH --output=log_lollipops_%J.txt
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=edlarsen@colostate.edu

####### USAGE: $ sbatch lollipop-plots-many-genes.sh mutationList.csv uniprotQuery.csv #######
## mutationsList.csv and uniprotQuery.csv should be the output of the R script 'get-uniprot-entries-for-gene-list.R'

####### FIRST TIME ONLY #######
# Install lollipops package:
#wget https://github.com/joiningdata/lollipops/releases/download/v1.7.2/lollipops_1.7.2_linux_amd64.tar.gz
#tar -xzf lollipops_1.7.2_linux_amd64.tar.gz

###### START SCRIPT #######

# Input files
MUTATIONS_FILE=$1
UNIPROT_FILE=$2

# Temporary files
MUTATIONS_TABULATED="mutations_tabulated.txt"
UNIPROT_IDS="uniprot_ids.txt"

####### Tabulate unique mutations for each gene ####### 
# set input field separator to comma, combine first column of gene name ($1) and second column of mutation ($2) into a single Gene,Mutation pair, count the increments for each unique pair, loop through all unique Gene,Mutation combinations and split back into Gene and Mutation, then add "@"<counts>
awk -F',' ' NR > 1 {
    count[$1 FS $2]++;
} END {
    for (pair in count) {
        split(pair, fields, FS);
        mutations[fields[1]] = mutations[fields[1]] " " fields[2] "@" count[pair];
    }
    for (gene in mutations) {
        print gene "\t" mutations[gene];
    }
}' "$MUTATIONS_FILE" > "$MUTATIONS_TABULATED"

####### Extract UniProt IDs ####### 
# set field separator to comma, track line number with NR and skip header (>1), append UniProt entry in first column ($1) to gene name in 3rd column ($3), concatenate multiple entries for the same gene into space-delimited list, then loop through genes and output each gene name and associated Uniprot entries.
awk -F',' 'NR > 1 {
    genes[$3] = genes[$3] " " $1;
} END {
    for (gene in genes) {
        print gene "\t" genes[gene];
    }
}' "$UNIPROT_FILE" > "$UNIPROT_IDS"

####### Generate lollipop plots #######
# set input field separator to tab, read each line of $MUTATIONS_TABULATED and split into two variables, "GENE" and "MUTATIONS", retrieve UniProt IDs associated with the current GENE and store in variable UNIPROT_ENTRIES, then loop through uniprot entries and draw lollipop plot for that gene's mutations.
while IFS=$'\t' read -r GENE MUTATIONS; do
    UNIPROT_ENTRIES=$(awk -v gene="$GENE" -F'\t' '$1 == gene { print $2 }' "$UNIPROT_IDS")
        for ENTRY in $UNIPROT_ENTRIES; do
        CMD="./lollipops -legend -labels -w=700 -o ${GENE}_${ENTRY}.svg -U ${ENTRY} ${MUTATIONS}"
        echo "Executing: $CMD"
        eval "$CMD"
        done
done < "$MUTATIONS_TABULATED"

echo "Done"
