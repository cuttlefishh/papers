# first run filter_genes_for_cca.py then CCA_Code_from_Gareth_LRT.R
for i in filt3 #gt1000 gt20000 gt50000
do
	cat CCA_${i}_genes.csv | sed 's/""/Gene/' | sed 's/"//g' | perl -lpe 's/,/\t/g' > CCA_genes_${i}_loadings.tsv
	cat CCA_${i}_predictors.csv | sed 's/""/Predictor/' | sed 's/"//g' | perl -lpe 's/,/\t/g' > CCA_genes_${i}_predictors.tsv
	cat CCA_${i}_samples.csv | sed 's/""/Sample/' | sed 's/"//g' | perl -lpe 's/,/\t/g' > CCA_genes_${i}_samples.tsv
done
