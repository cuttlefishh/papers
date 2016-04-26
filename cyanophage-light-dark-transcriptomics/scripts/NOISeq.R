### R code from vignette source 'vignettes/NOISeq/inst/doc/NOISeq.Rnw'
### Encoding: ASCII

###################################################
### code chunk number 1: options
###################################################
options(digits=3, width=95)


###################################################
### code chunk number 2: data
###################################################
library(NOISeq)
data(Marioni)


###################################################
### code chunk number 3: NOISeq.Rnw:79-80
###################################################
head(mycounts)


###################################################
### code chunk number 4: factors
###################################################
myfactors = data.frame(Tissue=c("Kidney","Liver","Kidney","Liver","Liver","Kidney","Liver",
                                "Kidney","Liver","Kidney"),
                       TissueRun = c("Kidney_1","Liver_1","Kidney_1","Liver_1","Liver_1",
                                     "Kidney_1","Liver_1","Kidney_2","Liver_2","Kidney_2"))


###################################################
### code chunk number 5: NOISeq.Rnw:105-108
###################################################
head(mylength)
head(mybiotypes)
head(mychroms)


###################################################
### code chunk number 6: readData
###################################################
mydata <- readData(data=mycounts,length=mylength, biotype=mybiotypes,
                   chromosome=mychroms, factors=myfactors)
mydata


###################################################
### code chunk number 7: NOISeq.Rnw:128-132
###################################################
str(mydata)
head(assayData(mydata)$exprs)
head(pData(mydata))
head(featureData(mydata)@data)


###################################################
### code chunk number 8: readData2
###################################################
mydata <- readData(data=mycounts,chromosome=mychroms, factors=myfactors)


###################################################
### code chunk number 9: readData3
###################################################
mydata <- addData(mydata, length=mylength, biotype=mybiotypes)


###################################################
### code chunk number 10: dat
###################################################
myexplodata <- dat(mydata, type = "biodetection", selection = c(3,4))


###################################################
### code chunk number 11: fig_biodetection
###################################################
mybiodetection <- dat(mydata, selection=c(1,2), k = 0, type = "biodetection")
explo.plot(mybiodetection)


###################################################
### code chunk number 12: fig_countdistr
###################################################
mycd = dat(mydata, selection=c(1,2), type = "cd")
explo.plot(mycd)


###################################################
### code chunk number 13: fig_boxplot1
###################################################
mycountsbio = dat(mydata, selection = NULL, k = 0, ndepth = 5, type = "countsbio")
explo.plot(mycountsbio, toplot = 1, samples = c(1,2), ylim = c(0,200))


###################################################
### code chunk number 14: fig_boxplot2
###################################################
explo.plot(mycountsbio, toplot = "protein_coding", samples = 5, ylim = c(0,200))


###################################################
### code chunk number 15: fig_length
###################################################
myDLbio = dat(mydata, selection = NULL, k = 0, ndepth = 5, type = "DLbio")
explo.plot(myDLbio, samples = 3:6, toplot = "protein_coding")


###################################################
### code chunk number 16: fig_sat1
###################################################
mysaturation = dat(mydata, k = 0, ndepth = 5, newdetections = TRUE, type = "saturation")
explo.plot(mysaturation, toplot = 1, samples = 1:2, ylim = NULL, yrightlim = NULL)


###################################################
### code chunk number 17: fig_sat2
###################################################
explo.plot(mysaturation, toplot = "protein_coding", samples = 1:4, ylim = NULL, yrightlim = NULL)


###################################################
### code chunk number 18: normalization
###################################################
myRPKM = rpkm(assayData(mydata)$exprs, long = mylength, k = 0, lc = 1)
myUQUA = uqua(assayData(mydata)$exprs, long = mylength, lc = 0.5, k = 0)
myTMM = tmm(assayData(mydata)$exprs, long = 1000, lc = 1)
head(myRPKM[,1:4])


###################################################
### code chunk number 19: results
###################################################
mynoiseq = noiseq(mydata, k = 0.5, norm = "rpkm", factor="Tissue", pnr = 0.2, 
                  nss = 5, v = 0.02, lc = 1, replicates = "technical")
head(mynoiseq@results[[1]])


###################################################
### code chunk number 20: NOISeq.Rnw:449-451
###################################################
mynoiseq.tmm = noiseq(mydata, k = 0.5, norm = "tmm", factor="TissueRun", 
                      conditions = c("Kidney_1","Liver_1"), lc = 0, replicates = "technical")


###################################################
### code chunk number 21: NOISeq.Rnw:470-472
###################################################
myresults <- noiseq(mydata, factor = "Tissue", k = NULL, norm="n", pnr = 0.2, 
                    nss = 5, v = 0.02, lc = 1, replicates = "no")


###################################################
### code chunk number 22: NOISeq.Rnw:506-507
###################################################
head(mynoiseq@results[[1]])


###################################################
### code chunk number 23: NOISeq.Rnw:522-525
###################################################
mynoiseq.deg = degenes(mynoiseq, q = 0.8, M = NULL)
mynoiseq.deg1 = degenes(mynoiseq, q = 0.8, M = "up")
mynoiseq.deg2 = degenes(mynoiseq, q = 0.8, M = "down")


###################################################
### code chunk number 24: fig_summ_expr
###################################################
DE.plot(mynoiseq, q = 0.8, graphic = "expr", log.scale = TRUE)


###################################################
### code chunk number 25: fig_summ_MD
###################################################
DE.plot(mynoiseq, q = 0.8, graphic = "MD", ylim = c(0,50))


###################################################
### code chunk number 26: fig_manhattan
###################################################
DE.plot(mynoiseq, chromosomes = c(1,2), log.scale = TRUE,
        join = FALSE, q = 0.8, graphic = "chrom")


###################################################
### code chunk number 27: fig_distrDEG
###################################################
DE.plot(mynoiseq, chromosomes = NULL, q = 0.8, graphic = "distr")


###################################################
### code chunk number 28: session
###################################################
sessionInfo()

