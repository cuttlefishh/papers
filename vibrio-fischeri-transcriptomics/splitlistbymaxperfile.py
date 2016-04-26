#! /usr/bin/env python
import sys
#Usage this file takes a file of entries and splits it into equal parts consisting of X number of entries
#splitlistbymaxperfile.py infile #ofentriestosplitby Outfileprefixname_

# Extracts data from a file and returns a list with the names
def read_file(file):
	fin = open(file, 'r')
	count=0
	
	names=[]
	for line in fin:
		line=line.strip()
		names.append(line)
	return names

def splitfile(maxperfile, names):
	indices=[]
	second=maxperfile
	first=0
	while True:
		indices.append([first, second])
		first+=maxperfile
		second+=maxperfile
		if second > len(names):
			second=len(names)
			indices.append([first, second])
			break
	count=1
	
	for i in indices:
		sub_names=names[i[0]:i[1]]
		o=open(str(sys.argv[3]) + str(count) + '-' + str(count+(int(maxperfile)-1)) + '.txt', 'w')
		count+=int(maxperfile)
		for j in range(len(sub_names)):
			o.write(sub_names[j] + '\n')
		o.close()

names=read_file(sys.argv[1])

splitfile(int(sys.argv[2]), names)