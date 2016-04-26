#!/bin/bash
#This script is a multi-script that quality trims and then clips adapter seqs from .fastq files

#Quality trimming:
#Quality score cutoff 20, then remove any sequences that are shorter than 20 bases after trimming.

#Copy the following line as many times as the number of samples you are analyzing, then
#replace "YOURFILE" with the names of your samples e.g. "1_Hot":

fastq_quality_trimmer -v -t 20 -l 20 -i YOURFILE.fastq -o YOURFILE_trimmed.fastq


#Adapter clipping:
#Matches to potential adapter sequences at the end of reads, then removes reads shorter than 20 bases. 

#For the next step, copy the line as many times as the number of samples, then 
#add the sequences of your adapters after the -a flag (e.g. -a ATTGGCTTTGGGCAT), as well as changing the sample names:
#The sequences of Illumina's TruSeq adapters are proprietary information, but can be recieved by emailing Illumina customer support at info@illumina.com 

fastx_clipper -a ADAPTER_SEQUENCE -l 20 -n -v -i YOURFILE_trimmed.fastq -o YOURFILE_trimmed_clipped.fastq