# read in data
geneInfo = read.delim("genes_med4phm2.tsv",header=FALSE,stringsAsFactors=FALSE,sep="\t",quote="")
countsTable = read.delim("med4phm2_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")
countsTableAs = read.delim("med4phm2_anti_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

# remove phage genes and LSU/SSU from counts
countsTableHo = countsTable[1:2015,]
countsTableHo = countsTableHo[c(-347,-350),]
countsTableHoAs = countsTableAs[1:2015,]
countsTableHoAs = countsTableHoAs[c(-347,-350),]

# store gene size array
sizebp = geneInfo$V2
sizekbp = sizebp/1000

# initialize arrays
colsum = array(0, c(40))
rpkm = array(0, c(4026,40))  # 4026 = 2013 * 2

# calculate RPKM for each gene and sample
for(j in 1:40) {
	colsum[j] = sum(countsTableHo[,j],countsTableHoAs[,j])
	for(i in 1:2013) {
		rpkm[i,j] = countsTableHo[i,j]/sizekbp[i]/colsum[j]*1e6
		rpkm[i+2013,j] = countsTableHoAs[i,j]/sizekbp[i]/colsum[j]*1e6
	}
}

# split rpkm results into sense and antisense
rpkmSense = rpkm[1:2013,]
rpkmAnti  = rpkm[2014:4026,]

# split RPKM data by columns (treatment)
rpkmHoCtrLtSense = rpkmSense[,1:10]
rpkmHoCtrDkSense = rpkmSense[,11:20]
rpkmHoInfLtSense = rpkmSense[,21:30]
rpkmHoInfDkSense = rpkmSense[,31:40]
rpkmHoCtrLtAnti = rpkmAnti[,1:10]
rpkmHoCtrDkAnti = rpkmAnti[,11:20]
rpkmHoInfLtAnti = rpkmAnti[,21:30]
rpkmHoInfDkAnti = rpkmAnti[,31:40]

# add row and column labels
rpkmSense = matrix(rpkmSense,ncol=40,dimnames=list(rownames(countsTableHo),colnames(countsTableHo)))
rpkmAnti  = matrix(rpkmAnti,ncol=40,dimnames=list(rownames(countsTableHoAs),colnames(countsTableHoAs)))

# calculate total average
rpkmAllAvgSense = matrix(c(colMeans(rbind(
	rpkmSense[,1], rpkmSense[,2], rpkmSense[,3], rpkmSense[,4], rpkmSense[,5], rpkmSense[,6], rpkmSense[,7], rpkmSense[,8], rpkmSense[,9], rpkmSense[,10],
	rpkmSense[,11], rpkmSense[,12], rpkmSense[,13], rpkmSense[,14], rpkmSense[,15], rpkmSense[,16], rpkmSense[,17], rpkmSense[,18], rpkmSense[,19], rpkmSense[,20],
	rpkmSense[,21], rpkmSense[,22], rpkmSense[,23], rpkmSense[,24], rpkmSense[,25], rpkmSense[,26], rpkmSense[,27], rpkmSense[,28], rpkmSense[,29], rpkmSense[,30],
	rpkmSense[,31], rpkmSense[,32], rpkmSense[,33], rpkmSense[,34], rpkmSense[,35], rpkmSense[,36], rpkmSense[,37], rpkmSense[,38], rpkmSense[,39], rpkmSense[,40]
))), ncol=1)
rpkmAllAvgAnti = matrix(c(colMeans(rbind(
	rpkmAnti[,1], rpkmAnti[,2], rpkmAnti[,3], rpkmAnti[,4], rpkmAnti[,5], rpkmAnti[,6], rpkmAnti[,7], rpkmAnti[,8], rpkmAnti[,9], rpkmAnti[,10],
	rpkmAnti[,11], rpkmAnti[,12], rpkmAnti[,13], rpkmAnti[,14], rpkmAnti[,15], rpkmAnti[,16], rpkmAnti[,17], rpkmAnti[,18], rpkmAnti[,19], rpkmAnti[,20],
	rpkmAnti[,21], rpkmAnti[,22], rpkmAnti[,23], rpkmAnti[,24], rpkmAnti[,25], rpkmAnti[,26], rpkmAnti[,27], rpkmAnti[,28], rpkmAnti[,29], rpkmAnti[,30],
	rpkmAnti[,31], rpkmAnti[,32], rpkmAnti[,33], rpkmAnti[,34], rpkmAnti[,35], rpkmAnti[,36], rpkmAnti[,37], rpkmAnti[,38], rpkmAnti[,39], rpkmAnti[,40]
))), ncol=1)

# calculate light t0 average
rpkmT0InfLtSense = matrix(c(colMeans(rbind(
	rpkmHoInfLtSense[,1], rpkmHoInfLtSense[,2]
))), ncol=1)
rpkmT0InfLtAnti = matrix(c(colMeans(rbind(
	rpkmHoInfLtAnti[,1], rpkmHoInfLtAnti[,2]
))), ncol=1)

# calculate light t1 average
rpkmT1InfLtSense = matrix(c(colMeans(rbind(
	rpkmHoInfLtSense[,3], rpkmHoInfLtSense[,4]
))), ncol=1)
rpkmT1InfLtAnti = matrix(c(colMeans(rbind(
	rpkmHoInfLtAnti[,3], rpkmHoInfLtAnti[,4]
))), ncol=1)

# calculate light t2 average
rpkmT2InfLtSense = matrix(c(colMeans(rbind(
	rpkmHoInfLtSense[,5], rpkmHoInfLtSense[,6]
))), ncol=1)
rpkmT2InfLtAnti = matrix(c(colMeans(rbind(
	rpkmHoInfLtAnti[,5], rpkmHoInfLtAnti[,6]
))), ncol=1)

# calculate light t4 average
rpkmT4InfLtSense = matrix(c(colMeans(rbind(
	rpkmHoInfLtSense[,7], rpkmHoInfLtSense[,8]
))), ncol=1)
rpkmT4InfLtAnti = matrix(c(colMeans(rbind(
	rpkmHoInfLtAnti[,7], rpkmHoInfLtAnti[,8]
))), ncol=1)

# calculate light t8 average
rpkmT8InfLtSense = matrix(c(colMeans(rbind(
	rpkmHoInfLtSense[,9], rpkmHoInfLtSense[,10]
))), ncol=1)
rpkmT8InfLtAnti = matrix(c(colMeans(rbind(
	rpkmHoInfLtAnti[,9], rpkmHoInfLtAnti[,10]
))), ncol=1)

# calculate dark t0 average
rpkmT0InfDkSense = matrix(c(colMeans(rbind(
	rpkmHoInfDkSense[,1], rpkmHoInfDkSense[,2]
))), ncol=1)
rpkmT0InfDkAnti = matrix(c(colMeans(rbind(
	rpkmHoInfDkAnti[,1], rpkmHoInfDkAnti[,2]
))), ncol=1)

# calculate dark t1 average
rpkmT1InfDkSense = matrix(c(colMeans(rbind(
	rpkmHoInfDkSense[,3], rpkmHoInfDkSense[,4]
))), ncol=1)
rpkmT1InfDkAnti = matrix(c(colMeans(rbind(
	rpkmHoInfDkAnti[,3], rpkmHoInfDkAnti[,4]
))), ncol=1)

# calculate dark t2 average
rpkmT2InfDkSense = matrix(c(colMeans(rbind(
	rpkmHoInfDkSense[,5], rpkmHoInfDkSense[,6]
))), ncol=1)
rpkmT2InfDkAnti = matrix(c(colMeans(rbind(
	rpkmHoInfDkAnti[,5], rpkmHoInfDkAnti[,6]
))), ncol=1)
	
# calculate dark t4 average
rpkmT4InfDkSense = matrix(c(colMeans(rbind(
	rpkmHoInfDkSense[,7], rpkmHoInfDkSense[,8]
))), ncol=1)
rpkmT4InfDkAnti = matrix(c(colMeans(rbind(
	rpkmHoInfDkAnti[,7], rpkmHoInfDkAnti[,8]
))), ncol=1)

# calculate dark t8 average
rpkmT8InfDkSense = matrix(c(colMeans(rbind(
	rpkmHoInfDkSense[,9], rpkmHoInfDkSense[,10]
))), ncol=1)
rpkmT8InfDkAnti = matrix(c(colMeans(rbind(
	rpkmHoInfDkAnti[,9], rpkmHoInfDkAnti[,10]
))), ncol=1)


# add row and column labels
rpkmAllAvgSense = matrix(rpkmAllAvgSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT0InfLtSense = matrix(rpkmT0InfLtSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT1InfLtSense = matrix(rpkmT1InfLtSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT2InfLtSense = matrix(rpkmT2InfLtSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT4InfLtSense = matrix(rpkmT4InfLtSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT8InfLtSense = matrix(rpkmT8InfLtSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT0InfDkSense = matrix(rpkmT0InfDkSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT1InfDkSense = matrix(rpkmT1InfDkSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT2InfDkSense = matrix(rpkmT2InfDkSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT4InfDkSense = matrix(rpkmT4InfDkSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmT8InfDkSense = matrix(rpkmT8InfDkSense,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgSense")))
rpkmAllAvgAnti = matrix(rpkmAllAvgAnti,ncol=1,dimnames=list(rownames(countsTableHoAs[1:2013,]),c("AllAvgAnti")))
rpkmT0InfLtAnti = matrix(rpkmT0InfLtAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT1InfLtAnti = matrix(rpkmT1InfLtAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT2InfLtAnti = matrix(rpkmT2InfLtAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT4InfLtAnti = matrix(rpkmT4InfLtAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT8InfLtAnti = matrix(rpkmT8InfLtAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT0InfDkAnti = matrix(rpkmT0InfDkAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT1InfDkAnti = matrix(rpkmT1InfDkAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT2InfDkAnti = matrix(rpkmT2InfDkAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT4InfDkAnti = matrix(rpkmT4InfDkAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))
rpkmT8InfDkAnti = matrix(rpkmT8InfDkAnti,ncol=1,dimnames=list(rownames(countsTableHo[1:2013,]),c("AllAvgAnti")))

# save RPKM counts and fold change
write.table(rpkmAllAvgSense,quote=FALSE,col.names=FALSE,file="rpkmAllAvgSense.tsv",sep="\t")
write.table(rpkmT0InfLtSense,quote=FALSE,col.names=FALSE,file="rpkmT0InfLtSense.tsv",sep="\t")
write.table(rpkmT1InfLtSense,quote=FALSE,col.names=FALSE,file="rpkmT1InfLtSense.tsv",sep="\t")
write.table(rpkmT2InfLtSense,quote=FALSE,col.names=FALSE,file="rpkmT2InfLtSense.tsv",sep="\t")
write.table(rpkmT4InfLtSense,quote=FALSE,col.names=FALSE,file="rpkmT4InfLtSense.tsv",sep="\t")
write.table(rpkmT8InfLtSense,quote=FALSE,col.names=FALSE,file="rpkmT8InfLtSense.tsv",sep="\t")
write.table(rpkmT0InfDkSense,quote=FALSE,col.names=FALSE,file="rpkmT0InfDkSense.tsv",sep="\t")
write.table(rpkmT1InfDkSense,quote=FALSE,col.names=FALSE,file="rpkmT1InfDkSense.tsv",sep="\t")
write.table(rpkmT2InfDkSense,quote=FALSE,col.names=FALSE,file="rpkmT2InfDkSense.tsv",sep="\t")
write.table(rpkmT4InfDkSense,quote=FALSE,col.names=FALSE,file="rpkmT4InfDkSense.tsv",sep="\t")
write.table(rpkmT8InfDkSense,quote=FALSE,col.names=FALSE,file="rpkmT8InfDkSense.tsv",sep="\t")
write.table(rpkmAllAvgAnti,quote=FALSE,col.names=FALSE,file="rpkmAllAvgAnti.tsv",sep="\t")
write.table(rpkmT0InfLtAnti,quote=FALSE,col.names=FALSE,file="rpkmT0InfLtAnti.tsv",sep="\t")
write.table(rpkmT1InfLtAnti,quote=FALSE,col.names=FALSE,file="rpkmT1InfLtAnti.tsv",sep="\t")
write.table(rpkmT2InfLtAnti,quote=FALSE,col.names=FALSE,file="rpkmT2InfLtAnti.tsv",sep="\t")
write.table(rpkmT4InfLtAnti,quote=FALSE,col.names=FALSE,file="rpkmT4InfLtAnti.tsv",sep="\t")
write.table(rpkmT8InfLtAnti,quote=FALSE,col.names=FALSE,file="rpkmT8InfLtAnti.tsv",sep="\t")
write.table(rpkmT0InfDkAnti,quote=FALSE,col.names=FALSE,file="rpkmT0InfDkAnti.tsv",sep="\t")
write.table(rpkmT1InfDkAnti,quote=FALSE,col.names=FALSE,file="rpkmT1InfDkAnti.tsv",sep="\t")
write.table(rpkmT2InfDkAnti,quote=FALSE,col.names=FALSE,file="rpkmT2InfDkAnti.tsv",sep="\t")
write.table(rpkmT4InfDkAnti,quote=FALSE,col.names=FALSE,file="rpkmT4InfDkAnti.tsv",sep="\t")
write.table(rpkmT8InfDkAnti,quote=FALSE,col.names=FALSE,file="rpkmT8InfDkAnti.tsv",sep="\t")

# print averages
print(mean(rpkmAllAvgSense))
print(mean(rpkmAllAvgAnti))
print(mean(rpkmT0InfLtSense))
print(mean(rpkmT0InfLtAnti))
print(mean(rpkmT1InfLtSense))
print(mean(rpkmT1InfLtAnti))
print(mean(rpkmT2InfLtSense))
print(mean(rpkmT2InfLtAnti))
print(mean(rpkmT4InfLtSense))
print(mean(rpkmT4InfLtAnti))
print(mean(rpkmT8InfLtSense))
print(mean(rpkmT8InfLtAnti))
print(mean(rpkmT0InfDkSense))
print(mean(rpkmT0InfDkAnti))
print(mean(rpkmT1InfDkSense))
print(mean(rpkmT1InfDkAnti))
print(mean(rpkmT2InfDkSense))
print(mean(rpkmT2InfDkAnti))
print(mean(rpkmT4InfDkSense))
print(mean(rpkmT4InfDkAnti))
print(mean(rpkmT8InfDkSense))
print(mean(rpkmT8InfDkAnti))




