# call noiseq library
library("NOISeq")

# read in counts file
countsTable <- read.delim("med4phm2_all_R.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "")

# store noiseq factors as data.frame/matrix
myfactors <- data.frame(row.names = colnames(countsTable), condition = c("ctr_lt_0h","ctr_lt_0h","ctr_lt_1h","ctr_lt_1h","ctr_lt_2h","ctr_lt_2h","ctr_lt_4h","ctr_lt_4h","ctr_lt_8h","ctr_lt_8h","ctr_dk_0h","ctr_dk_0h","ctr_dk_1h","ctr_dk_1h","ctr_dk_2h","ctr_dk_2h","ctr_dk_4h","ctr_dk_4h","ctr_dk_8h","ctr_dk_8h","inf_lt_0h","inf_lt_0h","inf_lt_1h","inf_lt_1h","inf_lt_2h","inf_lt_2h","inf_lt_4h","inf_lt_4h","inf_lt_8h","inf_lt_8h","inf_dk_0h","inf_dk_0h","inf_dk_1h","inf_dk_1h","inf_dk_2h","inf_dk_2h","inf_dk_4h","inf_dk_4h","inf_dk_8h","inf_dk_8h"), infection = c("control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","control","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected","infected"), lightness = c("light","light","light","light","light","light","light","light","light","light","dark","dark","dark","dark","dark","dark","dark","dark","dark","dark","light","light","light","light","light","light","light","light","light","light","dark","dark","dark","dark","dark","dark","dark","dark","dark","dark"), timepoint = c("0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h","0h","0h","1h","1h","2h","2h","4h","4h","8h","8h"))

# read in metadata file
metadata <- read.delim("AAAAAA.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")

# store noiseq length as vector
mylength <- metadata$EndCoordinate-metadata$StartCoordinate+1
names(mylength) <- rownames(countsTable)

# store noiseq chroms as data.frame/matrix
mychroms <- data.frame(row.names = rownames(countsTable), chr = metadata$Chromosome, geneStart = metadata$StartCoordinate, geneEnd = metadata$EndCoordinate)

# read in protein/rna file
protOrRna <- read.delim("protOrRna.txt", header = TRUE, stringsAsFactors = TRUE, sep = "\t", quote = "")

# store noiseq biotypes as vector
mybiotypes <- protOrRna$Chromosome
names(mybiotypes) = rownames(countsTable)

# store noiseq data structure
mydata <- readData(data = countsTable, length = mylength, biotype = mybiotypes, chromosome = mychroms, factors = myfactors)

# compare ctr_lt_8h with inf_lt_8h
mynoiseq = noiseq(mydata, k = 0.5, norm = "rpkm", factor = "condition", conditions = myfactors$condition[c(10,30)],  pnr = 0.2, nss = 5, v = 0.02, lc = 1, replicates = "biological")

