# just using replicate 3 for scatter plots
cat mydeseq2.sig.Plk.Swt.csv | tr '\r' '\n' | sed 's/,/	/g' | tail -n +2 > mydeseq2.sig.Plk.Swt.tsv
hashLookup_v1.pl mydeseq2.sig.Plk.Swt.tsv plk_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Plk_Swt_sigPlusCount_Plk3.tsv
hashLookup_v1.pl mydeseq2.sig.Plk.Swt.tsv swt_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Plk_Swt_sigPlusCount_Swt3.tsv
cat mydeseq2.sig.Plk.Vnt.csv | tr '\r' '\n' | sed 's/,/	/g' | tail -n +2 > mydeseq2.sig.Plk.Vnt.tsv
hashLookup_v1.pl mydeseq2.sig.Plk.Vnt.tsv plk_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Plk_Vnt_sigPlusCount_Plk3.tsv
hashLookup_v1.pl mydeseq2.sig.Plk.Vnt.tsv vnt_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Plk_Vnt_sigPlusCount_Vnt3.tsv
cat mydeseq2.sig.Swt.Vnt.csv | tr '\r' '\n' | sed 's/,/	/g' | tail -n +2 > mydeseq2.sig.Swt.Vnt.tsv
hashLookup_v1.pl mydeseq2.sig.Swt.Vnt.tsv swt_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Swt_Vnt_sigPlusCount_Swt3.tsv
hashLookup_v1.pl mydeseq2.sig.Swt.Vnt.tsv vnt_3_hiseq_R1_trim_CDS_a0_reverse.tsv 0 0 1 > Swt_Vnt_sigPlusCount_Vnt3.tsv
