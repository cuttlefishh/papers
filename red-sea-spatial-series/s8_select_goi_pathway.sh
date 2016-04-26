for i in filt3 #all gt20000 gt50000
do
	cd ~/krse2011/ordination/cca-by-pathway-${i}-goi
	/bin/rm *.grep
	/bin/rm *.tsv
	#/bin/rm Other.txt # remove other if grep runs out of memory
	# loop over each pathway's KOs
	for j in `ls *.list | sed 's/.list//'`
	do
		# create grep search term for KOs
		cat $j.list | perl -pe 's/\n/\\\|/' | perl -pe 'chop; chop; chop' > $j.grep
		# get CCA loadings for KOs
		cat ../CCA_genes_${i}_loadings_sort_mag.tsv | head -n 1 > cca_genes_loadings_$j.tsv
		cat ../CCA_genes_${i}_loadings_sort_mag.tsv | tail -n +2 | grep `cat $j.grep` >> cca_genes_loadings_$j.tsv
	done
done
