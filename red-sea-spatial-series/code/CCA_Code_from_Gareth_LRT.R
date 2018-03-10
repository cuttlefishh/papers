# CCA genes

# clear workspace
rm(list=ls())

# load library
library(vegan)

gene_abundance=read.csv("gene_abundance_filt3.csv") #gene_abundance2.csv
gene_abundance_predict=read.csv("gene_abundance_predict2.csv") #gene_abundance_predict2.csv

mycca <- cca(gene_abundance ~., gene_abundance_predict, scale=FALSE)

plot (cca(gene_abundance ~., gene_abundance_predict, scale=FALSE))

plot (cca(gene_abundance ~., gene_abundance_predict, scale=FALSE), display= c("sp","bp", "wa"), type="text", pch=20, cex=10)

write.csv(mycca$CCA$biplot,file='CCA_filt3_predictors.csv')
write.csv(mycca$CCA$wa,file='CCA_filt3_samples.csv')
write.csv(mycca$CCA$v,file='CCA_filt3_genes.csv')
