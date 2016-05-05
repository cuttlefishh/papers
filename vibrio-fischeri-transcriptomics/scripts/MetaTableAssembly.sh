#!/bin/bash

#this shell script iteratively assembles your meta-table in three steps (these iterative steps are necessary as different columns are appended to the meta table depending on the source files.

#step 1, your .fasta file from your contigs is reformatted to be on a single line
fastato1line.py yourcontigs.fasta yourconitigs_1line.txt

#step 2, the blast2nr and blast2swissprot information is added
ParseData2BigTable.py yourcontigs_1line.txt Yourcontigs_MetaTableBlast.txt columntoextract(column1forblasts) tophitParsedBlastx2nr.txt ParsedBlastx2Swissprot.txt

#step 3, the GO annotation is added at the end
ParseData2BigTable.py Yourcontigs_MetaTableBlast.txt yourcontigs_MetaTable_wGO.txt columntoextract(column2forGOaddition) yourcontigsGOTable.txt

#cleanup step, the intermediate blast table and 1line fasta files are deleted
rm yourcontigs_MetaTableBlast.txt
rm yourcontigs_1line.txt

