#!/usr/bin/env python

import sys
filecount=0
#Usage GOcollapser.py Final_AGbaseresults.txt ParsedBlastx2Uniprot.txt GOTable.txt

INFILE = open(sys.argv[1], 'r') #opens an input file with concatenated AGBaseoutput
contignames = sys.argv[2] #an input file with the gene names and uniprot ID's
OUT=open(sys.argv[3],'w')  # open a new output file with the collapsed GO Id's in the format necessary for ErmineJ enrichment analyses

def make_dict1(file):
	fin = open(file, 'r')
	dict={}
	count=0
	for line in fin:
		count+=1
		line=line.rstrip()
		cols=line.split('\t') #for tab-delimited text files
		if count==1:
			headers=cols[0:]
			#count+=1
		if count > 1:
			dict[cols[0]]=cols[1]
	
	return dict, headers

dictnames, namesheaders=make_dict1(contignames)



GOdict={}
name=''
linenum=0
for line in INFILE:
	linenum+=1
	line=line.rstrip()
	if linenum == 1:
#		OUT.write(line)	#Used to copy header to new files
		linenum+=1
#		print 'hi'
	if linenum>1:	#Just used to skip past the header row
		cols=line.split('\t')
		if GOdict.has_key(cols[2]):
#			print 'repeat'
			if cols[5] in GOdict[cols[2]]:
				continue
			else:
				GOdict[cols[2]].append(cols[5])
		else:
			GOdict[cols[2]]=[]
			GOdict[cols[2]].append(cols[5])
#			print 'added'

OUT.write('GeneName'+ '\t'+ 'GeneName'+ '\t' + 'GOterms'+'\n')
l=[]
nogo=0
for key,value in dictnames.items():
	num=int(key[6:])
	if GOdict.has_key(value):
		l.append((num,key,GOdict[value]))   #translates dictnames into a tuple and adds just the contig # (minus"contig") as the first item
	else:
#		l.append((num,key,['Nogo']))
		nogo+=1
l.sort() #sorts tuple into numeric order
print 'Contigs with no GO annotation: ' + str(nogo)
for item in l:
#	print item
	OUT.write(str(item[1])+'\t'+str(item[1])+'\t'+','.join(item[2])+'\n') #writes each line of the tuple as separate tab delimited text

OUT.close()
