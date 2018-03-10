#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq
#$ -o rnaseq.out

if [ ! -n "$4" ]
then
    echo "Usage: `basename $0` <F illumina read file> <R illumina read file> <reference sequence> <dir of GFF annotations>"
    exit
fi

source /home/chisholm/rnaseq/bashrc

scriptdir="/home/chisholm/rnaseq"

seqfile=$1
seqfileR=$2
db=$3
gffdir=$4

#echo "Submit barcode splitting..."

if [ ! -d "results" ]; then
    mkdir results
fi

#Step 1: QC; Align the reads to a reference... start farming out the jobs at this point

/opt/gridengine/bin/lx26-amd64/qsub ${scriptdir}/qinglu/process_rnaseq_pe_part2_qinglu.sh ${1} ${2} ${3} ${4}





