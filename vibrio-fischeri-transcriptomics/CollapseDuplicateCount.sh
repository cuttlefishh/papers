#!/bin/bash
#This script first collapses the trimmed and clipped fastq files into fasta files with only unique reads, the number of identical reads for each unique in parentheses:

#Copy the following line as many times as the number of samples you are working with, then
#replace "YOURFILE" with the names of your samples e.g. "1_Hot":


fastx_collapser -v -i YOURFILE_trimmed_clipped.fastq -o YOURFILE_collapsed.txt


#------------------------------------------------------------------------------------------------

#Then it counts the number of duplicate reads:

#Copy the following line as many times as the number of samples you are working with, then
#replace "YOURFILE" with the names of your samples e.g. "YOURFILE":

fastqduplicatecounter.py YOURFILE_collapsed.txt YOURFILE_collapsed_headers.txt >> YOURFILE_duplicateCount.txt




#This last line removes the dummy headerfiles, which are no longer necessary.
rm *_collapsed_headers.txt