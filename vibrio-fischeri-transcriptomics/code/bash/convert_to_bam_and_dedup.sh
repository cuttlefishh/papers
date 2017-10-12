#!/bin/bash
# This scripts converts SAM files to BAM, sorts the BAM, marks and removes duplicate reads.

#Convert SAM file to .bam | sort .bam with Samtools:
#Copy the following line as many times as the number of samples you are working with, then
#replace "SAMPLENAME" with the names of your samples e.g. "1_Hot":

samtools view -bS SAMPLENAME.sam | samtools sort -m 30000000000 - SAMPLENAME_sorted


#Mark Duplicates with Picard tools:
#Copy the following line as many times as the number of samples you are working with, then
#replace "SAMPLENAME" with the names of your samples e.g. "1_Hot":

java -Xmx2g -jar ~/programs/MarkDuplicates.jar INPUT=SAMPLENAME_sorted.bam OUTPUT=SAMPLENAME_dedup.bam METRICS_FILE=SAMPLENAME_metricsfile MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=250 ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=True
