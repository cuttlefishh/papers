# clear workspace
rm(list=ls())

# read in SENSE counts file
countsTable <- read.delim(
	"med4phm2_sense_R.tsv",
	header=TRUE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")

# split counts into host and phage counts
countsTableHo <- countsTable[1:2015,]
countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts
countsTableHo <- countsTableHo[c(-347,-350),]

# calculate mean and coefficient of variation (sd/mean) for each treatment
M = rbind(countsTableHo[,1],countsTableHo[,2])
meanHoCtrLt0h = colMeans(M)
coeffVarHoCtrLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,3],countsTableHo[,4])
meanHoCtrLt1h = colMeans(M)
coeffVarHoCtrLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,5],countsTableHo[,6])
meanHoCtrLt2h = colMeans(M)
coeffVarHoCtrLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,7],countsTableHo[,8])
meanHoCtrLt4h = colMeans(M)
coeffVarHoCtrLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,9],countsTableHo[,10])
meanHoCtrLt8h = colMeans(M)
coeffVarHoCtrLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,11],countsTableHo[,12])
meanHoCtrDk0h = colMeans(M)
coeffVarHoCtrDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,13],countsTableHo[,14])
meanHoCtrDk1h = colMeans(M)
coeffVarHoCtrDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,15],countsTableHo[,16])
meanHoCtrDk2h = colMeans(M)
coeffVarHoCtrDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,17],countsTableHo[,18])
meanHoCtrDk4h = colMeans(M)
coeffVarHoCtrDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,19],countsTableHo[,20])
meanHoCtrDk8h = colMeans(M)
coeffVarHoCtrDk8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,21],countsTableHo[,22])
meanHoInfLt0h = colMeans(M)
coeffVarHoInfLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,23],countsTableHo[,24])
meanHoInfLt1h = colMeans(M)
coeffVarHoInfLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,25],countsTableHo[,26])
meanHoInfLt2h = colMeans(M)
coeffVarHoInfLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,27],countsTableHo[,28])
meanHoInfLt4h = colMeans(M)
coeffVarHoInfLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,29],countsTableHo[,30])
meanHoInfLt8h = colMeans(M)
coeffVarHoInfLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,31],countsTableHo[,32])
meanHoInfDk0h = colMeans(M)
coeffVarHoInfDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,33],countsTableHo[,34])
meanHoInfDk1h = colMeans(M)
coeffVarHoInfDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,35],countsTableHo[,36])
meanHoInfDk2h = colMeans(M)
coeffVarHoInfDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,37],countsTableHo[,38])
meanHoInfDk4h = colMeans(M)
coeffVarHoInfDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableHo[,39],countsTableHo[,40])
meanHoInfDk8h = colMeans(M)
coeffVarHoInfDk8h = apply(M, 2, sd)/colMeans(M)

# example plot of CV vs mean
plot(meanHoInfLt0h,coeffVarHoInfLt0h)
