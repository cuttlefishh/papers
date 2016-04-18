#source required functions
source("clusFunc.R")
source("clusGap.R")

#read in data
geneInfo <- read.delim("KOrelAbund_ECO_R.csv",header=TRUE,stringsAsFactors=FALSE,sep="c",quote="")

# #add row and column labels
# rpkm<-matrix(rpkm,ncol=40,dimnames=list(rownames(countsTable),colnames(countsTable)))

# #calculate gap statistic for each
# distKLrpkmHoCtrLt<-distKL(rpkmHoCtrLt)
# gapKLrpkmHoCtrLtCluster<-clusGap(distKLrpkmHoCtrLt,pam,K.max=8,diss=TRUE)
# distKLrpkmHoCtrDk<-distKL(rpkmHoCtrDk)
# gapKLrpkmHoCtrDkCluster<-clusGap(distKLrpkmHoCtrDk,pam,K.max=8,diss=TRUE)
# distKLrpkmHoInfLt<-distKL(rpkmHoInfLt)
# gapKLrpkmHoInfLtCluster<-clusGap(distKLrpkmHoInfLt,pam,K.max=8,diss=TRUE)
# distKLrpkmHoInfDk<-distKL(rpkmHoInfDk)
# gapKLrpkmHoInfDkCluster<-clusGap(distKLrpkmHoInfDk,pam,K.max=8,diss=TRUE)
# distKLrpkmPhInfLt<-distKL(rpkmPhInfLt)
# gapKLrpkmPhInfLtCluster<-clusGap(distKLrpkmPhInfLt,pam,K.max=8,diss=TRUE)
# distKLrpkmPhInfDk<-distKL(rpkmPhInfDk)
# gapKLrpkmPhInfDkCluster<-clusGap(distKLrpkmPhInfDk,pam,K.max=8,diss=TRUE)

