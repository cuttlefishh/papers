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

/bin/rm temp1
/bin/rm temp2
/bin/rm temp3
