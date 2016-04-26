#!/bin/bash

#replace "SEQHEADER" with the first 4 characters of your sequence name including the @
#replace "DELIMITER" with the specific delimiter from your fastq file, 
#see the two examples below:
#@HWI-ST141_0363:2:1101:1175:2080#ATCACG/1
#@HWI-ST1117:83:D0TKCACXX:6:1101:1274:2051 2:N:0:TAGCTT

#SEQHEADER would be "@HWI" for both examples, DELIMITER would be a "/" in the first case and
#a " " (space) in the second. Both SEQHEADER and DELIMITER need to be in "", while the filenames
#do not.

#Then copy the following line as many times as the number of paired end lanes that you have, then
#replace YOURFILE#1_1_trimmed_clipped.fastq with the name of your forward direction .fastq file
#replace YOURFILE#1_2_trimmed_clipped.fastq with the name of your reverse direction .fastq file 
#for that same sample.

fastqcombinepairedend.py "SEQHEADER" "DELIMITER" YOURFILE#1_1_trimmed_clipped.fastq YOURFILE#1_2_trimmed_clipped.fastq
