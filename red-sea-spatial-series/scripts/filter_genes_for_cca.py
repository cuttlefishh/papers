import numpy as np
import pandas as pd
from biom import load_table
from biom import Table

csv_file = '/Users/luke/krse2011/db/krse2011_v5_humann_KOrelAbund_read1.csv'
df = pd.read_csv(csv_file, index_col=0)
num_samps, num_feats = df.shape

genes = df.ix[:, 20:]
envs = df.ix[:, :20]

# Filter out all genes that weren't detected
genes = genes.loc[:, ((genes>0).sum(axis=0)==num_samps)]
with open('/Users/luke/krse2011/ordination/gene_abundance_filt1.csv', 'w') as f:
    genes.to_csv(f, index=False, sep=",", header=True)

# Filter out all genes with less than 1e-3 (1,000 CPM)
genes = genes.loc[:, genes.sum(axis=0) > 1e-3]
with open('/Users/luke/krse2011/ordination/gene_abundance_filt2.csv', 'w') as f:
    genes.to_csv(f, index=False, sep=",", header=True)

# Filter out all genes with variance less than 5e-8 (max is 4.7e-7)
genes = genes.loc[:, genes.var(axis=0) > 5e-8]
with open('/Users/luke/krse2011/ordination/gene_abundance_filt3.csv', 'w') as f:
    genes.to_csv(f, index=False, sep=",", header=True)

#Equilvalent operations with biom
# genes = df.ix[:, 20:]
# envs = df.ix[:, :20]
# table = Table(genes.values.T,
#               sample_ids=genes.index.values,
#               observation_ids=genes.columns.values)

# sparse_filter = lambda val, id_, md: (val==0).sum(axis=0) == 0
# sample_filter = lambda val, id_, md: val.sum() > 2e-4
# var_filter = lambda val, id_, md: np.var(val, ddof=1) > 2e-10

# table = table.filter(sparse_filter, axis='observation')
# table = table.filter(sample_filter, axis='observation')
# table = table.filter(var_filter, axis='observation')

# with biom_open('genes.biom', 'w') as f:
#     table.to_hdf5(f, 'red_sea_genes')
