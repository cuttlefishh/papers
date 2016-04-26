#!/bin/bash

#Usage: bwa_align.sh <Read file> <Reference file>
#BWA must be in your PATH
#Goal: Aligns a FASTQ-formatted set of reads against a fasta-formatted genome reference file

#Check if the reference genome has been indexed; index it if not
if [ ! -f ${2}.bwt ]
then
    echo "Building index of reference sequence..."
    bwa index -a is $2
fi

#  run bwa alignment...

echo "Aligning reads..."

ref=`basename ${2}`
seq=`basename ${1}`

bwa aln $2 $1 > aln_sa.sai
bwa samse $2 aln_sa.sai $1 > ${seq%.*}_v_${ref%.*}.sam

rm aln_sa.sai

echo "Done"
