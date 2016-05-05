#!/bin/bash
#this script is for bwa mapping fastq files to a reference library.

#Indexing reference library:  
bwa index -p ABBREVIATEDREFERENCEFILENAME -a is REFERENCEFILENAME.fasta

# ABBREVIATEDREFERENCEFILENAME will be the abbreviated names for the index files generated (output)
# REFERENCEFILENAME.fasta will be the fasta file generated from your de novo assembly

#Mapping and converting to SAM file format:

#Notice the -I flag that informs bwa that your fastq quality scores are in Illumina format, with an offset of 64.
#If your quality scores have an offset of 33, this flag should be removed.



#For Single End lanes:
#Copy the following line as many times as your number of single-end samples, then replace ABBREVIATEDREFERENCEFILENAME with your abbreviated reference 
#name from above, and SAMPLENAME with your sample name, e.g. "HMS_Cold_1".
bwa aln -n 0.005 -k 5 -I -t 4 ABBREVIATEDREFERENCEFILENAME SAMPLENAME_trimmed_clipped.fastq | bwa samse -r '@RG\tID:SAMPLENAME\tSM:SAMPLENAME\tPL:Illumina' ABBREVIATEDREFERENCEFILENAME - SAMPLENAME_trimmed_clipped.fastq > SAMPLENAME.sam 



#For Paired-End lanes:
# for paired-end lanes there are four lines per set of two paired-end and one remaining singles .fastq files
# so you'll need to copy the following four lines for each set of paired-end files:

#Then replace ABBREVIATEDREFERENCEFILENAME with your abbreviated reference name from above, 
#and SAMPLENAME with your sample name, e.g. "HMS_Cold_1".

bwa aln -n 0.005 -k 5 -I -t 4 ABBREVIATEDREFERENCEFILENAME SAMPLENAME_trimmed_clipped_singles.fastq | bwa samse -r '@RG\tID:SAMPLENAME\tSM:SAMPLENAME\tPL:Illumina' ABBREVIATEDREFERENCEFILENAME - SAMPLENAME_trimmed_clipped_singles.fastq > SAMPLENAME_singles.sam 
bwa aln -n 0.005 -k 5 -I -t 4 ABBREVIATEDREFERENCEFILENAME SAMPLENAME_1_trimmed_clipped_stillpaired.fastq > SAMPLENAME_pairs1.sai
bwa aln -n 0.005 -k 5 -I -t 4 ABBREVIATEDREFERENCEFILENAME SAMPLENAME_2_trimmed_clipped_stillpaired.fastq > SAMPLENAME_pairs2.sai
bwa sampe -a 750 -r '@RG\tID:SAMPLENAME\tSM:SAMPLENAME\tPL:Illumina' -P ABBREVIATEDREFERENCEFILENAME SAMPLENAME_pairs1.sai SAMPLENAME_pairs2.sai SAMPLENAME_1_trimmed_clipped_stillpaired.fastq SAMPLENAME_2_trimmed_clipped_stillpaired.fastq > SAMPLENAME_pairs.sam
