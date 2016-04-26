#!/usr/bin/python

import pandas as pd
from sys import argv

path = argv[1] # '~/krse2011/db/krse2011_v5_graftm_read1_norm.csv'
startcol = int(argv[2]) # 17 # counting from zero

df = pd.read_csv(path)
print 'first column: %s' % df.columns[startcol]
print df.iloc[:,startcol:].sum(axis=1)

