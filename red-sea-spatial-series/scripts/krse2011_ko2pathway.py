# krse2011_ko2pathway.py

from sys import argv
import re
import numpy as np
import pandas as pd
from cogent.parse import kegg_ko
from collections import Counter
from collections import OrderedDict
import csv


# Set Paths and Variables

path_goi = argv[1] #'/Users/luke/krse2011/ordination/CCA_genes_loadings_goi_CAP_CCA_clean.tsv'
path_ko  = argv[2] #'/Users/luke/kegg/ko'
path_out = argv[3] #'/Users/luke/krse2011/ordination/annotated/CCA_top_pathways_by_KO.csv'


top_level2 = int(argv[4]) #15
top_level1 = int(argv[5]) #15
num_cutoff = int(argv[6]) #5


# Get KO Numbers from Table of CCA Loadings

# list of KO numbers from table
ko_list = []

# regular expression matching KO number
regex_ko = re.compile(r'K[0-9]{5}')


# go through each line and add any matching strings to list
for line in open(path_goi).readlines():
    ko_list.append(regex_ko.findall(line))

# dataframe to series to get unique KO numbers, remove first 'None' value (neither should be necessary)
df = pd.DataFrame(ko_list)
ko_unique = pd.Series(df.values.ravel()).unique()[1:]


# Parse KEGG KO Record

kdata = kegg_ko.parse_ko(open(path_ko))


klist = list(kdata)


# Make Dictionary of My Chosen KOs and Their Pathways

# generate list of lists, with each entry having [KO, all pathway hierarchy], removing pathways named BR:koXXXXX and None
mykpath = []
regex_BR = re.compile(r'BR:ko')
for record in klist:
    for ko in ko_unique:
        if ko == record['ENTRY']:
            filtered = []
            filtered = [i for i in record['CLASS'] if i[0] is not None and not regex_BR.search(i[0])]
            #filtered = record['CLASS'] #use this if don't wish to filter BR:ko
            newpath = [record['ENTRY'], filtered]
            mykpath.append(newpath)


# convert list of [KO, all pathway hierarchy] to dictionary, and make a copy for lookup at the end
dict_mykpath = dict(zip([x[0] for x in mykpath], [x[1] for x in mykpath]))
dict_mykpath_copy = dict_mykpath.copy()


# With Chosen KOs (GOIs), Find KOs with Level-2 Pathways Among Top

# extract pathway level-2, count list entries and sort
mykpath2 = []
for ko, paths in dict_mykpath.iteritems():
    for path in paths:
        mykpath2.append(path[1][2])
pathcount2 = Counter(mykpath2)


# get top level-2 pathways, convert to dict, find KOs that contain those pathways
top_pathcount2 = pathcount2.most_common(top_level2)
dict_top_pathcount2 = OrderedDict(zip([x[0] for x in top_pathcount2], [x[1] for x in top_pathcount2]))
ko_level2 = []
for ko, paths in dict_mykpath.iteritems():
    for path in paths:
        if path[1][2] in dict_top_pathcount2:
            ko_level2.append(ko)


# get unique level-2 KOs, as set
ko_level2_unique = list(set(ko_level2))


# remove KOs that match top level-2 pathways
for ko in ko_level2_unique:
    dict_mykpath.pop(ko, None)


# With Remaining KOs, Find KOs with Level-1 Pathways Among Top

# extract pathway level-1, count list entries and sort
mykpath1 = []
for ko, paths in dict_mykpath.iteritems():
    for path in paths:
        mykpath1.append(path[1][1])
pathcount1 = Counter(mykpath1)


# get top level-1 pathways, convert to dict, find KOs that contain those pathways
top_pathcount1 = pathcount1.most_common(top_level1)
dict_top_pathcount1 = OrderedDict(zip([x[0] for x in top_pathcount1], [x[1] for x in top_pathcount1]))
ko_level1 = []
for ko, paths in dict_mykpath.iteritems():
    for path in paths:
        if path[1][1] in dict_top_pathcount1:
            ko_level1.append(ko)


# get unique level-1 KOs, as set
ko_level1_unique = list(set(ko_level1))


# remove KOs that match top level-1 pathways
for ko in ko_level1_unique:
    dict_mykpath.pop(ko, None)


# With Remaining KOs, Group as Other

# get list of remaining KOs
ko_other = dict_mykpath.keys()


# Assign KOs to Pathways: Top Level-2, Recycle Unassigned KOs, Top Level-1, then Other

# initialize dictionaries
dict_level2 = OrderedDict(zip(dict_top_pathcount2.keys(), [[] for x in dict_top_pathcount2.keys()]))
dict_level1 = OrderedDict(zip(dict_top_pathcount1.keys(), [[] for x in dict_top_pathcount1.keys()]))
dict_other = OrderedDict()
dict_other['Other'] = []

# level-2 assign highest pathway per KO, then remove pathways with too few counts, but recycle unassigned KOs
ko_bool_level2 = OrderedDict(zip([x for x in ko_level2_unique], [True for x in ko_level2_unique]))
for ko in ko_level2_unique:
    for path, count in dict_top_pathcount2.iteritems():
        if ko_bool_level2[ko]:
            for entry in dict_mykpath_copy[ko]:
                if entry[1][2] == path:
                    dict_level2[path].append(ko)
                    ko_bool_level2[ko] = False
                    break
ko_level1_unique_plus = list(ko_level1_unique)
for key, value in dict_level2.iteritems():
    if len(value) < num_cutoff:
        recycle = dict_level2.pop(key, None)
        if len(recycle) > 0:
            for element in recycle:
                ko_level1_unique_plus.append(element)
                    
# level-1 assign highest pathway per KO, then remove pathways with too few counts
ko_bool_level1 = OrderedDict(zip([x for x in ko_level1_unique_plus], [True for x in ko_level1_unique_plus]))
for ko in ko_level1_unique_plus:
    for path, count in dict_top_pathcount1.iteritems():
        if ko_bool_level1[ko]:
            for entry in dict_mykpath_copy[ko]:
                if entry[1][1] == path:
                    dict_level1[path].append(ko)
                    ko_bool_level1[ko] = False
                    break
ko_other_plus = list(ko_other)
for key, value in dict_level1.iteritems():
    if len(value) < num_cutoff:
        recycle1 = dict_level1.pop(key, None)
        if len(recycle1) > 0:
            for element in recycle1:
                ko_other_plus.append(element)

# other
for ko in ko_other_plus:
    dict_other['Other'].append(ko)
    
# hacky solution for K01488, whose level-2 pathway (Purine metabolism) 
# only has 2 counts but level-1 pathways (Nucleotide Metabolism and 
# Immune System Diseases) are not in my list -- THIS IS A BUG!
dict_other['Other'].append('K01488')

# Combine Dicts of Pathway => KOs and Write to File

# combine 3 dicts into 1
output_dict = OrderedDict(dict_level2.items() + dict_level1.items() + dict_other.items())

# remove commas from pathway names
output_dict2 = OrderedDict()
regex_comma = re.compile(r',')
for key, value in output_dict.iteritems():
    output_dict2[regex_comma.sub('',key)] = value

# write output
writer = csv.writer(open(path_out, 'wb'))
for key, value in output_dict2.items():
   writer.writerow([key, value])



