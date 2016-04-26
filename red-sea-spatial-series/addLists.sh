for i in PathwayCoverage PathwayRelAbund
do
    perl ~/scripts/myscripts/transposeTsv.pl list$i.txt entries
    cat entries humann$i.tsv > entriesdata
    /bin/rm entries
    perl ~/scripts/myscripts/transposeTsv.pl entriesdata humann$i.T.tsv
    /bin/rm entriesdata
    hashLookup_v1.pl humann$i.T.tsv ~/krse2011/humann/humann_$i.tsv 0 0 1 > datadescr
    perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]); print "$ff\n"' datadescr > humann$i.T.tsv
    /bin/rm datadescr
    cat header.tsv humann$i.T.tsv > temp
    mv temp humann$i.T.tsv
done
