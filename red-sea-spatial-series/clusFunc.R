KLdiss=function(p,q) {
	n=length(p)
	p1=ifelse(p==0,10^(-6),p)
	p1=p1/sum(p1)
	q1=ifelse(q==0,10^(-6),q)
	q1=q1/sum(q1)
	sum((p1-q1)*log(p1/q1))
}

distKL=function(x) { # Computes the KLdiss for each pair of rows in matrix x
	x1=as.matrix(x)
	n=dim(x)[1]
	DD=matrix(0,n,n)
	for (i in 2:n){for (j in 1:(i-1)){DD[i,j]=KLdiss(x1[i,],x1[j,])}}
	(DD+t(DD))/2
}

KLpam <- function(x, k) {
    dmat <- distKL(x) ## <-- use your Kullback-Leibler (not "Liebler") function
    myDist <- as.dist(dmat)
    pam(myDist, k,diss=TRUE)
}

cl.assign=function(i1,x,k=4) { #assigns elements of x to k clusters labelled by i1
  clus=vector("list",k)
  for (j in 1:k){clus[[j]]=x[i1==j]}
  clus
}

library(cluster)

