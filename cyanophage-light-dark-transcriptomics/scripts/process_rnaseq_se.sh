#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq
#$ -o rnaseq.out

if [ ! -n "$4" ]
then
    echo "Usage: `basename $0` <illumina read file> <barcode file> <reference sequence> <dir of GFF annotations>"
    exit
fi

source /home/chisholm/rnaseq/bashrc

scriptdir="/home/chisholm/rnaseq"

seqfile=$1
barcodes=$2
db=$3
gffdir=$4

echo "Beginning barcode splitting..."

if [ ! -d "results" ]; then
    mkdir results
fi

#Step 1: Split barcodes; this is a single-processor job for now
${scriptdir}/sortIlluminaByBarcode.pl ${barcodes} ${seqfile}

echo "Barcode splitting complete"

#Step 2: QC; Align the reads to a reference... start farming out the jobs at this point

echo "Indexing reference file"

${scriptdir}/bwa index -a is ${db}

barcode=($(find . -maxdepth 1 -mindepth 1 -type d))

#don't include the NC or results directories

for ((i=0;i<${#barcode[@]};i++))
do
#    echo "i is $i"
    x=${barcode[$i]}
    if [ $x = "./NC" ] 
	then 
	barcode=(${barcode[@]:0:$i} ${barcode[@]:$(($i+1))})
	i=$(($i-1))
    fi
    if [ $x = "./results" ]
	then 
	barcode=(${barcode[@]:0:$i} ${barcode[@]:$(($i+1))})
	i=$(($i-1))
    fi
done

echo "Submitting alignment jobs to the cluster"

/opt/gridengine/bin/lx26-amd64/qsub -t 1:${#barcode[@]} ${scriptdir}/align_se_cluster.sh ${seqfile} ${db} ${gffdir}






