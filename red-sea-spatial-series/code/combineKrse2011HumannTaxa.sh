# KOrelAbund

for i in KOrelAbund_ALL
do
	perl ~/scripts/myscripts/combineKrse2011HumannTaxa.pl krse2011_v3_illumina.csv ../humann/TAXA/$i.tsv krse2011_v3_humann.$i.csv
	cat krse2011_v3_humann.$i.csv | head -n 1 | perl -ne 'chomp; @F = split /,/; $i = 1; foreach $entry (@F) { print "$i\t$entry\n"; $i++ }' > list.$i.tsv
done

# for i in KOrelAbund_csy KOrelAbund_nmr KOrelAbund_SYN KOrelAbund_syg KOrelAbund_syd KOrelAbund_sye KOrelAbund_syr KOrelAbund_syx KOrelAbund_syw KOrelAbund_pub KOrelAbund_ECO KOrelAbund_PRO KOrelAbund_HLI KOrelAbund_HLII KOrelAbund_LL KOrelAbund_pma KOrelAbund_pmb KOrelAbund_pmc KOrelAbund_pme KOrelAbund_pmf KOrelAbund_pmg KOrelAbund_pmh KOrelAbund_pmi KOrelAbund_pmj KOrelAbund_pmm KOrelAbund_pmn KOrelAbund_pmt
# do
# 	perl ~/scripts/myscripts/combineKrse2011HumannTaxa.pl krse2011_v3_illumina.csv ../humann/TAXA/$i.tsv krse2011_v3_humann.$i.csv
# 	cat krse2011_v3_humann.$i.csv | head -n 1 | perl -ne 'chomp; @F = split /,/; $i = 1; foreach $entry (@F) { print "$i\t$entry\n"; $i++ }' > list.$i.tsv
# done


# pathwayRelAbund

# for i in pathwayRelAbund_pub pathwayRelAbund_ECO pathwayRelAbund_PRO pathwayRelAbund_HLI pathwayRelAbund_HLII pathwayRelAbund_LL pathwayRelAbund_pma pathwayRelAbund_pmb pathwayRelAbund_pmc pathwayRelAbund_pme pathwayRelAbund_pmf pathwayRelAbund_pmg pathwayRelAbund_pmh pathwayRelAbund_pmi pathwayRelAbund_pmj pathwayRelAbund_pmm pathwayRelAbund_pmn pathwayRelAbund_pmt
# do
# 	perl ~/scripts/myscripts/combineKrse2011HumannTaxa.pl krse2011_v3_illumina.csv ../humann/TAXA/$i.tsv krse2011_v3_humann.$i.csv
# done


