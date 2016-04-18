# call deseq library
library("DESeq")

# read in SENSE counts file
countsTable <- read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")
#countsTable <- read.delim("med4phm2_all_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

# split counts into host and phage counts
countsTableHo <- countsTable[1:2015,]
countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts
countsTableHo <- countsTableHo[c(-347,-350),]

# store deseq design as data.frame/matrix
design <- data.frame(row.names = colnames(countsTableHo), condition = c("ctr_lt_0h","ctr_lt_0h","ctr_lt_1h","ctr_lt_1h","ctr_lt_2h","ctr_lt_2h","ctr_lt_4h","ctr_lt_4h","ctr_lt_8h","ctr_lt_8h","ctr_dk_0h","ctr_dk_0h","ctr_dk_1h","ctr_dk_1h","ctr_dk_2h","ctr_dk_2h","ctr_dk_4h","ctr_dk_4h","ctr_dk_8h","ctr_dk_8h","inf_lt_0h","inf_lt_0h","inf_lt_1h","inf_lt_1h","inf_lt_2h","inf_lt_2h","inf_lt_4h","inf_lt_4h","inf_lt_8h","inf_lt_8h","inf_dk_0h","inf_dk_0h","inf_dk_1h","inf_dk_1h","inf_dk_2h","inf_dk_2h","inf_dk_4h","inf_dk_4h","inf_dk_8h","inf_dk_8h"), libType = c("single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end"))

# pull condtions from design
conds <- design$condition

# define deseq function
runDESeq <- function(countsTableHo){
  cds <- newCountDataSet(countsTableHo,conds)
  cds <- estimateSizeFactors(cds)
  cds <- estimateDispersions(cds)
  # cds <- estimateDispersions(cds,fitType="local") #default is parametric
  return(cds)
}

# run deseq
cds <- runDESeq(countsTableHo)

# get variance stabilized data
vsd <- getVarianceStabilizedData(cds)

# define plot function
plotDE <- function(res){
  plot(res$baseMean, res$log2FoldChange,log="x",pch=20,cex=1,col=ifelse(res$padj<0.2,"red","grey"))
}

# for a given comparison (below), plot deg as log2FoldChange vs. baseMean (after defining res)
# plotDE(res)

# IT'S REALLY IMPORTANT TO WRITE res$log2FoldChange < -1 NOT res$log2FoldChange<-1

# compare inf_lt_0h with ctr_lt_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"ctr_lt_0h","inf_lt_0h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)

# # compare inf_lt_1h with ctr_lt_1h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_lt_1h","inf_lt_1h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)

# # compare inf_lt_2h with ctr_lt_2h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_lt_2h","inf_lt_2h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)

# # compare inf_lt_4h with ctr_lt_4h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_lt_4h","inf_lt_4h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)

# # compare inf_lt_8h with ctr_lt_8h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_lt_8h","inf_lt_8h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)

# # compare inf_dk_0h with ctr_dk_0h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_dk_0h","inf_dk_0h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)

# # compare inf_dk_1h with ctr_dk_1h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_dk_1h","inf_dk_1h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)

# # compare inf_dk_2h with ctr_dk_2h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_dk_2h","inf_dk_2h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)

# # compare inf_dk_4h with ctr_dk_4h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_dk_4h","inf_dk_4h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)

# # compare inf_dk_8h with ctr_dk_8h using bionomial test, pull significant deg, and save
# res <- nbinomTest(cds,"ctr_dk_8h","inf_dk_8h")
# resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
# write.csv(resSig[order(resSig$pval),],file="mydeseqHo.updn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)

