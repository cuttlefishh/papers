#source required functions
source("cluster_funct.R")
source("clusGap.R")

#read in data
geneInfo<-read.delim("genes_med4phm2.tsv",header=FALSE,stringsAsFactors=FALSE,sep="\t",quote="")
countsTable<-read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

#store gene size array
sizebp<-geneInfo$V2
sizekbp<-sizebp/1000

#initialize arrays
colsum<-array(0,c(40))
rpkm<-array(0,c(2257,40))

#calculate RPKM for each gene and sample
for(j in 1:40) {
	colsum[j]<-sum(countsTable[,j])
	for(i in 1:2257) {
		rpkm[i,j]<-countsTable[i,j]/sizekbp[i]/colsum[j]*1e6
	}
}

#add row and column labels
rpkm<-matrix(rpkm,ncol=40,dimnames=list(rownames(countsTable),colnames(countsTable)))

#split rpkm data by rows (host/phage) and columns (treatment)
rpkmHo<-rpkm[1:2015,]
rpkmPh<-rpkm[2016:2257,]
rpkmHoCtrLt<-rpkmHo[,1:10]
rpkmHoCtrDk<-rpkmHo[,11:20]
rpkmHoInfLt<-rpkmHo[,21:30]
rpkmHoInfDk<-rpkmHo[,31:40]
rpkmPhInfLt<-rpkmPh[,21:30]
rpkmPhInfDk<-rpkmPh[,31:40]

#calculate gap statistic for each
distKLrpkmHoCtrLt<-distKL(rpkmHoCtrLt)
gapKLrpkmHoCtrLtCluster<-clusGap(distKLrpkmHoCtrLt,pam,K.max=8,diss=TRUE)
distKLrpkmHoCtrDk<-distKL(rpkmHoCtrDk)
gapKLrpkmHoCtrDkCluster<-clusGap(distKLrpkmHoCtrDk,pam,K.max=8,diss=TRUE)
distKLrpkmHoInfLt<-distKL(rpkmHoInfLt)
gapKLrpkmHoInfLtCluster<-clusGap(distKLrpkmHoInfLt,pam,K.max=8,diss=TRUE)
distKLrpkmHoInfDk<-distKL(rpkmHoInfDk)
gapKLrpkmHoInfDkCluster<-clusGap(distKLrpkmHoInfDk,pam,K.max=8,diss=TRUE)
distKLrpkmPhInfLt<-distKL(rpkmPhInfLt)
gapKLrpkmPhInfLtCluster<-clusGap(distKLrpkmPhInfLt,pam,K.max=8,diss=TRUE)
distKLrpkmPhInfDk<-distKL(rpkmPhInfDk)
gapKLrpkmPhInfDkCluster<-clusGap(distKLrpkmPhInfDk,pam,K.max=8,diss=TRUE)

