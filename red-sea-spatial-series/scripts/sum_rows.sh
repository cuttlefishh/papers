for i in \
krse2011_v5_clark_species_normPairedReads.csv \
krse2011_v5_clark_genera_normPairedReads.csv \
krse2011_v5_kraken_genera_normPairedReads.csv \
krse2011_v5_graftm_read1_normPairedReads.csv \
krse2011_v5_graftm_proch_read1_normPairedReads.csv \
krse2011_v5_graftm_pelag_read1_normPairedReads.csv
do
	echo $i
	python ~/scripts/myscripts/sum_rows_from_x_to_end.py $i 16
done

#krse2011_v5_clark_species_counts.csv \
#krse2011_v5_clark_genera_counts.csv \
#krse2011_v5_clark_species_norm100.csv \
#krse2011_v5_clark_genera_norm100.csv \
#krse2011_v5_kraken_genera_norm1.csv \
#krse2011_v5_graftm_read1_counts.csv \
#krse2011_v5_graftm_read1_norm1.csv \
#krse2011_v5_graftm_proch_read1_counts.csv \
#krse2011_v5_graftm_pelag_read1_counts.csv \
