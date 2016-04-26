# RUN ON COMPY

for i in plk_1_hiseq_R1_trim swt_1_hiseq_R1_trim swt_1000ng_NoRibo_R1_trim swt_1000ng_Ribodpl_R1_trim swt_100ng_NoRibo_R1_trim swt_100ng_Ribodpl_R1_trim swt_10ng_Ribodpl_R1_trim swt_1ng_Ribodpl_15cyc_R1_trim swt_1ng_Ribodpl_17cyc_R1_trim swt_25ng_Ribodpl_R1_trim swt_2ng_Ribodpl_15cyc_R1_trim swt_2ng_Ribodpl_17cyc_R1_trim swt_500ng_NoRibo_R1_trim swt_500ng_Ribodpl_R1_trim swt_50ng_Ribodpl_R1_trim swt_5ng_Ribodpl_15cyc_R1_trim swt_5ng_Ribodpl_17cyc_R1_trim
do
	echo "htseq-count -f bam -r pos -s reverse -t CDS -a 0 ${i}.sorted.bam VfES114_fixed.gff > ${i}_CDS.tsv"
done

for i in plk_1_hiseq_R1_trim swt_1_hiseq_R1_trim swt_1000ng_NoRibo_R1_trim swt_1000ng_Ribodpl_R1_trim swt_100ng_NoRibo_R1_trim swt_100ng_Ribodpl_R1_trim swt_10ng_Ribodpl_R1_trim swt_1ng_Ribodpl_15cyc_R1_trim swt_1ng_Ribodpl_17cyc_R1_trim swt_25ng_Ribodpl_R1_trim swt_2ng_Ribodpl_15cyc_R1_trim swt_2ng_Ribodpl_17cyc_R1_trim swt_500ng_NoRibo_R1_trim swt_500ng_Ribodpl_R1_trim swt_50ng_Ribodpl_R1_trim swt_5ng_Ribodpl_15cyc_R1_trim swt_5ng_Ribodpl_17cyc_R1_trim
do
	echo "htseq-count -f bam -r pos -s reverse -t rRNA -a 0 ${i}.sorted.bam VfES114_fixed.gff > ${i}_rRNA.tsv"
done

