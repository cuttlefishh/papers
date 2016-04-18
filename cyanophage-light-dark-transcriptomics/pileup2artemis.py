#!/usr/bin/env python

import sys

input=open(sys.argv[1],"rU")

print "#BASE\tForward\tReverse"

for line in input:
    parts=line.split()
    print parts[1]+"\t"+parts[2]+"\t"+parts[3]
