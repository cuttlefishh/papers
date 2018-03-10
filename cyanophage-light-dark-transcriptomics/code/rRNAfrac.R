# read in counts file
countsTable <- read.delim("med4phm2_all_R.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "")

# pull out SSU and LSU counts and sum (have to do like this otherwise vectors are non-numeric!)
ssu <- c(countsTable[347,1], countsTable[347,2], countsTable[347,3], countsTable[347,4], countsTable[347,5], countsTable[347,6], countsTable[347,7], countsTable[347,8], countsTable[347,9], countsTable[347,10], countsTable[347,11], countsTable[347,12], countsTable[347,13], countsTable[347,14], countsTable[347,15], countsTable[347,16], countsTable[347,17], countsTable[347,18], countsTable[347,19], countsTable[347,20], countsTable[347,21], countsTable[347,22], countsTable[347,23], countsTable[347,24], countsTable[347,25], countsTable[347,26], countsTable[347,27], countsTable[347,28], countsTable[347,29], countsTable[347,30], countsTable[347,31], countsTable[347,32], countsTable[347,33], countsTable[347,34], countsTable[347,35], countsTable[347,36], countsTable[347,37], countsTable[347,38], countsTable[347,39], countsTable[347,40])
lsu  <- c(countsTable[350,1], countsTable[350,2], countsTable[350,3], countsTable[350,4], countsTable[350,5], countsTable[350,6], countsTable[350,7], countsTable[350,8], countsTable[350,9], countsTable[350,10], countsTable[350,11], countsTable[350,12], countsTable[350,13], countsTable[350,14], countsTable[350,15], countsTable[350,16], countsTable[350,17], countsTable[350,18], countsTable[350,19], countsTable[350,20], countsTable[350,21], countsTable[350,22], countsTable[350,23], countsTable[350,24], countsTable[350,25], countsTable[350,26], countsTable[350,27], countsTable[350,28], countsTable[350,29], countsTable[350,30], countsTable[350,31], countsTable[350,32], countsTable[350,33], countsTable[350,34], countsTable[350,35], countsTable[350,36], countsTable[350,37], countsTable[350,38], countsTable[350,39], countsTable[350,40])
sums <- colSums(countsTable)
 
# calculate fraction of counts that are SSU and LSU
fracSSU = ssu/sums
fracLSU = lsu/sums

# plot histograms of fracSSU and fracLSU
quartz()
hist(fracSSU)
quartz()
hist(fracLSU)

# Most rRNA-contaminated libraries are (in order):
# Ctr2_Lt_0h
# Inf1_Dk_0h
# Inf2_Dk_0h
# Inf1_Lt_0h
# Inf2_Lt_0h
