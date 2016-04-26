# clear workspace
rm(list=ls())

# call deseq library
library("DESeq2")

# call noiseq library for count filtering -- SHOULDN'T BE NECESSARY AS DESEQ2 DOES BY DEFAULT, BUT GETTING ERRORS OTHERWISE
library("NOISeq")

# read in counts files
countsTablePlk1 <- read.delim("plk_1_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTablePlk2 <- read.delim("plk_2_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTablePlk3 <- read.delim("plk_3_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableSwt1 <- read.delim("swt_1_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableSwt2 <- read.delim("swt_2_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableSwt3 <- read.delim("swt_3_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableVnt1 <- read.delim("vnt_1_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableVnt2 <- read.delim("vnt_2_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")
countsTableVnt3 <- read.delim("vnt_3_hiseq_R1_trim_CDS.tsv", header=FALSE, stringsAsFactors=FALSE, sep="\t", quote="")

# combine counts tables and add row/column names, removing last 5 rows which are:
# __no_feature          4930366
# __ambiguous           547203
# __too_low_aQual       0
# __not_aligned         837148
# __alignment_not_uni…  0
mydim = dim(countsTablePlk1)
mylength = mydim[1]
countsTable = cbind(countsTablePlk1[1:(mylength-5),2], countsTablePlk2[1:(mylength-5),2], countsTablePlk3[1:(mylength-5),2], countsTableSwt1[1:(mylength-5),2], countsTableSwt2[1:(mylength-5),2], countsTableSwt3[1:(mylength-5),2], countsTableVnt1[1:(mylength-5),2], countsTableVnt2[1:(mylength-5),2], countsTableVnt3[1:(mylength-5),2])
countsRownames = countsTablePlk1[1:(mylength-5),1]
countsColnames = c("Plk1", "Plk2", "Plk3", "Swt1", "Swt2", "Swt3", "Vnt1", "Vnt2", "Vnt3")
countsTable = matrix(countsTable, ncol=9, dimnames=list(countsRownames,countsColnames))

# filter low counts -- SHOULDN'T BE NECESSARY AS DESEQ2 DOES BY DEFAULT, BUT GETTING ERRORS OTHERWISE
countsTableFilt = filtered.data(
	countsTable, 
	factor = c("Plk1", "Plk2", "Plk3", "Swt1", "Swt2", "Swt3", "Vnt1", "Vnt2", "Vnt3"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)

# store deseq design as data.frame/matrix
colData <- data.frame(
	row.names = colnames(countsTableFilt), 
	condition = c("Plk", "Plk", "Plk", "Swt", "Swt", "Swt", "Vnt", "Vnt", "Vnt"),
	libType = c("single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end", "single-end"))

# deseq data from matrix
dds <- DESeqDataSetFromMatrix(
	countData = countsTableFilt,
	colData = colData,
	design = ~ condition)

# pull condtions from design
colData(dds)$condition <- factor(
	colData(dds)$condition,
	levels = c("Plk", "Swt", "Vnt"))

# differential expression analysis: equivalent to running DESeq(dds)
dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

# calculate and export normalized counts (CPM)
normalizedCounts = sweep(counts(dds), 2, colSums(counts(dds)), `/`) * 1e6
write.csv(normalizedCounts, file="CPM.all.Plk.Swt.Vnt.csv", quote=FALSE)

# NOT DOING IT SIMON ANDERS'S WAY
#normalizedCounts = t(t(counts(dds)) / sizeFactors(dds))

# TO ADD MLE (unshrunken log2foldchange) VALUES, NEED TO EDIT deseq2MatchDeg.pl

# contrast condition Plk vs Swt
res <- results(dds, contrast=c("condition","Plk","Swt"), independentFiltering=FALSE, cooksCutoff=FALSE) #, addMLE=TRUE
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.001)&(abs(res$log2FoldChange) > 3.0),]
write.csv(res[order(res$pval),], file="mydeseq2.all.Plk.Swt.csv", quote = FALSE)
write.csv(resSig[order(resSig$pval),], file="mydeseq2.sig.Plk.Swt.csv", quote = FALSE)


# contrast condition Swt vs Vnt
res <- results(dds, contrast=c("condition","Swt","Vnt"), independentFiltering=FALSE, cooksCutoff=FALSE) #, addMLE=TRUE
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.001)&(abs(res$log2FoldChange) > 3.0),]
write.csv(res[order(res$pval),], file="mydeseq2.all.Swt.Vnt.csv", quote = FALSE)
write.csv(resSig[order(resSig$pval),], file="mydeseq2.sig.Swt.Vnt.csv", quote = FALSE)


# contrast condition Plk vs Vnt
res <- results(dds, contrast=c("condition","Plk","Vnt"), independentFiltering=FALSE, cooksCutoff=FALSE) #, addMLE=TRUE
res <- res[order(res$padj),]
#resSig <- res[(res$pvalue < 0.05),]
resSig <- res[(res$pvalue < 0.001)&(abs(res$log2FoldChange) > 3.0),]
write.csv(res[order(res$pval),], file="mydeseq2.all.Plk.Vnt.csv", quote = FALSE)
write.csv(resSig[order(resSig$pval),], file="mydeseq2.sig.Plk.Vnt.csv", quote = FALSE)







# get normalized counts for lowest p-value using plotCounts -- ONLY WORKS FOR A SINGLE GENE
#d <- plotCounts(dds, gene=which.min(res$padj), intgroups="condition", returnData=TRUE)
#write.csv(d, file="counts.csv", quote=FALSE)








#matrixColl = matrix(colData(ddsColl), ncol=3) <-- DOESN'T WORK
#write.csv(ddsColl, file="mydeseq2.ddsColl.csv", quote = FALSE) <-- DOESN'T WORK

# library("RColorBrewer")
# library("gplots")
# select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:30]
# hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
# 
# heatmap.2(counts(dds,normalized=TRUE)[select,], col = hmcol,
#           Rowv = FALSE, Colv = FALSE, scale="none",
#           dendrogram="none", trace="none", margin=c(10,6))
# 
# heatmap.2(assay(rld)[select,], col = hmcol,
#           Rowv = FALSE, Colv = FALSE, scale="none",
#           dendrogram="none", trace="none", margin=c(10, 6))
# 
# heatmap.2(assay(vsd)[select,], col = hmcol,
#           Rowv = FALSE, Colv = FALSE, scale="none",
#           dendrogram="none", trace="none", margin=c(10, 6))
