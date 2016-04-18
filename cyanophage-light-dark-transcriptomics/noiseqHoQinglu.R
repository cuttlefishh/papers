# call noiseq library
library("NOISeq")

# read in SENSE counts file
countsTableHo <- read.delim("natl2a_Prepl_sense_R.tsv",header=TRUE,stringsAsFactors=FALSE,sep="\t",quote="")

# split counts into host and phage counts -- ALREADY HOST ONLY
# countsTableHo <- countsTable[1:2015,]
# countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts -- ALREADY DONE BY QINGLU
# countsTableHo <- countsTableHo[c(-347,-350),]

# remove lines with zero counts across all samples
countsTableHo <- countsTableHo[c(-2176),] #corresponds to PMN2A_2179

# store noiseq factors as data.frame/matrix
myfactorsHo <- data.frame(row.names = colnames(countsTableHo), condition = c("inf_prepl_0h","inf_prepl_0h","inf_prepl_1h","inf_prepl_1h","inf_prepl_2h","inf_prepl_2h","inf_prepl_4h","inf_prepl_4h","inf_prepl_8h","inf_prepl_8h","inf_prepl_12h","inf_prepl_12h"), infection = c("infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected"), timepoint = c("0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","12h","12h"))


# STOPPED EDITING HERE


# read in metadata file
metadataHo <- read.delim("AAAAAA_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
metadataHo <- metadataHo[c(-347,-350),]

# store noiseq length as vector
mylengthHo <- metadataHo$EndCoordinate-metadataHo$StartCoordinate+1
names(mylengthHo) <- rownames(countsTableHo)

# store noiseq chroms as data.frame/matrix
mychromsHo <- data.frame(row.names = rownames(countsTableHo), chr = metadataHo$Chromosome, geneStart = metadataHo$StartCoordinate, geneEnd = metadataHo$EndCoordinate)

# read in protein/rna file
protOrRnaHo <- read.delim("protOrRna_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
protOrRnaHo <- protOrRnaHo[c(-347,-350),]

# store noiseq biotypes as vector
mybiotypesHo <- protOrRnaHo$Chromosome
names(mybiotypesHo) = rownames(countsTableHo)

# store noiseq data structure
mydataHo <- readData(data = countsTableHo, length = mylengthHo, biotype = mybiotypesHo, chromosome = mychromsHo, factors = myfactorsHo)

##### INF_LT vs CTR_LT #####
# compare inf_lt_0h with ctr_lt_0h, select differentially expressed genes, and save
print("Comparing inf_lt_0h with ctr_lt_0h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(21,1)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)

# compare inf_lt_1h with ctr_lt_1h, select differentially expressed genes, and save
print("Comparing inf_lt_1h with ctr_lt_1h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(23,3)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)

# compare inf_lt_2h with ctr_lt_2h, select differentially expressed genes, and save
print("Comparing inf_lt_2h with ctr_lt_2h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(25,5)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)

# compare inf_lt_4h with ctr_lt_4h, select differentially expressed genes, and save
print("Comparing inf_lt_4h with ctr_lt_4h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(27,7)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)

# compare inf_lt_8h with ctr_lt_8h, select differentially expressed genes, and save
print("Comparing inf_lt_8h with ctr_lt_8h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(29,9)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)

##### INF_DK vs CTR_DK #####
# compare inf_dk_0h with ctr_dk_0h, select differentially expressed genes, and save
print("Comparing inf_dk_0h with ctr_dk_0h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(31,11)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)

# compare inf_dk_1h with ctr_dk_1h, select differentially expressed genes, and save
print("Comparing inf_dk_1h with ctr_dk_1h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(33,13)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)

# compare inf_dk_2h with ctr_dk_2h, select differentially expressed genes, and save
print("Comparing inf_dk_2h with ctr_dk_2h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(35,15)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)

# compare inf_dk_4h with ctr_dk_4h, select differentially expressed genes, and save
print("Comparing inf_dk_4h with ctr_dk_4h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(37,17)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)

# compare inf_dk_8h with ctr_dk_8h, select differentially expressed genes, and save
print("Comparing inf_dk_8h with ctr_dk_8h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(39,19)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)

##### INF_LT vs INF_DK #####
# compare inf_lt_0h with inf_dk_0h, select differentially expressed genes, and save
print("Comparing inf_lt_0h with inf_dk_0h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(21,31)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)

# compare inf_lt_1h with inf_dk_1h, select differentially expressed genes, and save
print("Comparing inf_lt_1h with inf_dk_1h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(23,33)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)

# compare inf_lt_2h with inf_dk_2h, select differentially expressed genes, and save
print("Comparing inf_lt_2h with inf_dk_2h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(25,35)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)

# compare inf_lt_4h with inf_dk_4h, select differentially expressed genes, and save
print("Comparing inf_lt_4h with inf_dk_4h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(27,37)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)

# compare inf_lt_8h with inf_dk_8h, select differentially expressed genes, and save
print("Comparing inf_lt_8h with inf_dk_8h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(29,39)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)

##### CTR_LT vs CTR_DK #####
# compare ctr_lt_0h with ctr_dk_0h, select differentially expressed genes, and save
print("Comparing ctr_lt_0h with ctr_dk_0h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(1,11)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.ctr_lt_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.ctr_lt_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.ctr_lt_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.ctr_lt_0h.ctr_dk_0h.csv",quote = FALSE)

# compare ctr_lt_1h with ctr_dk_1h, select differentially expressed genes, and save
print("Comparing ctr_lt_1h with ctr_dk_1h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(3,13)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.ctr_lt_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.ctr_lt_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.ctr_lt_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.ctr_lt_1h.ctr_dk_1h.csv",quote = FALSE)

# compare ctr_lt_2h with ctr_dk_2h, select differentially expressed genes, and save
print("Comparing ctr_lt_2h with ctr_dk_2h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(5,15)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.ctr_lt_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.ctr_lt_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.ctr_lt_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.ctr_lt_2h.ctr_dk_2h.csv",quote = FALSE)

# compare ctr_lt_4h with ctr_dk_4h, select differentially expressed genes, and save
print("Comparing ctr_lt_4h with ctr_dk_4h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(7,17)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.ctr_lt_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.ctr_lt_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.ctr_lt_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.ctr_lt_4h.ctr_dk_4h.csv",quote = FALSE)

# compare ctr_lt_8h with ctr_dk_8h, select differentially expressed genes, and save
print("Comparing ctr_lt_8h with ctr_dk_8h...")
mynoiseqHo = noiseq(mydataHo, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHo$condition[c(9,19)], nss = 0, lc = 1, replicates = "biological")
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.8, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.8, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.8, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.ctr_lt_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.ctr_lt_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.ctr_lt_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.ctr_lt_8h.ctr_dk_8h.csv",quote = FALSE)



