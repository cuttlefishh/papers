#!/bin/bash
#$ -j y
#$ -cwd
#$ -N barcodesplit
#$ -o barcode.out

if [ ! -n "$2" ]
then
    echo "Usage: `basename $0` <illumina read file> <barcode file>"
    exit
fi

source /home/chisholm/rnaseq/bashrc
scriptdir="/home/chisholm/rnaseq"

thisfile=$1
barcodes=$2

echo "Beginning barcode splitting..."

${scriptdir}/sortIlluminaByBarcode.pl ${barcodes} ${thisfile}

echo "Barcode splitting complete"






