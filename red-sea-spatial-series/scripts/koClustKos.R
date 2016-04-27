#clear workspace
rm(list=ls())

#source required functions
source("clusFunc.R")

#read in data
data = read.delim("KOrelAbund_R_T.csv", row.names=1, col.names=as.character(0:90), header=FALSE, stringsAsFactors=FALSE, sep=",", quote="")

#store environmental data
station      = data[1,]
latitude     = data[2,]
longitude    = data[3,]
xcoord       = data[4,]
ycoord       = data[5,]
depth        = data[6,]
temperature  = data[7,]
salinity     = data[8,]
oxygen       = data[9,]
fluorescence = data[10,]
turbidity    = data[11,]
nitrate      = data[12,]
phosphate    = data[13,]
silicate     = data[14,]
read         = data[15,]

#store KO relative abundances without normalization
numRowsTotal = dim(data)[1]
numColsTotal = dim(data)[2]
KoRelAbund = data[16:numRowsTotal,]
numRows = dim(KoRelAbund)[1]
numCols = dim(KoRelAbund)[2]

#store KO relative abundances with normalization
KoRelAbundNorm = KoRelAbund
for (i in 1:numRows) {
	KoRelAbundNorm[i,] = KoRelAbund[i,]/max(KoRelAbund[i,])
	}

#run PAM with KL distances
pamKoRelAbund<-KLpam(KoRelAbundNorm,k=12)
pamKoRelAbundCluster<-cl.assign(pamKoRelAbund$cluster,rownames(KoRelAbundNorm),12)

#save PAM clusters
write.csv(pamKoRelAbundCluster[1],quote=FALSE,file="KoNormKosClust1.csv")
write.csv(pamKoRelAbundCluster[2],quote=FALSE,file="KoNormKosClust2.csv")
write.csv(pamKoRelAbundCluster[3],quote=FALSE,file="KoNormKosClust3.csv")
write.csv(pamKoRelAbundCluster[4],quote=FALSE,file="KoNormKosClust4.csv")
write.csv(pamKoRelAbundCluster[5],quote=FALSE,file="KoNormKosClust5.csv")
write.csv(pamKoRelAbundCluster[6],quote=FALSE,file="KoNormKosClust6.csv")
write.csv(pamKoRelAbundCluster[7],quote=FALSE,file="KoNormKosClust7.csv")
write.csv(pamKoRelAbundCluster[8],quote=FALSE,file="KoNormKosClust8.csv")
write.csv(pamKoRelAbundCluster[9],quote=FALSE,file="KoNormKosClust9.csv")
write.csv(pamKoRelAbundCluster[10],quote=FALSE,file="KoNormKosClust10.csv")
write.csv(pamKoRelAbundCluster[11],quote=FALSE,file="KoNormKosClust11.csv")
write.csv(pamKoRelAbundCluster[12],quote=FALSE,file="KoNormKosClust12.csv")

