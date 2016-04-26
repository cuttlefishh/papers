for i in `ls mydeseq2.sig.???.???.tsv`
do
	tail -n +2 $i | perl -alne 'print $F[1]' > list.$i
    echo list.$i
    perl -pe "s/\n/,\\\|/" list.$i
    echo ""
done
