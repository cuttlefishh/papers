/bin/rm sum_CDS_a0.tsv sum_rRNA_a0.tsv stats_a0.tsv
for i in `ls swt*CDS_a0_rev.tsv swt*CDS_a0_yes.tsv SWTculture*CDS_a0.tsv Planktonic*CDS_a0.tsv`; do echo $i >> sum_CDS_a0.tsv; head -n 3815 $i |  perl -lne '@F = split /\t/; $sum += $F[1]; END { print $sum }' >> sum_CDS_a0.tsv; done
for i in `ls swt*rRNA_a0_rev.tsv swt*rRNA_a0_yes.tsv SWTculture*rRNA_a0.tsv Planktonic*rRNA_a0.tsv`; do echo $i >> sum_rRNA_a0.tsv; head -n 37 $i |  perl -lne '@F = split /\t/; $sum += $F[1]; END { print $sum }' >> sum_rRNA_a0.tsv; done
for i in `ls swt*a0_rev.tsv swt*a0_yes.tsv SWTculture*a0.tsv Planktonic*a0.tsv`; do echo $i >> stats_a0.tsv; tail -n 5 $i >> stats_a0.tsv; done
