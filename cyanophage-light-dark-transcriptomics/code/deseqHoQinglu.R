# call deseq library
library("DESeq")

# read in SENSE counts file
countsTableHo <- read.delim("natl2a_Prepl_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

# split counts into host and phage counts -- ALREADY HOST ONLY
# countsTableHo <- countsTable[1:2015,]
# countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts -- ALREADY DONE BY QINGLU
# countsTableHo <- countsTableHo[c(-347,-350),]

# remove lines with zero counts across all samples
countsTableHo <- countsTableHo[c(-2176),] #corresponds to PMN2A_2179

# store deseq design as data.frame/matrix
design <- data.frame(row.names = colnames(countsTableHo), condition = c("inf_prepl_0h","inf_prepl_0h","inf_prepl_1h","inf_prepl_1h","inf_prepl_2h","inf_prepl_2h","inf_prepl_4h","inf_prepl_4h","inf_prepl_8h","inf_prepl_8h","inf_prepl_12h","inf_prepl_12h"), libType = c("single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end"))

# pull conditions from design
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

# compare inf_prepl_1h with inf_prepl_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"inf_prepl_0h","inf_prepl_1h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHoQinglu.updn.inf_prepl_1h.inf_prepl_0h.csv",quote = FALSE)

# compare inf_prepl_2h with inf_prepl_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"inf_prepl_0h","inf_prepl_2h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHoQinglu.updn.inf_prepl_2h.inf_prepl_0h.csv",quote = FALSE)

# compare inf_prepl_4h with inf_prepl_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"inf_prepl_0h","inf_prepl_4h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHoQinglu.updn.inf_prepl_4h.inf_prepl_0h.csv",quote = FALSE)

# compare inf_prepl_8h with inf_prepl_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"inf_prepl_0h","inf_prepl_8h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHoQinglu.updn.inf_prepl_8h.inf_prepl_0h.csv",quote = FALSE)

# compare inf_prepl_12h with inf_prepl_0h using bionomial test, pull significant deg, and save
res <- nbinomTest(cds,"inf_prepl_0h","inf_prepl_12h")
resSig <- res[(res$padj < 0.1)&(abs(res$log2FoldChange) > 1),]
write.csv(resSig[order(resSig$pval),],file="mydeseqHoQinglu.updn.inf_prepl_12h.inf_prepl_0h.csv",quote = FALSE)


