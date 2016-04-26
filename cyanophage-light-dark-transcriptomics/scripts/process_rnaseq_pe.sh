#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq
#$ -o rnaseq.out

if [ ! -n "$5" ]
then
    echo "Usage: `basename $0` <F illumina read file> <R illumina read file> <barcode file> <reference sequence> <dir of GFF annotations>"
    exit
fi

source /home/chisholm/rnaseq/bashrc

scriptdir="/home/chisholm/rnaseq"

seqfile=$1
seqfileR=$2
barcodes=$3
db=$4
gffdir=$5

echo "Submit barcode splitting..."

if [ ! -d "results" ]; then
    mkdir results
fi

#Step 1: Split barcodes; this is a single-processor job for now
jid=`/opt/gridengine/bin/lx26-amd64/qsub -terse -t 1:2 ${scriptdir}/split_pair_barcodes.sh ${1} ${2} ${3}`

#Step 2: QC; Align the reads to a reference... start farming out the jobs at this point

#qsub -hold_jid ${jid} ${scriptdir}/process_rnaseq_pe_part2.sh ${1} ${2} ${3} ${4} ${5}
/opt/gridengine/bin/lx26-amd64/qsub -hold_jid barcodesplit ${scriptdir}/process_rnaseq_pe_part2.sh ${1} ${2} ${4} ${5}





