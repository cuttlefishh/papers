perl ~/scripts/myscripts/noiseqPlotRank.pl mynoiseqHo.all.inf_lt_0h.ctr_lt_0h.csv mynoiseqHo.all.inf_lt_1h.ctr_lt_1h.csv mynoiseqHo.all.inf_lt_2h.ctr_lt_2h.csv mynoiseqHo.all.inf_lt_4h.ctr_lt_4h.csv mynoiseqHo.all.inf_lt_8h.ctr_lt_8h.csv genes_med4phm2.tsv 0.8 > inf_vs_ctr.lt.rank.tsv

perl ~/scripts/myscripts/noiseqPlotRank.pl mynoiseqHo.all.inf_dk_0h.ctr_dk_0h.csv mynoiseqHo.all.inf_dk_1h.ctr_dk_1h.csv mynoiseqHo.all.inf_dk_2h.ctr_dk_2h.csv mynoiseqHo.all.inf_dk_4h.ctr_dk_4h.csv mynoiseqHo.all.inf_dk_8h.ctr_dk_8h.csv genes_med4phm2.tsv 0.8 > inf_vs_ctr.dk.rank.tsv

perl ~/scripts/myscripts/noiseqPlotRank.pl mynoiseqHo.all.inf_lt_0h.inf_dk_0h.csv mynoiseqHo.all.inf_lt_1h.inf_dk_1h.csv mynoiseqHo.all.inf_lt_2h.inf_dk_2h.csv mynoiseqHo.all.inf_lt_4h.inf_dk_4h.csv mynoiseqHo.all.inf_lt_8h.inf_dk_8h.csv genes_med4phm2.tsv 0.8 > lt_vs_dk.inf.rank.tsv

perl ~/scripts/myscripts/noiseqPlotRank.pl mynoiseqHo.all.ctr_lt_0h.ctr_dk_0h.csv mynoiseqHo.all.ctr_lt_1h.ctr_dk_1h.csv mynoiseqHo.all.ctr_lt_2h.ctr_dk_2h.csv mynoiseqHo.all.ctr_lt_4h.ctr_dk_4h.csv mynoiseqHo.all.ctr_lt_8h.ctr_dk_8h.csv genes_med4phm2.tsv 0.8 > lt_vs_dk.ctr.rank.tsv

perl ~/scripts/myscripts/noiseqPlotRank.pl mynoiseqPh.all.inf_lt_0h.inf_dk_0h.csv mynoiseqPh.all.inf_lt_1h.inf_dk_1h.csv mynoiseqPh.all.inf_lt_2h.inf_dk_2h.csv mynoiseqPh.all.inf_lt_4h.inf_dk_4h.csv mynoiseqPh.all.inf_lt_8h.inf_dk_8h.csv genes_med4phm2.tsv 0.8 > lt_vs_dk.ph.rank.tsv

