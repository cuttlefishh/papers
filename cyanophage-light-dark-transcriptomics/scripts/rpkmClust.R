#source required functions
source("cluster_funct.R")

#read in data
geneInfo <- read.delim("genes_med4phm2.tsv",header=FALSE,stringsAsFactors=FALSE,sep="\t",quote="")
countsTable <- read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

#store gene size array
sizebp<-geneInfo$V2
sizekbp<-sizebp/1000

#initialize arrays
colsum<-array(0, c(40))
rpkm<-array(0, c(2257,40))

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

#run PAM with KL distances
pamKLrpkmHoCtrLt<-KLpam(rpkmHoCtrLt,k=5)
pamKLrpkmHoCtrLtCluster<-cl.assign(pamKLrpkmHoCtrLt$cluster,rownames(rpkmHoCtrLt),5)
pamKLrpkmHoCtrDk<-KLpam(rpkmHoCtrDk,k=5)
pamKLrpkmHoCtrDkCluster<-cl.assign(pamKLrpkmHoCtrDk$cluster,rownames(rpkmHoCtrDk),5)
pamKLrpkmHoInfLt<-KLpam(rpkmHoInfLt,k=5)
pamKLrpkmHoInfLtCluster<-cl.assign(pamKLrpkmHoInfLt$cluster,rownames(rpkmHoInfLt),5)
pamKLrpkmHoInfDk<-KLpam(rpkmHoInfDk,k=5)
pamKLrpkmHoInfDkCluster<-cl.assign(pamKLrpkmHoInfDk$cluster,rownames(rpkmHoInfDk),5)
pamKLrpkmPhInfLt<-KLpam(rpkmPhInfLt,k=5)
pamKLrpkmPhInfLtCluster<-cl.assign(pamKLrpkmPhInfLt$cluster,rownames(rpkmPhInfLt),5)
pamKLrpkmPhInfDk<-KLpam(rpkmPhInfDk,k=5)
pamKLrpkmPhInfDkCluster<-cl.assign(pamKLrpkmPhInfDk$cluster,rownames(rpkmPhInfDk),5)

#save PAM clusters
write.csv(pamKLrpkmHoCtrLtCluster[1],quote=FALSE,file="hoCtrLtClust1of5.csv")
write.csv(pamKLrpkmHoCtrLtCluster[2],quote=FALSE,file="hoCtrLtClust2of5.csv")
write.csv(pamKLrpkmHoCtrLtCluster[3],quote=FALSE,file="hoCtrLtClust3of5.csv")
write.csv(pamKLrpkmHoCtrLtCluster[4],quote=FALSE,file="hoCtrLtClust4of5.csv")
write.csv(pamKLrpkmHoCtrLtCluster[5],quote=FALSE,file="hoCtrLtClust5of5.csv")
write.csv(pamKLrpkmHoCtrDkCluster[1],quote=FALSE,file="hoCtrDkClust1of5.csv")
write.csv(pamKLrpkmHoCtrDkCluster[2],quote=FALSE,file="hoCtrDkClust2of5.csv")
write.csv(pamKLrpkmHoCtrDkCluster[3],quote=FALSE,file="hoCtrDkClust3of5.csv")
write.csv(pamKLrpkmHoCtrDkCluster[4],quote=FALSE,file="hoCtrDkClust4of5.csv")
write.csv(pamKLrpkmHoCtrDkCluster[5],quote=FALSE,file="hoCtrDkClust5of5.csv")
write.csv(pamKLrpkmHoInfLtCluster[1],quote=FALSE,file="hoInfLtClust1of5.csv")
write.csv(pamKLrpkmHoInfLtCluster[2],quote=FALSE,file="hoInfLtClust2of5.csv")
write.csv(pamKLrpkmHoInfLtCluster[3],quote=FALSE,file="hoInfLtClust3of5.csv")
write.csv(pamKLrpkmHoInfLtCluster[4],quote=FALSE,file="hoInfLtClust4of5.csv")
write.csv(pamKLrpkmHoInfLtCluster[5],quote=FALSE,file="hoInfLtClust5of5.csv")
write.csv(pamKLrpkmHoInfDkCluster[1],quote=FALSE,file="hoInfDkClust1of5.csv")
write.csv(pamKLrpkmHoInfDkCluster[2],quote=FALSE,file="hoInfDkClust2of5.csv")
write.csv(pamKLrpkmHoInfDkCluster[3],quote=FALSE,file="hoInfDkClust3of5.csv")
write.csv(pamKLrpkmHoInfDkCluster[4],quote=FALSE,file="hoInfDkClust4of5.csv")
write.csv(pamKLrpkmHoInfDkCluster[5],quote=FALSE,file="hoInfDkClust5of5.csv")
write.csv(pamKLrpkmPhInfLtCluster[1],quote=FALSE,file="phInfLtClust1of5.csv")
write.csv(pamKLrpkmPhInfLtCluster[2],quote=FALSE,file="phInfLtClust2of5.csv")
write.csv(pamKLrpkmPhInfLtCluster[3],quote=FALSE,file="phInfLtClust3of5.csv")
write.csv(pamKLrpkmPhInfLtCluster[4],quote=FALSE,file="phInfLtClust4of5.csv")
write.csv(pamKLrpkmPhInfLtCluster[5],quote=FALSE,file="phInfLtClust5of5.csv")
write.csv(pamKLrpkmPhInfDkCluster[1],quote=FALSE,file="phInfDkClust1of5.csv")
write.csv(pamKLrpkmPhInfDkCluster[2],quote=FALSE,file="phInfDkClust2of5.csv")
write.csv(pamKLrpkmPhInfDkCluster[3],quote=FALSE,file="phInfDkClust3of5.csv")
write.csv(pamKLrpkmPhInfDkCluster[4],quote=FALSE,file="phInfDkClust4of5.csv")
write.csv(pamKLrpkmPhInfDkCluster[5],quote=FALSE,file="phInfDkClust5of5.csv")

