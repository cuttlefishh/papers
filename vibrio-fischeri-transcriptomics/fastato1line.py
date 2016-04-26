#!/usr/bin/env python

import sys
#Opens an infile specified by the user. Should be a list of the blast hits, each name on a new line
#HITS = open(sys.argv[1], 'r')

#Opens a fasta file with the database sequences as specified by user. Must be non-interleaved.
DBSEQS = open(sys.argv[1], 'r')

#Opens an output text file as specified by user
OUT = open(sys.argv[2], 'w')

status=0
#matches=[]

#for match in HITS:

#	match = match.rstrip()
#	matches.append(match)

#print matches
OUT.write('ContigName' + '\t' + 'Sequence')
for line in DBSEQS:

	line=line.rstrip()
	if line[0] == '>':
	
#		if line[1:] in matches:
		OUT.write('\n' + str(line[1:]) + '\t')
		status = 1
	else:
		if status ==1:
			OUT.write(str(line))
			