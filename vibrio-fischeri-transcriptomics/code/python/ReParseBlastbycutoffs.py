#!/usr/bin/env python

import sys
filecount=0
#ReParseBlastbycutoffs by DJ Barshis
#Usage ReParseBlastbycutoffs.py outfilename.txt columntoparse evaluethreshold blastoutputfile

OUT=open(sys.argv[1],'w')  # open a new output file
columntoparse=int(sys.argv[2])
evalue = float(sys.argv[3]) # for parsing based on evalue threshold
Blasts = sys.argv[4:]             # Any number of blast files for the same query seqs

all=[]
contig=''

for file in Blasts:
	BLAST=open(file, 'r')
	linenum=0
	goodhits=0
	uniques={}
	filecount += 1
	for line in BLAST:
		line=line.rstrip()
		linenum+=1
		if linenum == 1:
		
			OUT.write(line)	#Used to copy header to new files
	
		if linenum>1:	#Just used to skip past the header row

			cols=line.split('\t')
			
			if cols[0] == contig:
				continue
			else: 
				if float(cols[columntoparse]) <= evalue: #for parsing based on evalue threshold
					OUT.write('\n'+line)    #Will be for outputting to a new parsed file
					goodhits = goodhits + 1
					contig = cols[0]
					if uniques.has_key(cols[1]) :
						continue
					else:
						uniques[cols[1]]=''
			

	print "Number of Good Hits", " ", goodhits
	print "Number of unique matches: " + str(len(uniques.keys()))

