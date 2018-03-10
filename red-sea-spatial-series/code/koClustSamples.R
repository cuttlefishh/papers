#clear workspace
rm(list=ls())

#source required functions
source("clusFunc.R")

#read in data
data = read.delim("KOrelAbund_R.csv",header=TRUE,stringsAsFactors=FALSE,sep=",",quote="")

station      = data[,1]
latitude     = data[,2]
longitude    = data[,3]
xcoord       = data[,4]
ycoord       = data[,5]
depth        = data[,6]
temperature  = data[,7]
salinity     = data[,8]
oxygen       = data[,9]
fluorescence = data[,10]
turbidity    = data[,11]
nitrate      = data[,12]
phosphate    = data[,13]
silicate     = data[,14]
read         = data[,15]

#store KO relative abundances without normalization
numRowsTotal = dim(data)[1]
numColsTotal = dim(data)[2]
KoRelAbund = data[,16:numColsTotal]
numRows = dim(KoRelAbund)[1]
numCols = dim(KoRelAbund)[2]

#store KO relative abundances with normalization
KoRelAbundNorm = KoRelAbund
for (i in 1:numCols) {
	KoRelAbundNorm[,i] = KoRelAbund[,i]/max(KoRelAbund[,i])
	}

#run PAM with KL distances
pamKoRelAbund<-KLpam(KoRelAbundNorm,k=12)
pamKoRelAbundCluster<-cl.assign(pamKoRelAbund$cluster,rownames(KoRelAbundNorm),12)

#save PAM clusters
write.csv(pamKoRelAbundCluster[1],quote=FALSE,file="KoNormSampClust1.csv")
write.csv(pamKoRelAbundCluster[2],quote=FALSE,file="KoNormSampClust2.csv")
write.csv(pamKoRelAbundCluster[3],quote=FALSE,file="KoNormSampClust3.csv")
write.csv(pamKoRelAbundCluster[4],quote=FALSE,file="KoNormSampClust4.csv")
write.csv(pamKoRelAbundCluster[5],quote=FALSE,file="KoNormSampClust5.csv")
write.csv(pamKoRelAbundCluster[6],quote=FALSE,file="KoNormSampClust6.csv")
write.csv(pamKoRelAbundCluster[7],quote=FALSE,file="KoNormSampClust7.csv")
write.csv(pamKoRelAbundCluster[8],quote=FALSE,file="KoNormSampClust8.csv")
write.csv(pamKoRelAbundCluster[9],quote=FALSE,file="KoNormSampClust9.csv")
write.csv(pamKoRelAbundCluster[10],quote=FALSE,file="KoNormSampClust10.csv")
write.csv(pamKoRelAbundCluster[11],quote=FALSE,file="KoNormSampClust11.csv")
write.csv(pamKoRelAbundCluster[12],quote=FALSE,file="KoNormSampClust12.csv")
