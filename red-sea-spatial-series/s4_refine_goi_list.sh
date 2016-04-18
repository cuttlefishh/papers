# NOT REQUIRED -- CLEAN CRITERIA ADDED TO S3_SELECT_GOI.SH

# remove genes of interest with no description or hypothetical proteins
cat ../humann/humann_KOrelAbund.list | grep `cat goi_CAP_CCA.grep` | grep -v "K.....$" | grep -v ": hypothetical protein" | perl -alne 'chop $F[0]; print $F[0]' > goi_CAP_CCA_clean.list
cat ../humann/humann_KOrelAbund.list | grep `cat goi_CCA.grep` | grep -v "K.....$" | grep -v ": hypothetical protein" | perl -alne 'chop $F[0]; print $F[0]' > goi_CCA_clean.list

# create grep search term
cat goi_CAP_CCA_clean.list | perl -pe 's/\n/\\\|/' | perl -pe 'chomp; chop; chop' > goi_CAP_CCA_clean.grep
cat goi_CCA_clean.list | perl -pe 's/\n/\\\|/' | perl -pe 'chomp; chop; chop' > goi_CCA_clean.grep

# get CCA loadings for genes of interest
cat CCA_genes_loadings.tsv | head -n 1 > CCA_genes_loadings_goi_CAP_CCA_clean.tsv
cat CCA_genes_loadings.tsv | tail -n +2 | grep `cat goi_CAP_CCA_clean.grep` >> CCA_genes_loadings_goi_CAP_CCA_clean.tsv
cat CCA_genes_loadings.tsv | head -n 1 > CCA_genes_loadings_goi_CCA_clean.tsv
cat CCA_genes_loadings.tsv | tail -n +2 | grep `cat goi_CCA_clean.grep` >> CCA_genes_loadings_goi_CCA_clean.tsv

