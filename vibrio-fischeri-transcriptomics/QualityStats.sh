#!/bin/bash

#This script summarizes the Quality statistics of the reads in a text file, which can then be uploaded to GALAXY for plotting:

#Copy the following line as many times as the number of samples you are working with, then
#replace "YOURFILE" with the names of your samples e.g. "1_Hot":

fastx_quality_stats -i YOURFILE_trimmed_clipped.fastq -o YOURFILE_qualstats.txt
