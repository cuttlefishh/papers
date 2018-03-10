for i in filt3 #all gt20000 gt50000
do
	cd ~/krse2011/ordination/cca-by-pathway-${i}-goi
	pwd
	cat cca_top_pathways_by_KO.csv | perl -lne '@F = split /,/; print $F[0]' | sed 's/ /_/g' | sed 's/(//g' | sed 's/)//g' | sed "s/^/'/" | sed "s/$/'/" | sed 's/\/_//g'
	echo ""
done
