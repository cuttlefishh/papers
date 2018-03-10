#!/usr/bin/env python

#Goal is to merge the output of many RNAseq parsed output files into one table for easier handling by Excel, R, etc
#usage: mergefiles.py "*.txt" (or any other wildcard delimiter of your choosing... needs the quotes)
#or: mergefiles.py file1 file2 file3 ... filen

import glob,sys
from operator import itemgetter

handle=sys.argv[1]
if len(sys.argv) < 3:
    #assume a wildcard in quotes
    wildcard=str(handle)
    files=glob.glob(wildcard)
else:
    #assume a list of files
    files=sys.argv[1:]

#print "files is " + str(files)

info={}
counts={}

numfiles=len(files)

for i in range(0,numfiles):
    infile=open(files[i],"rU")

    for line in infile:
        parts = line.split("\t")

        if parts[0]=='Chromosome':
            next
        else:
        
            thisorf = parts[1].strip()
            thiscount = parts[6].strip()
    
            if thisorf in info:
                counts[thisorf][i]=thiscount
            else:
                infoline="\t".join(parts[j] for j in range (0,6))
                info[thisorf]=infoline
                counts[thisorf]=['NA']*numfiles
                counts[thisorf][i]=thiscount
    infile.close()
    


print "Chromosome\tRegion\tStrand\tStartCoordinate\tEndCoordinate\tName",

for i in range(0,numfiles):
    print "\t"+str(files[i].strip().split('.')[0]),

print "\n",

def mykey(item):
    line=info[item]
    parts=line.split("\t")
    return int(parts[3])

allclusters=sorted(info,key=mykey)

for key in allclusters:
    allcounts="\t".join(str(counts[key][i]) for i in range(0,numfiles))
    print str(info[key]) +"\t"+ allcounts
    


