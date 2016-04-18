# call noiseq library
library("NOISeq")

# read in counts file
countsTable <- read.delim("med4phm2_all_R.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "")

# split counts into host and phage counts
countsTableHo <- countsTable[1:2015,]
countsTablePh <- countsTable[2016:2257,]

# store noiseq factors as data.frame/matrix
myfactorsPh <- data.frame(row.names = colnames(countsTablePh), condition = c("ctr_lt_0h","ctr_lt_0h","ctr_lt_1h","ctr_lt_1h","ctr_lt_2h","ctr_lt_2h","ctr_lt_4h","ctr_lt_4h","ctr_lt_8h","ctr_lt_8h","ctr_dk_0h","ctr_dk_0h","ctr_dk_1h","ctr_dk_1h","ctr_dk_2h","ctr_dk_2h","ctr_dk_4h","ctr_dk_4h","ctr_dk_8h","ctr_dk_8h","inf_lt_0h","inf_lt_0h","inf_lt_1h","inf_lt_1h","inf_lt_2h","inf_lt_2h","inf_lt_4h","inf_lt_4h","inf_lt_8h","inf_lt_8h","inf_dk_0h","inf_dk_0h","inf_dk_1h","inf_dk_1h","inf_dk_2h","inf_dk_2h","inf_dk_4h","inf_dk_4h","inf_dk_8h","inf_dk_8h"), infection = c("control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected"), lightness = c("light","light","light","light","light","light","light","light","light","light","dark","dark","dark","dark","dark","dark","dark","dark","dark","dark","light","light","light","light","light","light","light","light","light","light","dark","dark","dark","dark","dark","dark","dark","dark","dark","dark"), timepoint = c("0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h"))

# read in metadata file
metadataPh <- read.delim("AAAAAA_Ph.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")

# store noiseq length as vector
mylengthPh <- metadataPh$EndCoordinate-metadataPh$StartCoordinate+1
names(mylengthPh) <- rownames(countsTablePh)

# store noiseq chroms as data.frame/matrix
mychromsPh <- data.frame(row.names = rownames(countsTablePh), chr = metadataPh$Chromosome, geneStart = metadataPh$StartCoordinate, geneEnd = metadataPh$EndCoordinate)

# read in protein/rna file
protOrRnaPh <- read.delim("protOrRna_Ph.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")

# store noiseq biotypes as vector
mybiotypesPh <- protOrRnaPh$Chromosome
names(mybiotypesPh) = rownames(countsTablePh)

# store noiseq data structure
mydataPh <- readData(data = countsTablePh, length = mylengthPh, biotype = mybiotypesPh, chromosome = mychromsPh, factors = myfactorsPh)

##### INF_LT vs INF_DK #####
# compare inf_lt_0h with inf_dk_0h, select differentially expressed genes, and save
print("Comparing inf_lt_0h with inf_dk_0h...")
mynoiseqPh = noiseq(mydataPh, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsPh$condition[c(21,31)], nss = 0, lc = 1, replicates = "biological")
mynoiseqPh.deg = degenes(mynoiseqPh, q = 0.8, M = NULL)
mynoiseqPh.deg1 = degenes(mynoiseqPh, q = 0.8, M = "up")
mynoiseqPh.deg2 = degenes(mynoiseqPh, q = 0.8, M = "down")
write.csv(mynoiseqPh.deg,file="mynoiseqPh.updn.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg1,file="mynoiseqPh.up.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg2,file="mynoiseqPh.dn.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)
write.csv(mynoiseqPh@results[[1]],file="mynoiseqPh.all.inf_lt_0h.inf_dk_0h.csv",quote = FALSE)

# compare inf_lt_1h with inf_dk_1h, select differentially expressed genes, and save
print("Comparing inf_lt_1h with inf_dk_1h...")
mynoiseqPh = noiseq(mydataPh, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsPh$condition[c(23,33)], nss = 0, lc = 1, replicates = "biological")
mynoiseqPh.deg = degenes(mynoiseqPh, q = 0.8, M = NULL)
mynoiseqPh.deg1 = degenes(mynoiseqPh, q = 0.8, M = "up")
mynoiseqPh.deg2 = degenes(mynoiseqPh, q = 0.8, M = "down")
write.csv(mynoiseqPh.deg,file="mynoiseqPh.updn.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg1,file="mynoiseqPh.up.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg2,file="mynoiseqPh.dn.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)
write.csv(mynoiseqPh@results[[1]],file="mynoiseqPh.all.inf_lt_1h.inf_dk_1h.csv",quote = FALSE)

# compare inf_lt_2h with inf_dk_2h, select differentially expressed genes, and save
print("Comparing inf_lt_2h with inf_dk_2h...")
mynoiseqPh = noiseq(mydataPh, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsPh$condition[c(25,35)], nss = 0, lc = 1, replicates = "biological")
mynoiseqPh.deg = degenes(mynoiseqPh, q = 0.8, M = NULL)
mynoiseqPh.deg1 = degenes(mynoiseqPh, q = 0.8, M = "up")
mynoiseqPh.deg2 = degenes(mynoiseqPh, q = 0.8, M = "down")
write.csv(mynoiseqPh.deg,file="mynoiseqPh.updn.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg1,file="mynoiseqPh.up.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg2,file="mynoiseqPh.dn.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)
write.csv(mynoiseqPh@results[[1]],file="mynoiseqPh.all.inf_lt_2h.inf_dk_2h.csv",quote = FALSE)

# compare inf_lt_4h with inf_dk_4h, select differentially expressed genes, and save
print("Comparing inf_lt_4h with inf_dk_4h...")
mynoiseqPh = noiseq(mydataPh, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsPh$condition[c(27,37)], nss = 0, lc = 1, replicates = "biological")
mynoiseqPh.deg = degenes(mynoiseqPh, q = 0.8, M = NULL)
mynoiseqPh.deg1 = degenes(mynoiseqPh, q = 0.8, M = "up")
mynoiseqPh.deg2 = degenes(mynoiseqPh, q = 0.8, M = "down")
write.csv(mynoiseqPh.deg,file="mynoiseqPh.updn.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg1,file="mynoiseqPh.up.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg2,file="mynoiseqPh.dn.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)
write.csv(mynoiseqPh@results[[1]],file="mynoiseqPh.all.inf_lt_4h.inf_dk_4h.csv",quote = FALSE)

# compare inf_lt_8h with inf_dk_8h, select differentially expressed genes, and save
print("Comparing inf_lt_8h with inf_dk_8h...")
mynoiseqPh = noiseq(mydataPh, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactorsPh$condition[c(29,39)], nss = 0, lc = 1, replicates = "biological")
mynoiseqPh.deg = degenes(mynoiseqPh, q = 0.8, M = NULL)
mynoiseqPh.deg1 = degenes(mynoiseqPh, q = 0.8, M = "up")
mynoiseqPh.deg2 = degenes(mynoiseqPh, q = 0.8, M = "down")
write.csv(mynoiseqPh.deg,file="mynoiseqPh.updn.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg1,file="mynoiseqPh.up.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqPh.deg2,file="mynoiseqPh.dn.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)
write.csv(mynoiseqPh@results[[1]],file="mynoiseqPh.all.inf_lt_8h.inf_dk_8h.csv",quote = FALSE)

