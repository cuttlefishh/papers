#first: source("rpkmClust.R")

#get gene list
genesAll<-geneInfo$V1
genesHo<-genesAll[1:2015]
genesPh<-genesAll[2016:2257]

#initialize pairs list
pairsPh<-array("",c(0))
pairsHo<-array("",c(0))

#check if pairs of genes are in a cluster together in both light and dark treatments
for(i in 1:(242-1)) {
  for(j in (i+1):242) {
    if(pamKLrpkmPhInfLt$cluster[i]==pamKLrpkmPhInfLt$cluster[j]) {
      if(pamKLrpkmPhInfDk$cluster[i]==pamKLrpkmPhInfDk$cluster[j]) {
        pairsPh<-c(pairsPh,genesPh[i],genesPh[j])
      }
    }
  }
}
for(i in 1:(2015-1)) {
  for(j in (i+1):2015) {
    if(pamKLrpkmHoInfLt$cluster[i]==pamKLrpkmHoInfLt$cluster[j]) {
      if(pamKLrpkmHoInfDk$cluster[i]==pamKLrpkmHoInfDk$cluster[j]) {
        pairsHo<-c(pairsHo,genesHo[i],genesHo[j])
      }
    }
  }
}

