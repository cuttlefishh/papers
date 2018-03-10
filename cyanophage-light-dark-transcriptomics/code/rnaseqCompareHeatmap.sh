# UNINFECTED LIGHT-VS-DARK

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.ctr_lt_0h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.ctr_lt_0h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 > mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.ctr_lt_1h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.ctr_lt_1h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.ctr_lt_2h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.ctr_lt_2h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.ctr_lt_4h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.ctr_lt_4h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.ctr_lt_8h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.ctr_lt_8h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv

perl ~/scripts/myscripts/m8_tab.pl mynoiseq-senseReads5/rnaseqComparePlotCtr.tsv 0 > mynoiseq-senseReads5/rnaseqComparePlotCtr.list


# INFECTED LIGHT-VS-DARK

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_0h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_0h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 > mynoiseq-senseReads5/rnaseqComparePlotInf.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_1h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_1h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotInf.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_2h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_2h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotInf.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_4h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_4h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotInf.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_8h_vs_dk.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_8h_vs_dk.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=1.5)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotInf.tsv

perl ~/scripts/myscripts/m8_tab.pl mynoiseq-senseReads5/rnaseqComparePlotInf.tsv 0 > mynoiseq-senseReads5/rnaseqComparePlotInf.list


# LIGHT INFECTED-VS-UNINFECTED

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_0h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 > mynoiseq-senseReads5/rnaseqComparePlotLt.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_1h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotLt.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_2h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotLt.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_4h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotLt.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_8h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotLt.tsv

perl ~/scripts/myscripts/m8_tab.pl mynoiseq-senseReads5/rnaseqComparePlotLt.tsv 0 > mynoiseq-senseReads5/rnaseqComparePlotLt.list


# DARK INFECTED-VS-UNINFECTED

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_0h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 > mynoiseq-senseReads5/rnaseqComparePlotDk.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_1h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotDk.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_2h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotDk.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_4h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotDk.tsv

perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_8h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list > temp2
cat temp2 | grep "deseq2.*noiseq" | grep -v "[Hh]ypothetical protein" | perl -ne 'chomp; @f = split /\t/; $ff = join("\t",@f[0,5,6,4,7,8]); if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { print "$ff\n" }' > temp3
sort -n -r -k14 temp3 >> mynoiseq-senseReads5/rnaseqComparePlotDk.tsv

perl ~/scripts/myscripts/m8_tab.pl mynoiseq-senseReads5/rnaseqComparePlotDk.tsv 0 > mynoiseq-senseReads5/rnaseqComparePlotDk.list


# SAVE DATA FOR HEATMAPS

/bin/rm mynoiseq-senseReads5/heatmapCtr.tsv
/bin/rm mynoiseq-senseReads5/heatmapInf.tsv
/bin/rm mynoiseq-senseReads5/heatmapLt.tsv
/bin/rm mynoiseq-senseReads5/heatmapDk.tsv

LIST=$(cat mynoiseq-senseReads5/rnaseqComparePlotCtr.list mynoiseq-senseReads5/rnaseqComparePlotInf.list | sort | uniq)
for i in $LIST
do
	grep "$i" mynoiseq-senseReads5/lt_vs_dk.ctr.fold.all.tsv >> mynoiseq-senseReads5/heatmapCtr.tsv
	grep "$i" mynoiseq-senseReads5/lt_vs_dk.inf.fold.all.tsv >> mynoiseq-senseReads5/heatmapInf.tsv
done

LIST=$(cat mynoiseq-senseReads5/rnaseqComparePlotLt.list mynoiseq-senseReads5/rnaseqComparePlotDk.list | sort | uniq)
for i in $LIST
do
	grep "$i" mynoiseq-senseReads5/inf_vs_ctr.lt.fold.all.tsv >> mynoiseq-senseReads5/heatmapLt.tsv
	grep "$i" mynoiseq-senseReads5/inf_vs_ctr.dk.fold.all.tsv >> mynoiseq-senseReads5/heatmapDk.tsv
done


# CLEANUP

/bin/rm temp1
/bin/rm temp2
/bin/rm temp3
