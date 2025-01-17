# Author: Eileen Owens
# Purpose: Save Canis lupus familiaris Uniprot IDs to tsv file for use in lollipops

# First time only:
#remotes::install_github("VoisinneG/queryup")

library(queryup)
genes <- c("MTOR", "PTEN", "SATB1", "MYC", "BCL11B", "BCL6", "STAT3", "DNMT3A", "TNFAIP3", "TET2", "FYN", "IBTK", "FASLG", "KMT2D", "MAP2K1") # list of genes for lollipop plots

# Acquire UniProt IDs for genes in gene list
df <- query_uniprot(
  query = list("gene_exact" = genes,
               "organism_id" = c("9615")), # Canis lupus familiaris
  base_url = "https://rest.uniprot.org/uniprotkb/",
  columns = c("accession", "id", "gene_names", "organism_id"),
  max_keys = 200,
  show_progress = TRUE
)

names(df) <- sub(" ", "_", names(df)) # replace spaces in column names with underscores

df <- df %>%
  filter(Gene_Names %in% genes) # keep most relevant results
df <- df %>%
  arrange(Gene_Names)

write.csv(df, file="C:/Users/edlarsen/Documents/PTCLRNASeq/uniprotQuery.csv", row.names = FALSE) # write to csv

# Minimize maf file to just gene symbol and HGVSp_Short info for lollipop plots
library(maftools)
maf <- read.maf(maf = "C:/Users/edlarsen/Documents/PTCLRNASeq/ptcl_unique_vars_only.maf") # import maf
maf <- subsetMaf(maf, genes = genes) # subset maf for only genes of interest
maf_df <- data.frame(gene = maf@data$Hugo_Symbol,
                     mutation = maf@data$HGVSp_Short) # keep only these columns of data
maf_df$mutation <- sub("^p\\.", "", maf_df$mutation) # remove "p." from beginning of mutation name
write.csv(maf_df, file="C:/Users/edlarsen/Documents/PTCLRNASeq/mutationList.csv", row.names=FALSE) # write to csv
