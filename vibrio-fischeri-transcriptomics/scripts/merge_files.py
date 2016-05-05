#!/usr/bin/env python

# This script will merge multiple files into one, which is printed lin by line to std out
# If header is 'T', it will omit the first line from all files except the first file

import sys

def merge_files(files, header='T'):
    filecount=0
    for file in files:
        filecount+=1
        fin = open(file, 'r')
        
        if filecount>1 and header=='T':
            linecount=0
            for line in fin.xreadlines():
                linecount+=1
                if linecount > 1: print line.rstrip()
        else:
            for line in fin.xreadlines(): print line.rstrip()

merge_files(sys.argv[1:])