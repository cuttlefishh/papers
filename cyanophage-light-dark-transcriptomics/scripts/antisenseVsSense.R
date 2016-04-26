# clear workspace
rm(list=ls())

# read in SENSE counts file
countsTableSense <- read.delim(
	"med4phm2_sense_R.tsv",
	header=TRUE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")

# read in ANTISENSE counts file
countsTableAntisense <- read.delim(
	"med4phm2_anti_R.tsv",
	header=TRUE,
	stringsAsFactors=FALSE,
	sep="\t",
	quote="")

# calculate mean and coefficient of variation (sd/mean) for each treatment
M = rbind(countsTableSense[,1],countsTableSense[,2])
meanSenseCtrLt0h = colMeans(M)
coeffVarSenseCtrLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,3],countsTableSense[,4])
meanSenseCtrLt1h = colMeans(M)
coeffVarSenseCtrLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,5],countsTableSense[,6])
meanSenseCtrLt2h = colMeans(M)
coeffVarSenseCtrLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,7],countsTableSense[,8])
meanSenseCtrLt4h = colMeans(M)
coeffVarSenseCtrLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,9],countsTableSense[,10])
meanSenseCtrLt8h = colMeans(M)
coeffVarSenseCtrLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,11],countsTableSense[,12])
meanSenseCtrDk0h = colMeans(M)
coeffVarSenseCtrDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,13],countsTableSense[,14])
meanSenseCtrDk1h = colMeans(M)
coeffVarSenseCtrDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,15],countsTableSense[,16])
meanSenseCtrDk2h = colMeans(M)
coeffVarSenseCtrDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,17],countsTableSense[,18])
meanSenseCtrDk4h = colMeans(M)
coeffVarSenseCtrDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,19],countsTableSense[,20])
meanSenseCtrDk8h = colMeans(M)
coeffVarSenseCtrDk8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,21],countsTableSense[,22])
meanSenseInfLt0h = colMeans(M)
coeffVarSenseInfLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,23],countsTableSense[,24])
meanSenseInfLt1h = colMeans(M)
coeffVarSenseInfLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,25],countsTableSense[,26])
meanSenseInfLt2h = colMeans(M)
coeffVarSenseInfLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,27],countsTableSense[,28])
meanSenseInfLt4h = colMeans(M)
coeffVarSenseInfLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,29],countsTableSense[,30])
meanSenseInfLt8h = colMeans(M)
coeffVarSenseInfLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,31],countsTableSense[,32])
meanSenseInfDk0h = colMeans(M)
coeffVarSenseInfDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,33],countsTableSense[,34])
meanSenseInfDk1h = colMeans(M)
coeffVarSenseInfDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,35],countsTableSense[,36])
meanSenseInfDk2h = colMeans(M)
coeffVarSenseInfDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,37],countsTableSense[,38])
meanSenseInfDk4h = colMeans(M)
coeffVarSenseInfDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableSense[,39],countsTableSense[,40])
meanSenseInfDk8h = colMeans(M)
coeffVarSenseInfDk8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,1],countsTableAntisense[,2])
meanAntisenseCtrLt0h = colMeans(M)
coeffVarAntisenseCtrLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,3],countsTableAntisense[,4])
meanAntisenseCtrLt1h = colMeans(M)
coeffVarAntisenseCtrLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,5],countsTableAntisense[,6])
meanAntisenseCtrLt2h = colMeans(M)
coeffVarAntisenseCtrLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,7],countsTableAntisense[,8])
meanAntisenseCtrLt4h = colMeans(M)
coeffVarAntisenseCtrLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,9],countsTableAntisense[,10])
meanAntisenseCtrLt8h = colMeans(M)
coeffVarAntisenseCtrLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,11],countsTableAntisense[,12])
meanAntisenseCtrDk0h = colMeans(M)
coeffVarAntisenseCtrDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,13],countsTableAntisense[,14])
meanAntisenseCtrDk1h = colMeans(M)
coeffVarAntisenseCtrDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,15],countsTableAntisense[,16])
meanAntisenseCtrDk2h = colMeans(M)
coeffVarAntisenseCtrDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,17],countsTableAntisense[,18])
meanAntisenseCtrDk4h = colMeans(M)
coeffVarAntisenseCtrDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,19],countsTableAntisense[,20])
meanAntisenseCtrDk8h = colMeans(M)
coeffVarAntisenseCtrDk8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,21],countsTableAntisense[,22])
meanAntisenseInfLt0h = colMeans(M)
coeffVarAntisenseInfLt0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,23],countsTableAntisense[,24])
meanAntisenseInfLt1h = colMeans(M)
coeffVarAntisenseInfLt1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,25],countsTableAntisense[,26])
meanAntisenseInfLt2h = colMeans(M)
coeffVarAntisenseInfLt2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,27],countsTableAntisense[,28])
meanAntisenseInfLt4h = colMeans(M)
coeffVarAntisenseInfLt4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,29],countsTableAntisense[,30])
meanAntisenseInfLt8h = colMeans(M)
coeffVarAntisenseInfLt8h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,31],countsTableAntisense[,32])
meanAntisenseInfDk0h = colMeans(M)
coeffVarAntisenseInfDk0h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,33],countsTableAntisense[,34])
meanAntisenseInfDk1h = colMeans(M)
coeffVarAntisenseInfDk1h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,35],countsTableAntisense[,36])
meanAntisenseInfDk2h = colMeans(M)
coeffVarAntisenseInfDk2h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,37],countsTableAntisense[,38])
meanAntisenseInfDk4h = colMeans(M)
coeffVarAntisenseInfDk4h = apply(M, 2, sd)/colMeans(M)

M = rbind(countsTableAntisense[,39],countsTableAntisense[,40])
meanAntisenseInfDk8h = colMeans(M)
coeffVarAntisenseInfDk8h = apply(M, 2, sd)/colMeans(M)

# calculate antisense/sense ratio
ratioCtrLt0h = meanAntisenseCtrLt0h/meanSenseCtrLt0h
ratioCtrLt1h = meanAntisenseCtrLt1h/meanSenseCtrLt1h
ratioCtrLt2h = meanAntisenseCtrLt2h/meanSenseCtrLt2h
ratioCtrLt4h = meanAntisenseCtrLt4h/meanSenseCtrLt4h
ratioCtrLt8h = meanAntisenseCtrLt8h/meanSenseCtrLt8h
ratioInfLt0h = meanAntisenseInfLt0h/meanSenseInfLt0h
ratioInfLt1h = meanAntisenseInfLt1h/meanSenseInfLt1h
ratioInfLt2h = meanAntisenseInfLt2h/meanSenseInfLt2h
ratioInfLt4h = meanAntisenseInfLt4h/meanSenseInfLt4h
ratioInfLt8h = meanAntisenseInfLt8h/meanSenseInfLt8h
ratioCtrDk0h = meanAntisenseCtrDk0h/meanSenseCtrDk0h
ratioCtrDk1h = meanAntisenseCtrDk1h/meanSenseCtrDk1h
ratioCtrDk2h = meanAntisenseCtrDk2h/meanSenseCtrDk2h
ratioCtrDk4h = meanAntisenseCtrDk4h/meanSenseCtrDk4h
ratioCtrDk8h = meanAntisenseCtrDk8h/meanSenseCtrDk8h
ratioInfDk0h = meanAntisenseInfDk0h/meanSenseInfDk0h
ratioInfDk1h = meanAntisenseInfDk1h/meanSenseInfDk1h
ratioInfDk2h = meanAntisenseInfDk2h/meanSenseInfDk2h
ratioInfDk4h = meanAntisenseInfDk4h/meanSenseInfDk4h
ratioInfDk8h = meanAntisenseInfDk8h/meanSenseInfDk8h

# store row (gene) names
myRowNames = rownames(countsTableSense)

# build time-series matrices
ratioCtrLt = matrix(c(ratioCtrLt0h, ratioCtrLt1h, ratioCtrLt2h, ratioCtrLt4h, ratioCtrLt8h), ncol=5)
rownames(ratioCtrLt) = myRowNames
colnames(ratioCtrLt) = c("ratioCtrLt0h", "ratioCtrLt1h", "ratioCtrLt2h", "ratioCtrLt4h", "ratioCtrLt8h")

ratioInfLt = matrix(c(ratioInfLt0h, ratioInfLt1h, ratioInfLt2h, ratioInfLt4h, ratioInfLt8h), ncol=5)
rownames(ratioInfLt) = myRowNames
colnames(ratioInfLt) = c("ratioInfLt0h", "ratioInfLt1h", "ratioInfLt2h", "ratioInfLt4h", "ratioInfLt8h")

ratioCtrDk = matrix(c(ratioCtrDk0h, ratioCtrDk1h, ratioCtrDk2h, ratioCtrDk4h, ratioCtrDk8h), ncol=5)
rownames(ratioCtrDk) = myRowNames
colnames(ratioCtrDk) = c("ratioCtrDk0h", "ratioCtrDk1h", "ratioCtrDk2h", "ratioCtrDk4h", "ratioCtrDk8h")

ratioInfDk = matrix(c(ratioInfDk0h, ratioInfDk1h, ratioInfDk2h, ratioInfDk4h, ratioInfDk8h), ncol=5)
rownames(ratioInfDk) = myRowNames
colnames(ratioInfDk) = c("ratioInfDk0h", "ratioInfDk1h", "ratioInfDk2h", "ratioInfDk4h", "ratioInfDk8h")

# write csv of time-series
write.csv(round(ratioCtrLt,4), file="ratioCtrLt.csv", quote=FALSE)
write.csv(round(ratioInfLt,4), file="ratioInfLt.csv", quote=FALSE)
write.csv(round(ratioCtrDk,4), file="ratioCtrDk.csv", quote=FALSE)
write.csv(round(ratioInfDk,4), file="ratioInfDk.csv", quote=FALSE)

# find all genes (separate for each experiment) with average antisense/sense ratio > 10
# sense and antisense means must also all be > 0
avgRatioCtrLt = rowSums(ratioCtrLt)/5
boolRatioCtrLt = ((avgRatioCtrLt > 10) & (!is.nan(avgRatioCtrLt)))
boolSenseCtrLt = ((meanSenseCtrLt0h > 0) & (meanSenseCtrLt1h > 0) & (meanSenseCtrLt2h > 0) & (meanSenseCtrLt4h > 0) & (meanSenseCtrLt8h > 0))
boolAntisenseCtrLt = ((meanAntisenseCtrLt0h > 0) & (meanAntisenseCtrLt1h > 0) & (meanAntisenseCtrLt2h > 0) & (meanAntisenseCtrLt4h > 0) & (meanAntisenseCtrLt8h > 0))
goodAvgRatioCtrLt = avgRatioCtrLt[(boolRatioCtrLt==TRUE) & (boolSenseCtrLt==TRUE) & (boolAntisenseCtrLt==TRUE)]
write.csv(round(goodAvgRatioCtrLt,2), file="ratiosGtTenCtrLt.csv", quote=FALSE)

avgRatioInfLt = rowSums(ratioInfLt)/5
boolRatioInfLt = ((avgRatioInfLt > 10) & (!is.nan(avgRatioInfLt)))
boolSenseInfLt = ((meanSenseInfLt0h > 0) & (meanSenseInfLt1h > 0) & (meanSenseInfLt2h > 0) & (meanSenseInfLt4h > 0) & (meanSenseInfLt8h > 0))
boolAntisenseInfLt = ((meanAntisenseInfLt0h > 0) & (meanAntisenseInfLt1h > 0) & (meanAntisenseInfLt2h > 0) & (meanAntisenseInfLt4h > 0) & (meanAntisenseInfLt8h > 0))
goodAvgRatioInfLt = avgRatioInfLt[(boolRatioInfLt==TRUE) & (boolSenseInfLt==TRUE) & (boolAntisenseInfLt==TRUE)]
write.csv(round(goodAvgRatioInfLt,2), file="ratiosGtTenInfLt.csv", quote=FALSE)

avgRatioCtrDk = rowSums(ratioCtrDk)/5
boolRatioCtrDk = ((avgRatioCtrDk > 10) & (!is.nan(avgRatioCtrDk)))
boolSenseCtrDk = ((meanSenseCtrDk0h > 0) & (meanSenseCtrDk1h > 0) & (meanSenseCtrDk2h > 0) & (meanSenseCtrDk4h > 0) & (meanSenseCtrDk8h > 0))
boolAntisenseCtrDk = ((meanAntisenseCtrDk0h > 0) & (meanAntisenseCtrDk1h > 0) & (meanAntisenseCtrDk2h > 0) & (meanAntisenseCtrDk4h > 0) & (meanAntisenseCtrDk8h > 0))
goodAvgRatioCtrDk = avgRatioCtrDk[(boolRatioCtrDk==TRUE) & (boolSenseCtrDk==TRUE) & (boolAntisenseCtrDk==TRUE)]
write.csv(round(goodAvgRatioCtrDk,2), file="ratiosGtTenCtrDk.csv", quote=FALSE)

avgRatioInfDk = rowSums(ratioInfDk)/5
boolRatioInfDk = ((avgRatioInfDk > 10) & (!is.nan(avgRatioInfDk)))
boolSenseInfDk = ((meanSenseInfDk0h > 0) & (meanSenseInfDk1h > 0) & (meanSenseInfDk2h > 0) & (meanSenseInfDk4h > 0) & (meanSenseInfDk8h > 0))
boolAntisenseInfDk = ((meanAntisenseInfDk0h > 0) & (meanAntisenseInfDk1h > 0) & (meanAntisenseInfDk2h > 0) & (meanAntisenseInfDk4h > 0) & (meanAntisenseInfDk8h > 0))
goodAvgRatioInfDk = avgRatioInfDk[(boolRatioInfDk==TRUE) & (boolSenseInfDk==TRUE) & (boolAntisenseInfDk==TRUE)]
write.csv(round(goodAvgRatioInfDk,2), file="ratiosGtTenInfDk.csv", quote=FALSE)

# find all genes (combined for all experiments) with average antisense/sense ratio > 10
# sense and antisense means must also all be > 0
avgRatioTotal = (avgRatioCtrLt+avgRatioInfLt+avgRatioCtrDk+avgRatioInfDk)/4
boolRatioTotal = ((avgRatioTotal > 10) & (!is.nan(avgRatioTotal)))
boolSenseTotal = ((meanSenseCtrLt0h > 0) & (meanSenseCtrLt1h > 0) & (meanSenseCtrLt2h > 0) & (meanSenseCtrLt4h > 0) & (meanSenseCtrLt8h > 0) & (meanSenseInfLt0h > 0) & (meanSenseInfLt1h > 0) & (meanSenseInfLt2h > 0) & (meanSenseInfLt4h > 0) & (meanSenseInfLt8h > 0) & (meanSenseCtrDk0h > 0) & (meanSenseCtrDk1h > 0) & (meanSenseCtrDk2h > 0) & (meanSenseCtrDk4h > 0) & (meanSenseCtrDk8h > 0) & (meanSenseInfDk0h > 0) & (meanSenseInfDk1h > 0) & (meanSenseInfDk2h > 0) & (meanSenseInfDk4h > 0) & (meanSenseInfDk8h > 0))
boolAntisenseTotal = ((meanAntisenseCtrLt0h > 0) & (meanAntisenseCtrLt1h > 0) & (meanAntisenseCtrLt2h > 0) & (meanAntisenseCtrLt4h > 0) & (meanAntisenseCtrLt8h > 0) & (meanAntisenseInfLt0h > 0) & (meanAntisenseInfLt1h > 0) & (meanAntisenseInfLt2h > 0) & (meanAntisenseInfLt4h > 0) & (meanAntisenseInfLt8h > 0) & (meanAntisenseCtrDk0h > 0) & (meanAntisenseCtrDk1h > 0) & (meanAntisenseCtrDk2h > 0) & (meanAntisenseCtrDk4h > 0) & (meanAntisenseCtrDk8h > 0) & (meanAntisenseInfDk0h > 0) & (meanAntisenseInfDk1h > 0) & (meanAntisenseInfDk2h > 0) & (meanAntisenseInfDk4h > 0) & (meanAntisenseInfDk8h > 0))
goodAvgRatioTotal = avgRatioTotal[(boolRatioTotal==TRUE) & (boolSenseTotal==TRUE) & (boolAntisenseTotal==TRUE)]
write.csv(round(goodAvgRatioTotal,2), file="ratiosGtTenTotal.csv", quote=FALSE)
