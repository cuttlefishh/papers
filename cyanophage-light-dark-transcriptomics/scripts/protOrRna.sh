# print "peg" if protein-encoding gene or "rna" if ncRNA, first parsing MED4 names, then special cases of MED4, then PHM2 names
# leave header row in place; it's not a problem for R
cat AAAAAA.txt | perl -pi -e 's/(MED4|PHM2)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)/$2/' | perl -pi -e 's/.*(peg|rna).*/$1/' | perl -pi -e 's/(.*p01)/peg/' > protOrRna.txt
cat AAAAAA_Ho.txt | perl -pi -e 's/(MED4|PHM2)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)/$2/' | perl -pi -e 's/.*(peg|rna).*/$1/' | perl -pi -e 's/(.*p01)/peg/' > protOrRna_Ho.txt
cat AAAAAA_Ph.txt | perl -pi -e 's/(MED4|PHM2)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)/$2/' | perl -pi -e 's/.*(peg|rna).*/$1/' | perl -pi -e 's/(.*p01)/peg/' > protOrRna_Ph.txt
