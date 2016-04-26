# clear workspace
rm(list=ls())

# call deseq library
library("DESeq2")

# call noiseq library for count filtering
library("NOISeq")

# read in SENSE counts file
countsTable <- read.delim("med4phm2_sense_R.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "")

# split counts into host and phage counts
countsTableHo <- countsTable[1:2015,]
countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts
countsTableHo <- countsTableHo[c(-347,-350),]

# split host counts into light and dark
countsTableHoLt = countsTableHo[,c(1:10,21:30)]
countsTableHoDk = countsTableHo[,c(11:20,31:40)]

# filter low counts
countsTableHoLtFilt = filtered.data(
	countsTableHoLt, 
	factor = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)
countsTableHoDkFilt = filtered.data(
	countsTableHoDk, 
	factor = c("ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)
	
# store deseq design as data.frame/matrix
colDataLt <- data.frame(
	row.names = colnames(countsTableHoLtFilt), 
	condition = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h"),
	libType = c("single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end"))
colDataDk <- data.frame(
	row.names = colnames(countsTableHoDkFilt), 
	condition = c("ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"),
	libType = c("single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end"))

# deseq data from matrix
ddsLt <- DESeqDataSetFromMatrix(
	countData = countsTableHoLtFilt,	colData = colDataLt,	design = ~ condition)
ddsDk <- DESeqDataSetFromMatrix(
	countData = countsTableHoDkFilt,
	colData = colDataDk,
	design = ~ condition)

# pull condtions from design
colData(ddsLt)$condition <- factor(
	colData(ddsLt)$condition,
	levels = c("ctr_lt_0h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_8h", "inf_lt_0h", "inf_lt_1h", "inf_lt_2h", "inf_lt_4h", "inf_lt_8h"))
colData(ddsDk)$condition <- factor(
	colData(ddsDk)$condition,
	levels = c("ctr_dk_0h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_8h", "inf_dk_0h", "inf_dk_1h", "inf_dk_2h", "inf_dk_4h", "inf_dk_8h"))

# differential expression analysis
ddsLt <- estimateSizeFactors(ddsLt)ddsLt <- estimateDispersions(ddsLt)ddsLt <- nbinomWaldTest(ddsLt)
ddsDk <- estimateSizeFactors(ddsDk)
ddsDk <- estimateDispersions(ddsDk)
ddsDk <- nbinomWaldTest(ddsDk)

# contrast condition inf_lt_0h vs ctr_lt_0h
res <- results(ddsLt, contrast=c("condition","inf_lt_0h","ctr_lt_0h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigLt0h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigLt0h[order(resSigLt0h$pval),],file="mydeseq2Ho.updn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)

# contrast condition inf_lt_1h vs ctr_lt_1h
res <- results(ddsLt, contrast=c("condition","inf_lt_1h","ctr_lt_1h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigLt1h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigLt1h[order(resSigLt1h$pval),],file="mydeseq2Ho.updn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)

# contrast condition inf_lt_2h vs ctr_lt_2h
res <- results(ddsLt, contrast=c("condition","inf_lt_2h","ctr_lt_2h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigLt2h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigLt2h[order(resSigLt2h$pval),],file="mydeseq2Ho.updn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)

# contrast condition inf_lt_4h vs ctr_lt_4h
res <- results(ddsLt, contrast=c("condition","inf_lt_4h","ctr_lt_4h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigLt4h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigLt4h[order(resSigLt4h$pval),],file="mydeseq2Ho.updn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)

# contrast condition inf_lt_8h vs ctr_lt_8h
res <- results(ddsLt, contrast=c("condition","inf_lt_8h","ctr_lt_8h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigLt8h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigLt8h[order(resSigLt8h$pval),],file="mydeseq2Ho.updn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)

# contrast condition inf_dk_0h vs ctr_dk_0h
res <- results(ddsDk, contrast=c("condition","inf_dk_0h","ctr_dk_0h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigDk0h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigDk0h[order(resSigDk0h$pval),],file="mydeseq2Ho.updn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)

# contrast condition inf_dk_1h vs ctr_dk_1h
res <- results(ddsDk, contrast=c("condition","inf_dk_1h","ctr_dk_1h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigDk1h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigDk1h[order(resSigDk1h$pval),],file="mydeseq2Ho.updn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)

# contrast condition inf_dk_2h vs ctr_dk_2h
res <- results(ddsDk, contrast=c("condition","inf_dk_2h","ctr_dk_2h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigDk2h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigDk2h[order(resSigDk2h$pval),],file="mydeseq2Ho.updn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)

# contrast condition inf_dk_4h vs ctr_dk_4h
res <- results(ddsDk, contrast=c("condition","inf_dk_4h","ctr_dk_4h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigDk4h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigDk4h[order(resSigDk4h$pval),],file="mydeseq2Ho.updn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)

# contrast condition inf_dk_8h vs ctr_dk_8h
res <- results(ddsDk, contrast=c("condition","inf_dk_8h","ctr_dk_8h"), independentFiltering=FALSE)
res <- res[order(res$padj),]
resSigDk8h <- res[(res$padj < 0.2)&(abs(res$log2FoldChange) > 0.5),]
write.csv(resSigDk8h[order(resSigDk8h$pval),],file="mydeseq2Ho.updn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)

