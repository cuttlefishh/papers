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
rpkmAllAvg = matrix(c(colMeans(rbind(
	rpkmHoCtrLt[,1],rpkmHoCtrLt[,2],rpkmHoCtrLt[,3],rpkmHoCtrLt[,4],rpkmHoCtrLt[,5],rpkmHoCtrLt[,6],rpkmHoCtrLt[,7],rpkmHoCtrLt[,8],rpkmHoCtrLt[,9],rpkmHoCtrLt[,10],
	rpkmHoCtrDk[,1],rpkmHoCtrDk[,2],rpkmHoCtrDk[,3],rpkmHoCtrDk[,4],rpkmHoCtrDk[,5],rpkmHoCtrDk[,6],rpkmHoCtrDk[,7],rpkmHoCtrDk[,8],rpkmHoCtrDk[,9],rpkmHoCtrDk[,10],
	rpkmHoInfLt[,1],rpkmHoInfLt[,2],rpkmHoInfLt[,3],rpkmHoInfLt[,4],rpkmHoInfLt[,5],rpkmHoInfLt[,6],rpkmHoInfLt[,7],rpkmHoInfLt[,8],rpkmHoInfLt[,9],rpkmHoInfLt[,10],
	rpkmHoInfDk[,1],rpkmHoInfDk[,2],rpkmHoInfDk[,3],rpkmHoInfDk[,4],rpkmHoInfDk[,5],rpkmHoInfDk[,6],rpkmHoInfDk[,7],rpkmHoInfDk[,8],rpkmHoInfDk[,9],rpkmHoInfDk[,10]
))), ncol=1)

#add row and column labels
rpkmAllAvg = matrix(rpkmAllAvg,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))

#save RPKM counts and fold change
write.table(rpkmAllAvg,quote=FALSE,col.names=FALSE,file="rpkmAllAvgSense.tsv",sep="\t")

