# KOrelAbund
for i in KOrelAbund_K06045 
do
	perl ~/scripts/myscripts/combineKrse2011HumannTaxaByKO.pl krse2011_v3_illumina.csv ../humann/TAXA/$i.tsv krse2011_v3_humann.$i.csv
	cat krse2011_v3_humann.$i.csv | head -n 1 | perl -ne 'chomp; @F = split /,/; $i = 1; foreach $entry (@F) { print "$i\t$entry\n"; $i++ }' > list.$i.tsv
done


