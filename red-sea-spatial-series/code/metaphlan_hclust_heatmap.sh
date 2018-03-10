for i in clark_genera_norm100 clark_genera_normPairedReads
do
	python ~/bin/metaphlan2/utils/metaphlan_hclust_heatmap.py -c Blues --top 50 -s log --tax_lev a --in ~/krse2011/clark/${i}_heatmap.tsv --out ~/krse2011/clark/${i}_heatmap.png
done
