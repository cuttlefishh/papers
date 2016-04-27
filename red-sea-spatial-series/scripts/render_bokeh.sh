for i in Thompson_RedSea_KORelativeAbundance_AllTaxa
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "KO rel. abund. (counts/total_counts*1e6)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_KORelativeAbundance_Prochlorococcus
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Prochlorococcus KO rel. abund. (ct/tot_ct*1e6)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_KORelativeAbundance_Pelagibacter
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Pelagibacter KO rel. abund. (ct/tot_ct*1e6)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_KORelativeAbundance_Nitrosopumilus
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Nitrosopumilus KO rel. abund. (ct/tot_ct*1e6)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_PathwayCoverage_AllTaxa
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "KEGG pathway coverage" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_PathwayRelativeAbundance_AllTaxa
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "KEGG pathway relative abundance" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_PredictedRelativeMetabolicTurnover_AllTaxa
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Metabolic turnover (PRMT score)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_TaxaCounts_AllTaxa
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Taxa counts (raw, GraftM 16S)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_TaxaCounts_Prochlorococcus
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Prochlorococcus counts (raw, rpoC1)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_TaxaCounts_Pelagibacter
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Pelagibacter counts (raw, 16S)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_TaxaRelAbund_Species
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Species rel. abund. (sample sums to 100, Clark)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done
for i in Thompson_RedSea_TaxaRelAbund_Genus
do
	./bokeh_html.py -i ../ili/${i}.csv -o ${i}.html -t "Genus rel. abund. (sample sums to 100, Clark)" -c "Depth (m)" -p 10:#e41a1c,25:#ff7f00,47:#ffff33,50:#ffff33,100:#4daf4a,200:#377eb8,258:#f781bf,500:#984ea3 -l top_right X Y Z radii Station
done


