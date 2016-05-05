# RUN ON COMPY

# echo "bwa index /home/luth1104/vibrio/genome/VfES114_fixed.fna -p bwaIndex_VfES114"

# for i in swt_100ng_NoRibo_R1 swt_500ng_NoRibo_R1 swt_1000ng_NoRibo_R1 swt_100ng_Ribodpl_R1 swt_500ng_Ribodpl_R1 swt_1000ng_Ribodpl_R1 #plk_1_miseq_R1 plk_1_miseq_R2 swt_1_miseq_R1 swt_1_miseq_R2
# do
# 	echo "bwa aln bwaIndex_VfES114 /home/luth1104/vibrio/fastq/${i}.fastq -f /home/luth1104/vibrio/bwa/${i}.sai 2> ${i}.log &"
# done

# for i in swt_100ng_NoRibo_R1 swt_500ng_NoRibo_R1 swt_1000ng_NoRibo_R1 swt_100ng_Ribodpl_R1 swt_500ng_Ribodpl_R1 swt_1000ng_Ribodpl_R1 #plk_1_miseq_R1 plk_1_miseq_R2 swt_1_miseq_R1 swt_1_miseq_R2
# do
# 	echo "bwa samse bwaIndex_VfES114 /home/luth1104/vibrio/bwa/${i}.sai /home/luth1104/vibrio/fastq/${i}.fastq -f /home/luth1104/vibrio/sam/${i}.sam 2> ${i}.log &"
# done

# for i in swt_100ng_Ribodpl_R1 swt_500ng_Ribodpl_R1 swt_1000ng_Ribodpl_R1 swt_100ng_NoRibo_R1 swt_500ng_NoRibo_R1 swt_1000ng_NoRibo_R1  #plk_1_miseq_R1 plk_1_miseq_R2 swt_1_miseq_R1 swt_1_miseq_R2
# do
# 	samtools view -bS /home/luth1104/vibrio/sam/${i}.sam -o /home/luth1104/vibrio/sam/${i}.bam
# 	samtools sort /home/luth1104/vibrio/sam/${i}.bam /home/luth1104/vibrio/sam/${i}.sorted
# 	samtools index /home/luth1104/vibrio/sam/${i}.sorted.bam
# done

# RUN ON AIRCUTTLE

for i in swt_100ng_Ribodpl_R1 swt_500ng_Ribodpl_R1 swt_1000ng_Ribodpl_R1 swt_100ng_NoRibo_R1 swt_500ng_NoRibo_R1 swt_1000ng_NoRibo_R1 #plk_1_miseq_R1 plk_1_miseq_R2 swt_1_miseq_R1 swt_1_miseq_R2
do
	echo "htseq-count -f bam -r pos -s reverse -t CDS -a 0 ~/compy/vibrio/sam/${i}.sorted.bam ~/compy/vibrio/genome/VfES114_fixed.gff > ~/compy/vibrio/sam/${i}_CDS_a0_rev.tsv"
done

for i in swt_100ng_Ribodpl_R1 swt_500ng_Ribodpl_R1 swt_1000ng_Ribodpl_R1 swt_100ng_NoRibo_R1 swt_500ng_NoRibo_R1 swt_1000ng_NoRibo_R1 #plk_1_miseq_R1 plk_1_miseq_R2 swt_1_miseq_R1 swt_1_miseq_R2
do
	echo "htseq-count -f bam -r pos -s reverse -t rRNA -a 0 ~/compy/vibrio/sam/${i}.sorted.bam ~/compy/vibrio/genome/VfES114_fixed.gff > ~/compy/vibrio/sam/${i}_rRNA_a0_rev.tsv"
done
