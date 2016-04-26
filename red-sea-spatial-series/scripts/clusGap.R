#### Originally from orphaned package SLmisc
#### (Version: 1.4.1, 2007-04-12, Maintainer: Matthias Kohl <kohl@sirs-lab.com>)
#### License: GPL (version 2 or later)
####
#### which said
####  "function corresponds to function gap in package SAGx"

## MM: SAGx is now in Bioconductor --- 1.10.1{devel} or 1.11.1{release}
##     had gap() *corrected* to re-cluster using FUNcluster --> see ./gap-SAGx.R.~orig~
##
## MM: Package 'lga' -- has gap() and lga and robust lga [-> UBC]
##    - it uses  boot() nicely  [2012-01: ORPHANED because  Justin Harrington is amiss]
## MM: renamed arguments, and changed almost everything

clusGap <- function (x, FUNcluster, K.max, B = 100, verbose = interactive(), ...)
{
    stopifnot(is.function(FUNcluster), length(dim(x)) == 2, K.max >= 2,
              (n <- nrow(x)) >= 1, (p <- ncol(x)) >= 1)
    if(B != (B. <- as.integer(B)) || (B <- B.) <= 0)
        stop("'B' has to be a positive integer")

    if(is.data.frame(x))
        x <- as.matrix(x)
    ii <- seq_len(n)
    W.k <- function(X, kk) {
        clus <- if(kk > 1) FUNcluster(X, kk, ...)$cluster else rep.int(1L, nrow(X))
### Just for debugging
###        clus <- if(kk > 1) FUNcluster(X, kk)$cluster else rep.int(1L, nrow(X))
        ##                 ---------- =  =       -------- kmeans() has 'cluster'; pam() 'clustering'
	## FIXME(still): instead of tapply(), use
	## i.e.	  vapply(split(.., clustering), function(x) ..,	 0.)
	0.5* sum(tapply(ii, clus,
			function(I) { xs <- X[I,, drop=FALSE] ; sum(dist(xs)/nrow(xs)) }))
    }
    logW <- E.logW <- SE.sim <- numeric(K.max)
    if(verbose) cat("Clustering k = 1,2,..., K.max (= ",K.max,"): .. ", sep='')
    for(k in 1:K.max)
        logW[k] <- log(W.k(x, k))
    if(verbose) cat("done\n")

    xs <- scale(x, center=TRUE, scale=FALSE)
    m.x <- rep(attr(xs,"scaled:center"), each = n)# for back transforming
    V.sx <- svd(xs)$v
    rng.x1 <- apply(xs %*% V.sx, # = transformed(x)
                    2, range)
    logWks <- matrix(0., B, K.max)
    if(verbose) cat("Bootstrapping, b = 1,2,..., B (= ", B,
                    ")  [one \".\" per sample]:\n", sep="")
    for (b in 1:B) {
        z1 <- apply(rng.x1, 2,
                    function(M, nn) runif(nn, min=M[1], max=M[2]),
                    nn=n)
        z <- tcrossprod(z1, V.sx) + m.x # back transformed
        for(k in 1:K.max) {
            logWks[b,k] <- log(W.k(z, k))
        }
        if(verbose) cat(".", if(b %% 50 == 0) paste(b,"\n"))
    }
    if(verbose && (B %% 50 != 0)) cat("",B,"\n")
    E.logW <- colMeans(logWks)
    SE.sim <- sqrt((1 + 1/B) * apply(logWks, 2, var))
    structure(class = "clusGap",
              list(Tab = cbind(logW, E.logW, gap = E.logW - logW, SE.sim),
                   ## K.max == nrow(T)
                   n = n, B = B, FUNcluster=FUNcluster))
}

## FIXME(?)  lga/R/gap.R contains a
## has for Tibshirani et al (2001):
        ## ElogWks[k,] <- c(mean(BootOutput), sqrt(var(BootOutput)*(1+1/B)))
        ## GAP[k] <- ElogWks[k,1] - logWks[k]
        ## if (k > 1)
        ##     if(GAP[k-1] >= GAP[k]-ElogWks[k,2] & !doall)
        ##         finished <- TRUE
##  so they effectively only look for the *first* (local) maximum which ..
## MM: <==> diff(GAP) = GAP[k] - GAP[k-1] <= +SE.sim[k]


## criteria.DandF() -- Dudoit and Fridlyand (2002)
## ---------------- looks at the *global* maximum and then to the left..
    ## y <- x$data
    ## crit <- diff(y[which.max(y[,"Gap"]), c("Sks", "Gap")])
    ## nclust <- min(which(y[,"Gap"] > crit))
    ## return(ifelse(nclust == nrow(y), NA, nclust))

## FIXME, at least two methods to find k_{opt} -- should provide *function*
## to estimate that, and then call the function from the print() method
print.clusGap <- function(x, SE.factor = 1, ...) {
    stopifnot((K <- nrow(T <- x$Tab)) >= 1, SE.factor >= 0)
    cat("Clustering Gap statistic [\"clusGap\"].\n",
        sprintf("B=%d simulated reference sets, k = 1..%d\n",x$B, K), sep="")
    gap <- T[,"gap"]
    ## TODO?  Instead of just SE.factor, allow even more general "k_opt" rules
    nc <- which.max(gap)
    if(any(ii <- gap[seq_len(nc - 1)] >= gap[nc] - SE.factor * T[nc,"SE.sim"]))
	nc <- which(ii)[1]
    cat(sprintf(" --> Number of clusters (= maximal gap 'modulo'  %g S.E. rule): %d\n",
                SE.factor, nc))
    print(T, ...)
    invisible(x)
}

plot.clusGap <- function(x, type="b", xlab = "k", ylab = expression(Gap[k]),
                         do.arrows=TRUE,
                         arrowArgs = list(col="red3", length=1/16, angle=90, code=3),
                         ...)
{
    stopifnot(is.matrix(Tab <- x$Tab), is.numeric(Tab))
    K <- nrow(Tab)
    k <- seq_len(K) # == 1,2,... k
    gap <- Tab[, "gap"]
    plot(k, gap, type=type, xlab=xlab, ylab=ylab, ...)
    if(do.arrows)
	do.call(arrows,
		c(list(k, gap+ Tab[, "SE.sim"], k, gap- Tab[, "SE.sim"]), arrowArgs))
    invisible()
}
