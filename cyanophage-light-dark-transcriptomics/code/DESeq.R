### R code from vignette source 'DESeq.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(digits=3)


###################################################
### code chunk number 2: systemFile
###################################################
datafile <- system.file( "extdata/pasilla_gene_counts.tsv", package="pasilla" )
datafile


###################################################
### code chunk number 3: readTable
###################################################
pasillaCountTable <- read.table( datafile, header=TRUE, row.names=1 )
head( pasillaCountTable )


###################################################
### code chunk number 4: pasillaDesign
###################################################
pasillaDesign <- data.frame(
   row.names = colnames( pasillaCountTable ),
   condition = c( "untreated", "untreated", "untreated",
      "untreated", "treated", "treated", "treated" ),
   libType = c( "single-end", "single-end", "paired-end",
      "paired-end", "single-end", "paired-end", "paired-end" ) )

pasillaDesign


###################################################
### code chunk number 5: pairedSamples
###################################################
pairedSamples <- pasillaDesign$libType == "paired-end"
countTable <- pasillaCountTable[ , pairedSamples ]
conds <- pasillaDesign$condition[ pairedSamples ]


###################################################
### code chunk number 6: DESeq.Rnw:155-157
###################################################
head(countTable)
conds


###################################################
### code chunk number 7: conds (eval = FALSE)
###################################################
## #not run
## conds <- factor( c( "untreated", "untreated", "treated", "treated" ) )


###################################################
### code chunk number 8: condsCheck
###################################################
#not run
stopifnot( identical( conds, factor( c( "untreated", "untreated", "treated", "treated" ) ) ) )


###################################################
### code chunk number 9: instantiate
###################################################
library( "DESeq" )

cds <- newCountDataSet( countTable, conds )


###################################################
### code chunk number 10: headcounts1
###################################################
head( counts(cds) )


###################################################
### code chunk number 11: estimateSizeFactors
###################################################
cds <- estimateSizeFactors( cds )
sizeFactors( cds )


###################################################
### code chunk number 12: headcounts2
###################################################
head( counts( cds, normalized=TRUE ) )


###################################################
### code chunk number 13: estimateDispersions
###################################################
cds <- estimateDispersions( cds )


###################################################
### code chunk number 14: str
###################################################
str( fitInfo(cds) )


###################################################
### code chunk number 15: fitUntr
###################################################
plotDispEsts <- function( cds )
{
   plot(
      rowMeans( counts( cds, normalized=TRUE ) ),
      fitInfo(cds)$perGeneDispEsts,
      pch = '.', log="xy" )
   xg <- 10^seq( -.5, 5, length.out=300 )
   lines( xg, fitInfo(cds)$dispFun( xg ), col="red" )
}


###################################################
### code chunk number 16: figFit
###################################################
plotDispEsts( cds )


###################################################
### code chunk number 17: DESeq.Rnw:297-298
###################################################
all(table(conditions(cds))==2)


###################################################
### code chunk number 18: head
###################################################
head( fData(cds) )


###################################################
### code chunk number 19: str
###################################################
str( fitInfo(cds) )


###################################################
### code chunk number 20: nbt1
###################################################
res <- nbinomTest( cds, "untreated", "treated" )


###################################################
### code chunk number 21: nbt2
###################################################
head(res)


###################################################
### code chunk number 22: figDE
###################################################
plotDE <- function( res )
   plot(
      res$baseMean,
      res$log2FoldChange,
      log="x", pch=20, cex=.3,
      col = ifelse( res$padj < .1, "red", "black" ) )

plotDE( res )


###################################################
### code chunk number 23: histp
###################################################
hist(res$pval, breaks=100, col="skyblue", border="slateblue", main="")


###################################################
### code chunk number 24: ressig1
###################################################
resSig <- res[ res$padj < 0.1, ]


###################################################
### code chunk number 25: ressig2
###################################################
head( resSig[ order(resSig$pval), ] )


###################################################
### code chunk number 26: ressig3
###################################################
head( resSig[ order( resSig$foldChange, -resSig$baseMean ), ] )


###################################################
### code chunk number 27: ressig4
###################################################
head( resSig[ order( -resSig$foldChange, -resSig$baseMean ), ] )


###################################################
### code chunk number 28: writetable (eval = FALSE)
###################################################
## #not run
## write.table( res, file="results.txt" )


###################################################
### code chunk number 29: ncu
###################################################
ncu <- counts( cds, normalized=TRUE )[ , conditions(cds)=="untreated" ]


###################################################
### code chunk number 30: MArepl
###################################################
plot( rowMeans(ncu), log2( ncu[,2] / ncu[,1] ), pch=".", log="x" )


###################################################
### code chunk number 31: subset
###################################################
cdsTTU <- cds[ , 1:3]
pData( cdsTTU )


###################################################
### code chunk number 32: est123
###################################################
cdsTTU <- estimateSizeFactors( cdsTTU )
cdsTTU <- estimateDispersions( cdsTTU )
resTTU <- nbinomTest( cdsTTU, "untreated", "treated" )


###################################################
### code chunk number 33: figDE_Tb
###################################################
plotDE( resTTU )


###################################################
### code chunk number 34: subset2
###################################################
cds2 <- cds[ ,c(  "untreated3", "treated3"   ) ]


###################################################
### code chunk number 35: cds2
###################################################
cds2 <- estimateDispersions( cds2, method="blind", sharingMode="fit-only" )


###################################################
### code chunk number 36: res2
###################################################
res2 <- nbinomTest( cds2, "untreated", "treated" )


###################################################
### code chunk number 37: figDE2
###################################################
plotDE( res2 )


###################################################
### code chunk number 38: addmarg
###################################################
addmargins( table( res_sig = res$padj < .1, res2_sig = res2$padj < .1 ) )


###################################################
### code chunk number 39: reminderFullData
###################################################
head( pasillaCountTable )
pasillaDesign


###################################################
### code chunk number 40: fct
###################################################
cdsFull <- newCountDataSet( pasillaCountTable, pasillaDesign )


###################################################
### code chunk number 41: estsfdisp
###################################################
cdsFull <- estimateSizeFactors( cdsFull )
cdsFull <- estimateDispersions( cdsFull )


###################################################
### code chunk number 42: figFitPooled
###################################################
plotDispEsts( cdsFull )


###################################################
### code chunk number 43: fit1
###################################################
fit1 <- fitNbinomGLMs( cdsFull, count ~ libType + condition )
fit0 <- fitNbinomGLMs( cdsFull, count ~ libType  )


###################################################
### code chunk number 44: fitstr
###################################################
str(fit1)


###################################################
### code chunk number 45: pvalsGLM
###################################################
pvalsGLM <- nbinomGLMTest( fit1, fit0 )
padjGLM <- p.adjust( pvalsGLM, method="BH" )


###################################################
### code chunk number 46: addmarg2
###################################################
tab = table( "paired end only" = res$padj < .1, "all samples" = padjGLM < .1 )
addmargins( tab )


###################################################
### code chunk number 47: figDispScatter
###################################################
plot( 
   fitInfo(cds)$perGeneDispEsts, 
   fitInfo(cdsFull)$perGeneDispEsts,
   asp=1, log="xy",  pch=20,cex=.1 )
abline( a=0, b=1 )


###################################################
### code chunk number 48: lookatfit1
###################################################
head(fit1)


###################################################
### code chunk number 49: fullAnalysisSimple
###################################################
cdsFullB <- newCountDataSet( pasillaCountTable, pasillaDesign$condition )
cdsFullB <- estimateSizeFactors( cdsFullB )
cdsFullB <- estimateDispersions( cdsFullB )
resFullB <- nbinomTest( cdsFullB, "untreated", "treated" )


###################################################
### code chunk number 50: table
###################################################
addmargins(table(
   `all samples simple` = resFullB$padj < 0.1,
   `all samples GLM`    = padjGLM < 0.1 ))


###################################################
### code chunk number 51: rs
###################################################
rs <- rowSums ( counts ( cdsFull ))
use <- (rs > quantile(rs, 0.4))
table(use)
cdsFilt <- cdsFull[ use, ]


###################################################
### code chunk number 52: check
###################################################
stopifnot(!any(is.na(use)))


###################################################
### code chunk number 53: fitFilt
###################################################
fitFilt1  <- fitNbinomGLMs( cdsFilt, count ~ libType + condition )
fitFilt0  <- fitNbinomGLMs( cdsFilt, count ~ libType  )
pvalsFilt <- nbinomGLMTest( fitFilt1, fitFilt0 )
padjFilt  <- p.adjust(pvalsFilt, method="BH" )


###################################################
### code chunk number 54: doublecheck
###################################################
stopifnot(all.equal(pvalsFilt, pvalsGLM[use]))


###################################################
### code chunk number 55: tab
###################################################
padjFiltForComparison = rep(+Inf, length(padjGLM))
padjFiltForComparison[use] = padjFilt
tab = table( `no filtering`   = padjGLM < .1,
             `with filtering` = padjFiltForComparison < .1 )
addmargins(tab)


###################################################
### code chunk number 56: figscatterindepfilt
###################################################
plot(rank(rs)/length(rs), -log10(pvalsGLM), pch=".")


###################################################
### code chunk number 57: histindepfilt
###################################################
h1 = hist(pvalsGLM[!use], breaks=50, plot=FALSE)
h2 = hist(pvalsGLM[use], breaks=50, plot=FALSE)
colori = c(`do not pass`="khaki", `pass`="powderblue")


###################################################
### code chunk number 58: fighistindepfilt
###################################################
barplot(height = rbind(h1$counts, h2$counts),
        beside = FALSE, col = colori,
        space = 0, main = "", ylab="frequency")
text(x = c(0, length(h1$counts)), y = 0,
     label = paste(c(0,1)), adj = c(0.5,1.7), xpd=NA)
legend("topright", fill=rev(colori), legend=rev(names(colori)))


###################################################
### code chunk number 59: defvsd
###################################################
cdsBlind <- estimateDispersions( cds, method="blind" )
vsd <- getVarianceStabilizedData( cdsBlind )


###################################################
### code chunk number 60: vsd1
###################################################
##par(mai=ifelse(1:4 <= 2, par("mai"), 0))
px     = counts(cds)[,1] / sizeFactors(cds)[1]
ord    = order(px)
ord    = ord[px[ord] < 150]
ord    = ord[seq(1, length(ord), length=50)]
last   = ord[length(ord)]
colors = c("blue", "black")
matplot(px[ord],
        cbind(vsd[, 1], log2(px))[ord, ],
        type="l", lty=1, col=colors, xlab="n", ylab="f(n)")
legend("bottomright",
       legend = c(
        expression("variance stabilizing transformation"),
        expression(log[2](n/s))),
       fill=colors)


###################################################
### code chunk number 61: vsd2
###################################################
library("vsn")
meanSdPlot(vsd)


###################################################
### code chunk number 62: modlr
###################################################
mod_lfc <- (rowMeans( vsd[, conditions(cds)=="treated", drop=FALSE] ) -
            rowMeans( vsd[, conditions(cds)=="untreated", drop=FALSE] ))


###################################################
### code chunk number 63: dah
###################################################
lfc <- res$log2FoldChange
finite <- is.finite(lfc)
table(as.character(lfc[!finite]), useNA="always")


###################################################
### code chunk number 64: repl
###################################################
largeNumber <- 7
lfc <- ifelse(finite, lfc, sign(lfc) * largeNumber)


###################################################
### code chunk number 65: colorramp
###################################################
logdecade <- 1 + round( log10( 1+rowMeans(counts(cdsBlind, normalized=TRUE)) ) )
colors <- colorRampPalette( c( "gray", "blue" ) )(6)[logdecade]


###################################################
### code chunk number 66: figmodlr
###################################################
plot( lfc, mod_lfc, pch=20, cex=.4, asp=1,
      col = ifelse( finite, colors, "purple" ) )
abline( a=0, b=1, col="#40C04040" )


###################################################
### code chunk number 67: figHeatmap2a
###################################################
select <- order(res$pval)[1:40]
colors <- colorRampPalette(c("white","darkblue"))(100)
heatmap( vsd[select,],
         col = colors, scale = "none")


###################################################
### code chunk number 68: figHeatmap2b
###################################################
heatmap( counts(cds)[select,],
         col = colors, scale = "none")


###################################################
### code chunk number 69: sampleClust
###################################################
cdsFullBlind <- estimateDispersions( cdsFull, method = "blind" )
vsdFull <- getVarianceStabilizedData( cdsFullBlind )
dists <- dist( t( vsdFull ) )


###################################################
### code chunk number 70: figHeatmapSamples
###################################################
heatmap( as.matrix( dists ),
   symm=TRUE, scale="none", margins=c(10,10),
   col = colorRampPalette(c("darkblue","white"))(100),
   labRow = paste( pData(cdsFullBlind)$condition, pData(cdsFullBlind)$libType ) )


###################################################
### code chunk number 71: sessi
###################################################
sessionInfo()


