# RUN ON COMPY

# echo "bwa index /home/luth1104/vibrio/genome/VfES114_fixed.fna -p bwaIndex_VfES114"

# for i in plk_2_hiseq_R1 plk_3_hiseq_R1 swt_10ng_Ribodpl_R1 swt_25ng_Ribodpl_R1 swt_50ng_Ribodpl_R1 swt_2_hiseq_R1 swt_3_hiseq_R1 vnt_1_hiseq_R1 vnt_2_hiseq_R1 vnt_3_hiseq_R1
# do
# 	echo "bwa aln bwaIndex_VfES114 /home/luth1104/vibrio/fastq/${i}.fastq -f /home/luth1104/vibrio/bwa/${i}.sai 2> ${i}.log &" #| qsub -k oe -N bwaaln -q mem8gbq
# done

# for i in plk_2_hiseq_R1 plk_3_hiseq_R1 swt_10ng_Ribodpl_R1 swt_25ng_Ribodpl_R1 swt_50ng_Ribodpl_R1 swt_2_hiseq_R1 swt_3_hiseq_R1 vnt_1_hiseq_R1 vnt_2_hiseq_R1 vnt_3_hiseq_R1
# do
# 	echo "bwa samse bwaIndex_VfES114 /home/luth1104/vibrio/bwa/${i}.sai /home/luth1104/vibrio/fastq/${i}.fastq -f /home/luth1104/vibrio/sam/${i}.sam 2> ${i}.log &"
# done

# for i in plk_2_hiseq_R1 plk_3_hiseq_R1 swt_10ng_Ribodpl_R1 swt_25ng_Ribodpl_R1 swt_50ng_Ribodpl_R1 swt_2_hiseq_R1 swt_3_hiseq_R1 vnt_1_hiseq_R1 vnt_2_hiseq_R1 vnt_3_hiseq_R1
# do
#	samtools view -bS /home/luth1104/vibrio/sam/${i}.sam -o /home/luth1104/vibrio/sam/${i}.bam &
#	samtools sort /home/luth1104/vibrio/sam/${i}.bam /home/luth1104/vibrio/sam/${i}.sorted &
#	samtools index /home/luth1104/vibrio/sam/${i}.sorted.bam &
# done

# RUN ON COMPY

#for i in plk_2_hiseq_R1 plk_3_hiseq_R1 swt_10ng_Ribodpl_R1 swt_25ng_Ribodpl_R1 swt_50ng_Ribodpl_R1 swt_2_hiseq_R1 vnt_1_hiseq_R1 vnt_2_hiseq_R1 vnt_3_hiseq_R1
#do
#	echo "htseq-count -f bam -r pos -s reverse -t CDS -a 0 ${i}.sorted.bam VfES114_fixed.gff > ${i}_CDS_a0_rev.tsv &"
#done

for i in plk_2_hiseq_R1 plk_3_hiseq_R1 swt_10ng_Ribodpl_R1 swt_25ng_Ribodpl_R1 swt_50ng_Ribodpl_R1 swt_2_hiseq_R1 vnt_1_hiseq_R1 vnt_2_hiseq_R1 vnt_3_hiseq_R1
do
	echo "htseq-count -f bam -r pos -s reverse -t rRNA -a 0 ${i}.sorted.bam VfES114_fixed.gff > ${i}_rRNA_a0_rev.tsv &"
done

