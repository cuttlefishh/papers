# clear workspace
rm(list=ls())

# call noiseq library
library("NOISeq")

# read in SENSE counts file
countsTable <- read.delim("med4phm2_sense_R.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "")

# split counts into host and phage counts
countsTableHo <- countsTable[1:2015,]
countsTablePh <- countsTable[2016:2257,]

# remove LSU and SSU from host counts
countsTableHo <- countsTableHo[c(-347,-350),]

# filter low counts
countsTableHoFilt = filtered.data(
	countsTableHo, 
	factor = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 100, 
	cpm = 10)

# list which genes were filtered out
bool <- rownames(countsTableHo) %in% rownames(countsTableHoFilt)

# store noiseq factors as data.frame/matrix
myfactorsHo <- data.frame(
	row.names = colnames(countsTableHoFilt), 
	condition = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"), 
	infection = c("control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected"), 
	lightness = c("light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark"), 
	timepoint = c("0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h", "0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h", "0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h", "0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h"))

# read in metadata file and delete rRNA and low counts
metadataHo <- read.delim("AAAAAA_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
metadataHo <- metadataHo[c(-347,-350),]
metadataHo <- metadataHo[bool==TRUE,]

# store noiseq length as vector
mylengthHo <- metadataHo$EndCoordinate-metadataHo$StartCoordinate+1
names(mylengthHo) <- rownames(countsTableHoFilt)

# store noiseq chroms as data.frame/matrix
mychromsHo <- data.frame(row.names = rownames(countsTableHoFilt), chr = metadataHo$Chromosome, geneStart = metadataHo$StartCoordinate, geneEnd = metadataHo$EndCoordinate)

# read in protein/rna file and delete rRNA and low counts
protOrRnaHo <- read.delim("protOrRna_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
protOrRnaHo <- protOrRnaHo[c(-347,-350),]
protOrRnaHo <- protOrRnaHo[bool==TRUE,]

# store noiseq biotypes as vector
mybiotypesHo <- protOrRnaHo$Chromosome
names(mybiotypesHo) = rownames(countsTableHoFilt)

# store noiseq data structure
mydataHo <- readData(data = countsTableHoFilt, length = mylengthHo, biotype = NULL, chromosome = mychromsHo, factors = myfactorsHo)

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



