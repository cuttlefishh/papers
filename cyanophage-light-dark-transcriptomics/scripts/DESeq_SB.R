library(DESeq)

countsTable <- read.delim("Total.csv",header=TRUE,stringsAsFactors=FALSE,sep=",",quote="")
  
## 	rownames(countsTable) <- countsTable$Region
countsTable <- countsTable[,7:ncol(countsTable)]

conds <- factor(c("IC0","IC0","IC1","IC1","IC2","IC2","IC4","IC4","IC8","IC8","IC12","IC12"))

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

res <- nbinomTest(cds,"IC0","IC1")


plotDE(res)


vsd<-getVarianceStabilizedData(cds)

