#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq_processing
#$ -o rnaseq.out

if [ ! -n "$3" ]
then
    echo "Usage: `basename $0` <illumina read file> <R illumina file> <reference sequence> <dir of GFF annotations>"
    exit $E_BADARGS
fi

#load proper modules
source /home/chisholm/rnaseq/bashrc
scriptdir="/home/chisholm/rnaseq"
export PATH=${PATH}:${scriptdir}
export PYTHONPATH=/home/chisholm/lib/

seqfile=$1
seqfileR=$2
db=$3
gffdir=$4

barcode=($(find . -maxdepth 1 -mindepth 1 -type d))

#don't include the NC or results directories

for ((i=0;i<${#barcode[@]};i++))
do
    echo "i is $i"
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

dirname=${barcode[$((SGE_TASK_ID-1))]}

echo -e "Processing ${dirname} at id $((SGE_TASK_ID-1))"

cd ${dirname}

#The reverse read file needs to have read headers ending in /2 for BWA, not the /3 that the current pipeline now uses to mark reverse reads
sed 's/\/3/\/2/g' -i ${seqfileR}

#For now, skipping trimming.. need to sort out issues with paired reads being unevenly trimmed

#/home/software/clc-assembly-cell/clc-assembly-cell-3.2.0/bin/quality_trim -m 30 -r ${seqfile} -o ${seqfile}_trimmed.fastq
#/home/software/clc-assembly-cell/clc-assembly-cell-3.2.0/bin/quality_trim -m 30 -r ${seqfileR} -o ${seqfileR}_trimmed.fastq

# ${scriptdir}/bwa aln ${db} ${seqfile}_trimmed.fastq > aln_sa_f.sai
# ${scriptdir}/bwa aln ${db} ${seqfileR}_trimmed.fastq > aln_sa_r.sai

${scriptdir}/bwa aln ${db} ${seqfile} > aln_sa_f.sai
${scriptdir}/bwa aln ${db} ${seqfileR} > aln_sa_r.sai

${scriptdir}/bwa sampe ${db} aln_sa_f.sai aln_sa_r.sai ${seqfile} ${seqfileR} > aln_pe.sam

rm aln_sa_f.sai aln_sa_r.sai

myname=`basename $dirname`

${scriptdir}/RNAseq_parser_gff_directional.py -i aln_pe.sam -o ../results/${myname}.txt -d ${gffdir} -p > ${myname}_output.txt

${scriptdir}/RNAseq_getpileup_directional.py -i aln_pe.sam -o ../results/${myname}.pileup > ${myname}_output.txt

rm *.bam *.bai
#for now leave the .sam file so that doesn't have to be remade again





