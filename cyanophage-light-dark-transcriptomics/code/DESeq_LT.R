library("DESeq")

countsTable <- read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

design <- data.frame(row.names = colnames(countsTable), condition = c("ctr_lt_0h","ctr_lt_0h","ctr_lt_1h","ctr_lt_1h","ctr_lt_2h","ctr_lt_2h","ctr_lt_4h","ctr_lt_4h","ctr_lt_8h","ctr_lt_8h","ctr_dk_0h","ctr_dk_0h","ctr_dk_1h","ctr_dk_1h","ctr_dk_2h","ctr_dk_2h","ctr_dk_4h","ctr_dk_4h","ctr_dk_8h","ctr_dk_8h","inf_lt_0h","inf_lt_0h","inf_lt_1h","inf_lt_1h","inf_lt_2h","inf_lt_2h","inf_lt_4h","inf_lt_4h","inf_lt_8h","inf_lt_8h","inf_dk_0h","inf_dk_0h","inf_dk_1h","inf_dk_1h","inf_dk_2h","inf_dk_2h","inf_dk_4h","inf_dk_4h","inf_dk_8h","inf_dk_8h"), libType = c("single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end","single-end"))

conds <- design$condition

plotDE <- function(res){
  plot(res$baseMean, res$log2FoldChange,log="x",pch=20,cex=1,col=ifelse(res$padj<0.1,"red","grey"))
}

runDESeq <- function(countsTable){
  cds <- newCountDataSet(countsTable,conds)
  cds <- estimateSizeFactors(cds)
  cds <- estimateDispersions(cds)
  return(cds)
}

cds <- runDESeq(countsTable)

res <- nbinomTest(cds,"inf_dk_8h","inf_lt_8h")

resSig <- res[ res$padj < 0.1, ]

plotDE(res)

vsd<-getVarianceStabilizedData(cds)

