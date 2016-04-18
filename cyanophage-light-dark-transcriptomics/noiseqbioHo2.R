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

# split host counts into light and dark
countsTableHoLt = countsTableHo[,c(1:10,21:30)]
countsTableHoDk = countsTableHo[,c(11:20,31:40)]

# filter low counts
countsTableHoLtFilt = filtered.data(
	countsTableHoLt, 
	factor = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)
countsTableHoDkFilt = filtered.data(
	countsTableHoDk, 
	factor = c("ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"), 
	norm = FALSE, 
	depth = NULL, 
	method = 1, 
	cv.cutoff = 10, 
	cpm = 5)

# list which genes were filtered out
boolLt <- rownames(countsTableHoLt) %in% rownames(countsTableHoLtFilt)
boolDk <- rownames(countsTableHoDk) %in% rownames(countsTableHoDkFilt)

# store noiseq factors as data.frame/matrix
myfactorsHoLt <- data.frame(
	row.names = colnames(countsTableHoLtFilt), 
	condition = c("ctr_lt_0h", "ctr_lt_0h", "ctr_lt_1h", "ctr_lt_1h", "ctr_lt_2h", "ctr_lt_2h", "ctr_lt_4h", "ctr_lt_4h", "ctr_lt_8h", "ctr_lt_8h", "inf_lt_0h", "inf_lt_0h", "inf_lt_1h", "inf_lt_1h", "inf_lt_2h", "inf_lt_2h", "inf_lt_4h", "inf_lt_4h", "inf_lt_8h", "inf_lt_8h"), 
	infection = c("control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected"), 
	lightness = c("light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light", "light"), 
	timepoint = c("0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h", "0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h"))
myfactorsHoDk <- data.frame(
	row.names = colnames(countsTableHoDkFilt), 
	condition = c("ctr_dk_0h", "ctr_dk_0h", "ctr_dk_1h", "ctr_dk_1h", "ctr_dk_2h", "ctr_dk_2h", "ctr_dk_4h", "ctr_dk_4h", "ctr_dk_8h", "ctr_dk_8h", "inf_dk_0h", "inf_dk_0h", "inf_dk_1h", "inf_dk_1h", "inf_dk_2h", "inf_dk_2h", "inf_dk_4h", "inf_dk_4h", "inf_dk_8h", "inf_dk_8h"), 
	infection = c("control", "control", "control", "control", "control", "control", "control", "control", "control", "control", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected", "infected"), 
	lightness = c("dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark", "dark"), 
	timepoint = c("0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h", "0h", "0h", "1h", "1h", "2h", "2h", "4h", "4h", "8h", "8h"))

# read in metadata file and delete rRNA and low counts
metadataHo <- read.delim("AAAAAA_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
metadataHo <- metadataHo[c(-347,-350),]
metadataHoLt <- metadataHo[boolLt==TRUE,]
metadataHoDk <- metadataHo[boolDk==TRUE,]

# store noiseq length as vector
mylengthHoLt <- metadataHoLt$EndCoordinate-metadataHoLt$StartCoordinate+1
names(mylengthHoLt) <- rownames(countsTableHoLtFilt)
mylengthHoDk <- metadataHoDk$EndCoordinate-metadataHoDk$StartCoordinate+1
names(mylengthHoDk) <- rownames(countsTableHoDkFilt)

# store noiseq chroms as data.frame/matrix
mychromsHoLt <- data.frame(row.names = rownames(countsTableHoLtFilt), chr = metadataHoLt$Chromosome, geneStart = metadataHoLt$StartCoordinate, geneEnd = metadataHoLt$EndCoordinate)
mychromsHoDk <- data.frame(row.names = rownames(countsTableHoDkFilt), chr = metadataHoDk$Chromosome, geneStart = metadataHoDk$StartCoordinate, geneEnd = metadataHoDk$EndCoordinate)

# read in protein/rna file and delete rRNA and low counts
protOrRnaHo <- read.delim("protOrRna_Ho.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")
protOrRnaHo <- protOrRnaHo[c(-347,-350),]
protOrRnaHoLt <- protOrRnaHo[boolLt==TRUE,]
protOrRnaHoDk <- protOrRnaHo[boolDk==TRUE,]

# store noiseq biotypes as vector
mybiotypesHoLt <- protOrRnaHoLt$Chromosome
names(mybiotypesHoLt) = rownames(countsTableHoLtFilt)
mybiotypesHoDk <- protOrRnaHoDk$Chromosome
names(mybiotypesHoDk) = rownames(countsTableHoDkFilt)

# store noiseq data structure
mydataHoLt <- readData(data = countsTableHoLtFilt, length = mylengthHoLt, biotype = NULL, chromosome = mychromsHoLt, factors = myfactorsHoLt)
mydataHoDk <- readData(data = countsTableHoDkFilt, length = mylengthHoDk, biotype = NULL, chromosome = mychromsHoDk, factors = myfactorsHoDk)

##### INF_LT vs CTR_LT #####
# compare inf_lt_0h with ctr_lt_0h, select differentially expressed genes, and save
print("Comparing inf_lt_0h with ctr_lt_0h...")
mynoiseqHo = noiseqbio(mydataHoLt, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoLt$condition[c(11,1)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_0h.ctr_lt_0h.csv",quote = FALSE)

# compare inf_lt_1h with ctr_lt_1h, select differentially expressed genes, and save
print("Comparing inf_lt_1h with ctr_lt_1h...")
mynoiseqHo = noiseqbio(mydataHoLt, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoLt$condition[c(13,3)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_1h.ctr_lt_1h.csv",quote = FALSE)

# compare inf_lt_2h with ctr_lt_2h, select differentially expressed genes, and save
print("Comparing inf_lt_2h with ctr_lt_2h...")
mynoiseqHo = noiseqbio(mydataHoLt, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoLt$condition[c(15,5)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_2h.ctr_lt_2h.csv",quote = FALSE)

# compare inf_lt_4h with ctr_lt_4h, select differentially expressed genes, and save
print("Comparing inf_lt_4h with ctr_lt_4h...")
mynoiseqHo = noiseqbio(mydataHoLt, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoLt$condition[c(17,7)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_4h.ctr_lt_4h.csv",quote = FALSE)

# compare inf_lt_8h with ctr_lt_8h, select differentially expressed genes, and save
print("Comparing inf_lt_8h with ctr_lt_8h...")
mynoiseqHo = noiseqbio(mydataHoLt, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoLt$condition[c(19,9)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_lt_8h.ctr_lt_8h.csv",quote = FALSE)

##### INF_DK vs CTR_DK #####
# compare inf_dk_0h with ctr_dk_0h, select differentially expressed genes, and save
print("Comparing inf_dk_0h with ctr_dk_0h...")
mynoiseqHo = noiseqbio(mydataHoDk, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoDk$condition[c(11,1)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_0h.ctr_dk_0h.csv",quote = FALSE)

# compare inf_dk_1h with ctr_dk_1h, select differentially expressed genes, and save
print("Comparing inf_dk_1h with ctr_dk_1h...")
mynoiseqHo = noiseqbio(mydataHoDk, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoDk$condition[c(13,3)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_1h.ctr_dk_1h.csv",quote = FALSE)

# compare inf_dk_2h with ctr_dk_2h, select differentially expressed genes, and save
print("Comparing inf_dk_2h with ctr_dk_2h...")
mynoiseqHo = noiseqbio(mydataHoDk, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoDk$condition[c(15,5)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_2h.ctr_dk_2h.csv",quote = FALSE)

# compare inf_dk_4h with ctr_dk_4h, select differentially expressed genes, and save
print("Comparing inf_dk_4h with ctr_dk_4h...")
mynoiseqHo = noiseqbio(mydataHoDk, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoDk$condition[c(17,7)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_4h.ctr_dk_4h.csv",quote = FALSE)

# compare inf_dk_8h with ctr_dk_8h, select differentially expressed genes, and save
print("Comparing inf_dk_8h with ctr_dk_8h...")
mynoiseqHo = noiseqbio(mydataHoDk, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsHoDk$condition[c(19,9)], lc = 1, r = 50, adj = 1.5, nclust = 15, plot = FALSE, a0per = 0.9, random.seed = 12345, filter = 0, depth = NULL, cv.cutoff = NULL, cpm = NULL)
mynoiseqHo.deg = degenes(mynoiseqHo, q = 0.95, M = NULL)
mynoiseqHo.deg1 = degenes(mynoiseqHo, q = 0.95, M = "up")
mynoiseqHo.deg2 = degenes(mynoiseqHo, q = 0.95, M = "down")
write.csv(mynoiseqHo.deg,file="mynoiseqHo.updn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg1,file="mynoiseqHo.up.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo.deg2,file="mynoiseqHo.dn.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqHo@results[[1]],file="mynoiseqHo.all.inf_dk_8h.ctr_dk_8h.csv",quote = FALSE)

