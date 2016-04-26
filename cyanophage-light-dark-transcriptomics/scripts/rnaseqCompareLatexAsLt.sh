echo "\begin{tabular}{ l r r r l l }
\hline \addlinespace[1mm]
Locus tag & \multicolumn{2}{c}{Counts (\sc{rpkm})} & Fold ch. & Gene name and function & Pathway \\\\
\cline{2-3}
 & \multicolumn{1}{c}{Inf.} & \multicolumn{1}{c}{Uninf.} & \multicolumn{1}{c}{(log\$_2\$)} & & \\\\"

echo "\addlinespace[0.5mm] \hline \addlinespace[1mm]
\multicolumn{6}{c}{\em *** 30 min post-inoculation ***} \\\\"
perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-antisenseReads5/mydeseq2HoAs.updn.inf_lt_0h_vs_ctr.tsv mynoiseq-antisenseReads5/mynoiseqHoAs.updn.inf_lt_0h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg2.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list | sed 's/_/\\us{}/g' > temp2
cat temp2 | grep "deseq2.*noiseq" | perl -ne 'chomp; @f = split /\t/; if ($f[4]>0) { $f[4] .= " \$\\Uparrow\$"; $ff = join(" \} & \\textcolor\{blue\}\{ ",@f[0,5,6,4,7,8]) } else { $f[4] .= " \$\\Downarrow\$"; $ff = join(" \} & \\textcolor\{red\}\{ ",@f[0,5,6,4,7,8]) }; if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { if ($f[4]>0) { print "\\textcolor\{blue\}\{ $ff \} \\\\\n"} else { print "\\textcolor\{red\}\{ $ff \} \\\\\n"}}' | sed 's/RNA-/RNA\\us{}/' > temp3
sort -n -r -k14 temp3

echo "\addlinespace[0.5mm] \hline \addlinespace[1mm]
\multicolumn{6}{c}{\em *** 1.5 h post-inoculation ***} \\\\"
perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-antisenseReads5/mydeseq2HoAs.updn.inf_lt_1h_vs_ctr.tsv mynoiseq-antisenseReads5/mynoiseqHoAs.updn.inf_lt_1h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg2.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list | sed 's/_/\\us{}/g' > temp2
cat temp2 | grep "deseq2.*noiseq" | perl -ne 'chomp; @f = split /\t/; if ($f[4]>0) { $f[4] .= " \$\\Uparrow\$"; $ff = join(" \} & \\textcolor\{blue\}\{ ",@f[0,5,6,4,7,8]) } else { $f[4] .= " \$\\Downarrow\$"; $ff = join(" \} & \\textcolor\{red\}\{ ",@f[0,5,6,4,7,8]) }; if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { if ($f[4]>0) { print "\\textcolor\{blue\}\{ $ff \} \\\\\n"} else { print "\\textcolor\{red\}\{ $ff \} \\\\\n"}}' | sed 's/RNA-/RNA\\us{}/' > temp3
sort -n -r -k14 temp3

echo "\addlinespace[0.5mm] \hline \addlinespace[1mm]
\multicolumn{6}{c}{\em *** 2.5 h post-inoculation ***} \\\\"
perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-antisenseReads5/mydeseq2HoAs.updn.inf_lt_2h_vs_ctr.tsv mynoiseq-antisenseReads5/mynoiseqHoAs.updn.inf_lt_2h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg2.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list | sed 's/_/\\us{}/g' > temp2
cat temp2 | grep "deseq2.*noiseq" | perl -ne 'chomp; @f = split /\t/; if ($f[4]>0) { $f[4] .= " \$\\Uparrow\$"; $ff = join(" \} & \\textcolor\{blue\}\{ ",@f[0,5,6,4,7,8]) } else { $f[4] .= " \$\\Downarrow\$"; $ff = join(" \} & \\textcolor\{red\}\{ ",@f[0,5,6,4,7,8]) }; if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { if ($f[4]>0) { print "\\textcolor\{blue\}\{ $ff \} \\\\\n"} else { print "\\textcolor\{red\}\{ $ff \} \\\\\n"}}' | sed 's/RNA-/RNA\\us{}/' > temp3
sort -n -r -k14 temp3

echo "\addlinespace[0.5mm] \hline \addlinespace[1mm]
\multicolumn{6}{c}{\em *** 4.5 h post-inoculation ***} \\\\"
perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-antisenseReads5/mydeseq2HoAs.updn.inf_lt_4h_vs_ctr.tsv mynoiseq-antisenseReads5/mynoiseqHoAs.updn.inf_lt_4h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg2.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list | sed 's/_/\\us{}/g' > temp2
cat temp2 | grep "deseq2.*noiseq" | perl -ne 'chomp; @f = split /\t/; if ($f[4]>0) { $f[4] .= " \$\\Uparrow\$"; $ff = join(" \} & \\textcolor\{blue\}\{ ",@f[0,5,6,4,7,8]) } else { $f[4] .= " \$\\Downarrow\$"; $ff = join(" \} & \\textcolor\{red\}\{ ",@f[0,5,6,4,7,8]) }; if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { if ($f[4]>0) { print "\\textcolor\{blue\}\{ $ff \} \\\\\n"} else { print "\\textcolor\{red\}\{ $ff \} \\\\\n"}}' | sed 's/RNA-/RNA\\us{}/' > temp3
sort -n -r -k14 temp3

echo "\addlinespace[0.5mm] \hline \addlinespace[1mm]
\multicolumn{6}{c}{\em *** 8.5 h post-inoculation ***} \\\\"
perl ~/scripts/myscripts/rnaseqCompareTsv2.pl genelist_med4phm2 mydeseq2-antisenseReads5/mydeseq2HoAs.updn.inf_lt_8h_vs_ctr.tsv mynoiseq-antisenseReads5/mynoiseqHoAs.updn.inf_lt_8h_vs_ctr.tsv deseq2 noiseq > temp1
perl ~/scripts/myscripts/rnaseqDegAddKegg2.pl temp1 genelist_PMM_latex.tsv pmm_xrefall_latex.list pmm_pathwayNames_latex.list | sed 's/_/\\us{}/g' > temp2
cat temp2 | grep "deseq2.*noiseq" | perl -ne 'chomp; @f = split /\t/; if ($f[4]>0) { $f[4] .= " \$\\Uparrow\$"; $ff = join(" \} & \\textcolor\{blue\}\{ ",@f[0,5,6,4,7,8]) } else { $f[4] .= " \$\\Downarrow\$"; $ff = join(" \} & \\textcolor\{red\}\{ ",@f[0,5,6,4,7,8]) }; if (($f[5]+$f[6]>=500)&&(abs($f[4])>=0.4)) { if ($f[4]>0) { print "\\textcolor\{blue\}\{ $ff \} \\\\\n"} else { print "\\textcolor\{red\}\{ $ff \} \\\\\n"}}' | sed 's/RNA-/RNA\\us{}/' > temp3
sort -n -r -k14 temp3

echo "\addlinespace[.5mm] \hline
\end{tabular}"

/bin/rm temp1
/bin/rm temp2
/bin/rm temp3
