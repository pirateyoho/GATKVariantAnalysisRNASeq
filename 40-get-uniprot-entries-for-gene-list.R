# Author: Eileen Owens
# Purpose: Save Canis lupus familiaris Uniprot IDs to tsv file

# First time only:
#remotes::install_github("VoisinneG/queryup")

library(queryup)
genes <- c("MTOR", "PTEN", "SATB1", "MYC", "BCL11B", "BCL6", "STAT3", "DNMT3A", "TNFAIP3", "TET2", "FYN", "IBTK", "FASLG", "KMT2D", "MAP2K1")

df <- query_uniprot(
  query = list("gene_exact" = genes,
               "organism_id" = c("9615")), # Canis lupus familiaris
  base_url = "https://rest.uniprot.org/uniprotkb/",
  columns = c("accession", "id", "gene_names", "organism_id"),
  max_keys = 200,
  show_progress = TRUE
)

names(df) <- sub(" ", "_", names(df)) # replace spaces in column names with _
df <- df %>%
  filter(Gene_Names %in% genes) # keep most relevant results
df <- df %>%
  arrange(Gene_Names)
write.csv(df, file="C:/Users/edlarsen/Documents/PTCLRNASeq/uniprotQuery.csv", row.names = FALSE) # write to csv
library(maftools)
maf <- read.maf(maf = "C:/Users/edlarsen/Documents/PTCLRNASeq/ptcl_unique_vars_only.maf") # import maf
maf <- subsetMaf(maf, genes = genes) # subset maf for only genes of interest
maf_df <- data.frame(gene = maf@data$Hugo_Symbol,
                     mutation = maf@data$HGVSp_Short) # minimize to just column of gene name and mutation for lollipop plots
maf_df$mutation <- sub("^p\\.", "", maf_df$mutation) # remove "p." from beginnign of mutation name
write.csv(maf_df, file="C:/Users/edlarsen/Documents/PTCLRNASeq/mutationList.csv", row.names=FALSE)
