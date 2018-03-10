for i in filt3 #all gt20000 gt50000
do
	cd ~/krse2011/ordination/cca-by-pathway-${i}-goi
	/bin/rm *.list
	cat cca_top_pathways_by_KO.csv | sed "s/'//g" | sed 's/, /,/g' | sed 's/"\[//g' | sed 's/\]"//g' | sed 's/,/	/' | sed 's/\/ //g' > temp
	cat temp | perl -lne 'm/(.*)	(.*)/; @KOS = split(",",$2); $kos = join("\n",@KOS); open(NEWFILE,">$1.list"); print NEWFILE $kos'
	/bin/rm temp
	rename.pl 's/ /_/g' *.list
	rename.pl 's/[\(\)]//g' *.list
	rename.pl 's/\/ //g' *.list
done
