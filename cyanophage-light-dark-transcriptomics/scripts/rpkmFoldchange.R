#read in data
geneInfo = read.delim("genes_med4phm2.tsv",header=FALSE,stringsAsFactors=FALSE,sep="\t",quote="")
countsTable = read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

# remove phage genes and LSU/SSU from counts
countsTableHo = countsTable[1:2015,]
countsTableHo = countsTableHo[c(-347,-350),]

#store gene size array
sizebp = geneInfo$V2
sizekbp = sizebp/1000

#initialize arrays
colsum = array(0, c(40))
rpkm = array(0, c(2013,40))

#calculate RPKM for each gene and sample
for(j in 1:40) {
	colsum[j] = sum(countsTableHo[,j])
	for(i in 1:2013) {
		rpkm[i,j] = countsTableHo[i,j]/sizekbp[i]/colsum[j]*1e6
	}
}

#add row and column labels
rpkm = matrix(rpkm,ncol=40,dimnames=list(rownames(countsTableHo),colnames(countsTableHo)))

#split RPKM data by rows (host/phage) and columns (treatment)
rpkmHo = rpkm[1:2013,]
rpkmHoCtrLt = rpkmHo[,1:10]
rpkmHoCtrDk = rpkmHo[,11:20]
rpkmHoInfLt = rpkmHo[,21:30]
rpkmHoInfDk = rpkmHo[,31:40]

#calculate averages for each treatment (host only)
rpkmHoCtrLtAvg = matrix(c(
	colMeans(rbind(rpkmHoCtrLt[,1],rpkmHoCtrLt[,2])),
	colMeans(rbind(rpkmHoCtrLt[,3],rpkmHoCtrLt[,4])),
	colMeans(rbind(rpkmHoCtrLt[,5],rpkmHoCtrLt[,6])),
	colMeans(rbind(rpkmHoCtrLt[,7],rpkmHoCtrLt[,8])),
	colMeans(rbind(rpkmHoCtrLt[,9],rpkmHoCtrLt[,10]))), 
	ncol=5)
rpkmHoCtrDkAvg = matrix(c(
	colMeans(rbind(rpkmHoCtrDk[,1],rpkmHoCtrDk[,2])),
	colMeans(rbind(rpkmHoCtrDk[,3],rpkmHoCtrDk[,4])),
	colMeans(rbind(rpkmHoCtrDk[,5],rpkmHoCtrDk[,6])),
	colMeans(rbind(rpkmHoCtrDk[,7],rpkmHoCtrDk[,8])),
	colMeans(rbind(rpkmHoCtrDk[,9],rpkmHoCtrDk[,10]))), 
	ncol=5)
rpkmHoInfLtAvg = matrix(c(
	colMeans(rbind(rpkmHoInfLt[,1],rpkmHoInfLt[,2])),
	colMeans(rbind(rpkmHoInfLt[,3],rpkmHoInfLt[,4])),
	colMeans(rbind(rpkmHoInfLt[,5],rpkmHoInfLt[,6])),
	colMeans(rbind(rpkmHoInfLt[,7],rpkmHoInfLt[,8])),
	colMeans(rbind(rpkmHoInfLt[,9],rpkmHoInfLt[,10]))), 
	ncol=5)
rpkmHoInfDkAvg = matrix(c(
	colMeans(rbind(rpkmHoInfDk[,1],rpkmHoInfDk[,2])),
	colMeans(rbind(rpkmHoInfDk[,3],rpkmHoInfDk[,4])),
	colMeans(rbind(rpkmHoInfDk[,5],rpkmHoInfDk[,6])),
	colMeans(rbind(rpkmHoInfDk[,7],rpkmHoInfDk[,8])),
	colMeans(rbind(rpkmHoInfDk[,9],rpkmHoInfDk[,10]))), 
	ncol=5)

#initialize arrays
rpkmHoLtFldch = array(0, c(2013,5))
rpkmHoDkFldch = array(0, c(2013,5))

#calculate log2(foldchange) for inf/ctr (host only)
for(j in 1:5) {
	for(i in 1:2013) {
		rpkmHoLtFldch[i,j] = log2(rpkmHoInfLtAvg[i,j]/rpkmHoCtrLtAvg[i,j])
		rpkmHoDkFldch[i,j] = log2(rpkmHoInfDkAvg[i,j]/rpkmHoCtrDkAvg[i,j])
	}
}

#add row and column labels
rpkmHoCtrLtAvg = matrix(rpkmHoCtrLtAvg,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Ctr_Lt_0h","Ctr_Lt_1h","Ctr_Lt_2h","Ctr_Lt_4h","Ctr_Lt_8h")))
rpkmHoCtrDkAvg = matrix(rpkmHoCtrDkAvg,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Ctr_Dk_0h","Ctr_Dk_1h","Ctr_Dk_2h","Ctr_Dk_4h","Ctr_Dk_8h")))
rpkmHoInfLtAvg = matrix(rpkmHoInfLtAvg,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Inf_Lt_0h","Inf_Lt_1h","Inf_Lt_2h","Inf_Lt_4h","Inf_Lt_8h")))
rpkmHoInfDkAvg = matrix(rpkmHoInfDkAvg,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Inf_Dk_0h","Inf_Dk_1h","Inf_Dk_2h","Inf_Dk_4h","Inf_Dk_8h")))
rpkmHoLtFldch = matrix(rpkmHoLtFldch,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Lt_0h","Lt_1h","Lt_2h","Lt_4h","Lt_8h")))
rpkmHoDkFldch = matrix(rpkmHoDkFldch,ncol=5,dimnames=list(rownames(countsTableHo[1:2013,]),c("Dk_0h","Dk_1h","Dk_2h","Dk_4h","Dk_8h")))

#save RPKM counts and fold change
write.table(rpkmHoCtrLtAvg,quote=FALSE,col.names=FALSE,file="rpkmHoCtrLtAvg.tsv",sep="\t")
write.table(rpkmHoInfLtAvg,quote=FALSE,col.names=FALSE,file="rpkmHoInfLtAvg.tsv",sep="\t")
write.table(rpkmHoCtrDkAvg,quote=FALSE,col.names=FALSE,file="rpkmHoCtrDkAvg.tsv",sep="\t")
write.table(rpkmHoInfDkAvg,quote=FALSE,col.names=FALSE,file="rpkmHoInfDkAvg.tsv",sep="\t")
write.table(rpkmHoLtFldch,quote=FALSE,col.names=FALSE,file="rpkmHoLtFldch.tsv",sep="\t")
write.table(rpkmHoDkFldch,quote=FALSE,col.names=FALSE,file="rpkmHoDkFldch.tsv",sep="\t")

