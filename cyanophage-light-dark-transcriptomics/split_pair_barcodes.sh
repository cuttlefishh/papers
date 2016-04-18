#!/bin/bash
#$ -j y
#$ -cwd
#$ -N barcodesplit
#$ -o barcode.out

if [ ! -n "$2" ]
then
    echo "Usage: `basename $0` <F illumina read file> <R illumina read file> <barcode file>"
    exit
fi

source /home/chisholm/rnaseq/bashrc
scriptdir="/home/chisholm/rnaseq"

allfiles=( $1 $2 )
thisfile=${allfiles[$((SGE_TASK_ID-1))]}
barcodes=$3

echo "Beginning barcode splitting..."

${scriptdir}/sortIlluminaByBarcode.pl ${barcodes} ${thisfile}

echo "Barcode splitting complete"






