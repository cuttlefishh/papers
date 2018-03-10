# no magnitude filter for "filt3" because already applied variance filter
for i in filt3 #all gt20000 gt50000 # gt1000 -- grep out of memory
do
	# no filter now! previously did... get top (mag>=1) genes by CCA magnitude (using output of s2_sort_genes_by_CCA.sh) -- "goi" means mag>=1
	cat CCA_genes_${i}_loadings_sort_mag.tsv | tail -n +2 | perl -alne 'print $F[0] if $F[3]>=0' > goi_CCA_${i}.list
	wc -l goi_CCA_${i}.list
	# create grep search term for genes of interest
	cat goi_CCA_${i}.list | perl -pe 's/\n/\\\|/' | perl -pe 'chomp; chop; chop' > goi_CCA_${i}.grep
	# get clean list (overwriting above) -- "goi" now means mag>=1 and non-hypothetical description exists (clean)
	cat ../humann/humann_KOrelAbund.list | grep `cat goi_CCA_${i}.grep` | grep -v "K.....$" | grep -v ": hypothetical protein" | perl -alne 'chop $F[0]; print $F[0]' > goi_CCA_${i}.list
	wc -l goi_CCA_${i}.list
	# create grep search term for clean list (overwriting above)
	cat goi_CCA_${i}.list | perl -pe 's/\n/\\\|/' | perl -pe 'chomp; chop; chop' > goi_CCA_${i}.grep
	# get CCA loadings for genes of interest
	cat CCA_genes_${i}_loadings_sort_mag.tsv | head -n 1 > CCA_genes_${i}_loadings_goi.tsv
	cat CCA_genes_${i}_loadings_sort_mag.tsv | tail -n +2 | grep `cat goi_CCA_${i}.grep` >> CCA_genes_${i}_loadings_goi.tsv	
done
