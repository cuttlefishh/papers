for bool in True False
do
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'Phosphate,Flagellar,LipidPerox,LuxOperon,LuxIregulated,GGDEFdomain' 'bright lavender,windows blue,amber,melon,faded green,greeny yellow' $bool ~/vibrio/results/results_plk_swt_vnt.csv

	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'Phosphate' 'bright lavender' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'Flagellar' 'windows blue' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'LipidPerox' 'amber' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'LuxOperon' 'melon' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'LuxIregulated' 'faded green' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Plk 'Vented cells (RPKM)' 'Planktonic cells (RPKM)' 'GGDEFdomain' 'greeny yellow' $bool ~/vibrio/results/results_plk_swt_vnt.csv

	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'TMAOreductase,FatCatabolism,AminoAcid,PTSsugars,NonPTSsugars' 'bright blue,kelly green,goldenrod,coral,carnation pink' $bool ~/vibrio/results/results_plk_swt_vnt.csv

	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'TMAOreductase' 'bright blue' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'FatCatabolism' 'kelly green' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'AminoAcid' 'goldenrod' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'PTSsugars' 'coral' $bool ~/vibrio/results/results_plk_swt_vnt.csv
	python ~/scripts/myscripts/vibrio_plot_scatter.py Vnt Swt 'Vented cells (RPKM)' 'SWT cells (RPKM)' 'NonPTSsugars' 'carnation pink' $bool ~/vibrio/results/results_plk_swt_vnt.csv
done
