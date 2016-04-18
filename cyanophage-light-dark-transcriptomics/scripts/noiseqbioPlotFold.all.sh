#remove lines for PHM2 genes, LSU/SSU, and missing data from NOISeq
#remove leading header field for R-style table

perl ~/scripts/myscripts/noiseqbioPlotFold.pl mynoiseqHo.all.inf_lt_0h.ctr_lt_0h.csv mynoiseqHo.all.inf_lt_1h.ctr_lt_1h.csv mynoiseqHo.all.inf_lt_2h.ctr_lt_2h.csv mynoiseqHo.all.inf_lt_4h.ctr_lt_4h.csv mynoiseqHo.all.inf_lt_8h.ctr_lt_8h.csv ~/lightdark/bioconductor/genes_med4phm2_latex.tsv 0 | grep -v "PHM2" | grep -v "MED4-0347" | grep -v "MED4-0350" | grep -v "\t\t" > inf_vs_ctr.lt.fold.all.tsv

perl ~/scripts/myscripts/noiseqbioPlotFold.pl mynoiseqHo.all.inf_dk_0h.ctr_dk_0h.csv mynoiseqHo.all.inf_dk_1h.ctr_dk_1h.csv mynoiseqHo.all.inf_dk_2h.ctr_dk_2h.csv mynoiseqHo.all.inf_dk_4h.ctr_dk_4h.csv mynoiseqHo.all.inf_dk_8h.ctr_dk_8h.csv ~/lightdark/bioconductor/genes_med4phm2_latex.tsv 0 | grep -v "PHM2" | grep -v "MED4-0347" | grep -v "MED4-0350" | grep -v "\t\t" > inf_vs_ctr.dk.fold.all.tsv

perl ~/scripts/myscripts/noiseqbioPlotFold.pl mynoiseqHo.all.inf_lt_0h.inf_dk_0h.csv mynoiseqHo.all.inf_lt_1h.inf_dk_1h.csv mynoiseqHo.all.inf_lt_2h.inf_dk_2h.csv mynoiseqHo.all.inf_lt_4h.inf_dk_4h.csv mynoiseqHo.all.inf_lt_8h.inf_dk_8h.csv ~/lightdark/bioconductor/genes_med4phm2_latex.tsv 0 | grep -v "PHM2" | grep -v "MED4-0347" | grep -v "MED4-0350" | grep -v "\t\t" > lt_vs_dk.inf.fold.all.tsv

perl ~/scripts/myscripts/noiseqbioPlotFold.pl mynoiseqHo.all.ctr_lt_0h.ctr_dk_0h.csv mynoiseqHo.all.ctr_lt_1h.ctr_dk_1h.csv mynoiseqHo.all.ctr_lt_2h.ctr_dk_2h.csv mynoiseqHo.all.ctr_lt_4h.ctr_dk_4h.csv mynoiseqHo.all.ctr_lt_8h.ctr_dk_8h.csv ~/lightdark/bioconductor/genes_med4phm2_latex.tsv 0 | grep -v "PHM2" | grep -v "MED4-0347" | grep -v "MED4-0350" | grep -v "\t\t" > lt_vs_dk.ctr.fold.all.tsv

#perl ~/scripts/myscripts/noiseqbioPlotFold.pl mynoiseqPh.all.inf_lt_0h.inf_dk_0h.csv mynoiseqPh.all.inf_lt_1h.inf_dk_1h.csv mynoiseqPh.all.inf_lt_2h.inf_dk_2h.csv mynoiseqPh.all.inf_lt_4h.inf_dk_4h.csv mynoiseqPh.all.inf_lt_8h.inf_dk_8h.csv ~/lightdark/bioconductor/genes_med4phm2_latex.tsv 0.95 > lt_vs_dk.ph.fold.tsv
