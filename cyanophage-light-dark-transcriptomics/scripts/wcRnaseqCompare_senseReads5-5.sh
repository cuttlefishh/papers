echo "mydeseq2-senseReads5 vs mynoiseq-senseReads5"
echo "****************************** inf_lt_0h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_0h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_0h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_0h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_lt_1h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_1h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_1h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_1h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_lt_2h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_2h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_2h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_2h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_lt_4h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_4h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_4h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_4h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_lt_8h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_8h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_8h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_lt_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_lt_8h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_dk_0h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_0h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_0h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_0h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_0h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_dk_1h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_1h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_1h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_1h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_1h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_dk_2h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_2h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_2h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_2h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_2h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_dk_4h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_4h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_4h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_4h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_4h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
echo "****************************** inf_dk_8h_vs_ctr ******************************"
echo "DESeq2 AND NOISeq"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_8h_vs_ctr.tsv deseq2 noiseq | grep "deseq2.*noiseq" | wc -l
echo "DESeq2 ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_8h_vs_ctr.tsv deseq2 noiseq | grep "deseq2" | grep -v "noiseq" | wc -l
echo "NOISeq ONLY"
perl ~/scripts/myscripts/rnaseqCompareTsv.pl genelist_med4phm2 mydeseq2-senseReads5/mydeseq2Ho.updn.inf_dk_8h_vs_ctr.tsv mynoiseq-senseReads5/mynoiseqHo.updn.inf_dk_8h_vs_ctr.tsv deseq2 noiseq | grep "noiseq" | grep -v "deseq2" | wc -l
