#!/bin/bash
#$ -j y
#$ -cwd
#$ -N rnaseq_processing
#$ -o rnaseq.out

if [ ! -n "$3" ]
then
    echo "Usage: `basename $0` <illumina read file> <reference sequence> <dir of GFF annotations>"
    exit $E_BADARGS
fi

#load proper modules
source /home/chisholm/rnaseq/bashrc
scriptdir="/home/chisholm/rnaseq"
export PATH=${PATH}:${scriptdir}
export PYTHONPATH=/home/chisholm/lib/

seqfile=$1
db=$2
gffdir=$3

barcode=($(find . -maxdepth 1 -mindepth 1 -type d))

#don't include the NC or results directoriesi=0
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



#echo "array is" ${barcode[@]}
dirname=${barcode[$((SGE_TASK_ID-1))]}

echo -e "Procesing ${dirname} at id $((SGE_TASK_ID-1))"
cd ${dirname}

# /home/software/clc-assembly-cell/clc-assembly-cell-3.2.0/bin/quality_trim -m 30 -r ${seqfile} -o ${seqfile}_trimmed.fastq
# ${scriptdir}/bwa aln ${db} ${seqfile}_trimmed.fastq > aln_sa_f.sai
# ${scriptdir}/bwa samse ${db} aln_sa_f.sai ${seqfile}_trimmed.fastq > aln_se.sam

${scriptdir}/bwa aln ${db} ${seqfile} > aln_sa_f.sai

${scriptdir}/bwa samse ${db} aln_sa_f.sai ${seqfile} > aln_se.sam

rm aln_sa_f.sai

myname=`basename $dirname`

${scriptdir}/RNAseq_parser_gff_directional.py -i aln_se.sam -o ../results/${myname}.txt -d ${gffdir} > ${myname}_output.txt

echo $myname >> ../results/parser_stats.txt
cat ${myname}_output.txt >> ../results/parser_stats.txt








