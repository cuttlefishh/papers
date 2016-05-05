# clear workspace
rm(list=ls())

# call deseq library
library("DESeq2")

# call noiseq library for count filtering
library("NOISeq")

# read in counts files
countsTable10ngRibodplCDS <- read.delim(
  "swt_10ng_Ribodpl_R1_CDS_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable10ngRibodplrRNA <- read.delim(
  "swt_10ng_Ribodpl_R1_rRNA_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable25ngRibodplCDS <- read.delim(
  "swt_25ng_Ribodpl_R1_CDS_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable25ngRibodplrRNA <- read.delim(
  "swt_25ng_Ribodpl_R1_rRNA_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable50ngRibodplCDS <- read.delim(
  "swt_50ng_Ribodpl_R1_CDS_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable50ngRibodplrRNA <- read.delim(
  "swt_50ng_Ribodpl_R1_rRNA_a0_rev.tsv",
  header=FALSE,
  stringsAsFactors=FALSE,
  sep="\t",
  quote="")
countsTable100ngRibodplCDS <- read.delim(
	"swt_100ng_Ribodpl_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable100ngRibodplrRNA <- read.delim(
	"swt_100ng_Ribodpl_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable500ngRibodplCDS <- read.delim(
	"swt_500ng_Ribodpl_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable500ngRibodplrRNA <- read.delim(
	"swt_500ng_Ribodpl_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable1000ngRibodplCDS <- read.delim(
	"swt_1000ng_Ribodpl_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable1000ngRibodplrRNA <- read.delim(
	"swt_1000ng_Ribodpl_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable100ngNoRiboCDS <- read.delim(
	"swt_100ng_NoRibo_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable100ngNoRiborRNA <- read.delim(
	"swt_100ng_NoRibo_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable500ngNoRiboCDS <- read.delim(
	"swt_500ng_NoRibo_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable500ngNoRiborRNA <- read.delim(
	"swt_500ng_NoRibo_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable1000ngNoRiboCDS <- read.delim(
	"swt_1000ng_NoRibo_R1_CDS_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
countsTable1000ngNoRiborRNA <- read.delim(
	"swt_1000ng_NoRibo_R1_rRNA_a0_rev.tsv",
	header=FALSE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")
	
# combine counts tables and add row/column names
countsTableCDS = cbind(countsTable10ngRibodplCDS[1:3815,2], countsTable25ngRibodplCDS[1:3815,2], countsTable50ngRibodplCDS[1:3815,2], countsTable100ngRibodplCDS[1:3815,2], countsTable500ngRibodplCDS[1:3815,2], countsTable1000ngRibodplCDS[1:3815,2], countsTable100ngNoRiboCDS[1:3815,2], countsTable500ngNoRiboCDS[1:3815,2], countsTable1000ngNoRiboCDS[1:3815,2])
countsRownamesCDS = countsTable100ngRibodplCDS[1:3815,1]
countsColnamesCDS = c("10ng_Ribodpl", "25ng_Ribodpl", "50ng_Ribodpl", "100ng_Ribodpl", "500ng_Ribodpl", "1000ng_Ribodpl", "100ng_NoRibo", "500ng_NoRibo", "1000ng_NoRibo")
countsTableCDS = matrix(countsTableCDS,ncol=9,dimnames=list(countsRownamesCDS,countsColnamesCDS))

countsTablerRNA = cbind(countsTable10ngRibodplrRNA[1:37,2], countsTable25ngRibodplrRNA[1:37,2], countsTable50ngRibodplrRNA[1:37,2], countsTable100ngRibodplrRNA[1:37,2], countsTable500ngRibodplrRNA[1:37,2], countsTable1000ngRibodplrRNA[1:37,2], countsTable100ngNoRiborRNA[1:37,2], countsTable500ngNoRiborRNA[1:37,2], countsTable1000ngNoRiborRNA[1:37,2])
countsRownamesrRNA = countsTable100ngRibodplrRNA[1:37,1]
countsColnamesrRNA = c("10ng_Ribodpl", "25ng_Ribodpl", "50ng_Ribodpl", "100ng_Ribodpl", "500ng_Ribodpl", "1000ng_Ribodpl", "100ng_NoRibo", "500ng_NoRibo", "1000ng_NoRibo")
countsTablerRNA = matrix(countsTablerRNA,ncol=9,dimnames=list(countsRownamesrRNA,countsColnamesrRNA))

# filter low counts
countsTableFilt = filtered.data(
	countsTableCDS, 
	factor = c("10ng_Ribodpl", "25ng_Ribodpl", "50ng_Ribodpl", "100ng_Ribodpl", "500ng_Ribodpl", "1000ng_Ribodpl", "100ng_NoRibo", "500ng_NoRibo", "1000ng_NoRibo"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)

# store deseq design as data.frame/matrix
colData <- data.frame(
	row.names = colnames(countsTableFilt), 
	condition = c("10ng_Ribodpl", "25ng_Ribodpl", "50ng_Ribodpl", "100ng_Ribodpl", "500ng_Ribodpl", "1000ng_Ribodpl", "100ng_NoRibo", "500ng_NoRibo", "1000ng_NoRibo"),
	 libType = c("single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end"))

# deseq data from matrix
dds <- DESeqDataSetFromMatrix(
	countData = countsTableFilt,
	colData = colData,
	design = ~ condition)

# pull condtions from design
colData(dds)$condition <- factor(
	colData(dds)$condition,
	levels = c("10ng_Ribodpl", "25ng_Ribodpl", "50ng_Ribodpl", "100ng_Ribodpl", "500ng_Ribodpl", "1000ng_Ribodpl", "100ng_NoRibo", "500ng_NoRibo", "1000ng_NoRibo"))

# differential expression analysis
dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

# contrast condition 1000ngRibodpl_vs_1000ngNoRibo
res <- results(dds, contrast=c("condition","1000ng_Ribodpl","1000ng_NoRibo"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.1000ngRibodpl_vs_1000ngNoRibo.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.1000ngRibodpl_vs_1000ngNoRibo.csv",quote = FALSE)

# contrast condition 500ngRibodpl_vs_500ngNoRibo
res <- results(dds, contrast=c("condition","500ng_Ribodpl","500ng_NoRibo"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.500ngRibodpl_vs_500ngNoRibo.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.500ngRibodpl_vs_500ngNoRibo.csv",quote = FALSE)

# contrast condition 100ngRibodpl_vs_100ngNoRibo
res <- results(dds, contrast=c("condition","100ng_Ribodpl","100ng_NoRibo"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.100ngRibodpl_vs_100ngNoRibo.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.100ngRibodpl_vs_100ngNoRibo.csv",quote = FALSE)

# contrast condition 1000ngRibodpl_vs_100ngRibodbl
res <- results(dds, contrast=c("condition","1000ng_Ribodpl","100ng_Ribodpl"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.1000ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.1000ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)

# contrast condition 500ngRibodpl_vs_100ngRibodbl
res <- results(dds, contrast=c("condition","500ng_Ribodpl","100ng_Ribodpl"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.500ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.500ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)

# contrast condition 50ngRibodpl_vs_100ngRibodbl
res <- results(dds, contrast=c("condition","50ng_Ribodpl","100ng_Ribodpl"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.50ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.50ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)

# contrast condition 25ngRibodpl_vs_100ngRibodbl
res <- results(dds, contrast=c("condition","25ng_Ribodpl","100ng_Ribodpl"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.25ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.25ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)

# contrast condition 10ngRibodpl_vs_100ngRibodbl
res <- results(dds, contrast=c("condition","10ng_Ribodpl","100ng_Ribodpl"), independentFiltering=FALSE, cooksCutoff=FALSE)
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.05)&(abs(res$log2FoldChange) > 1.0),]
write.csv(res[order(res$pval),],file="mydeseq2.all.10ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
write.csv(resSig[order(resSig$pval),],file="mydeseq2.sig.10ngRibodpl_vs_100ngRibodpl.csv",quote = FALSE)
