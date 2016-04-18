#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq
#$ -o rnaseq.out

if [ ! -n "$3" ]
then
    echo "Usage: `basename $0` <illumina read file> <reference sequence> <dir of GFF annotations>"
    exit
fi

source /home/chisholm/rnaseq/bashrc

scriptdir="/home/chisholm/rnaseq"

seqfile=$1
db=$2
gffdir=$3

if [ ! -d "results" ]; then
    mkdir results
fi

#Step 1: QC; Align the reads to a reference... start farming out the jobs at this point

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






