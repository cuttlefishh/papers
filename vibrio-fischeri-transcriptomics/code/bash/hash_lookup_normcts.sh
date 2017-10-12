echo -n "CDS_number" > temp
cat CPM.all.Plk.Swt.Vnt.csv | perl -lpe 's/,/\t/g' >> temp
perl ~/scripts/myscripts/hashLookup_tsv.pl temp ../genome/VfES114_fixed_cds_gene_VF.tsv 0 0 2 | perl -lne 'if ($. == 1) { print "$_\tVF_number" } else { print "$_" }' | sed 's/Gene_number/CDS_number/' | perl -alne '@F = split /\t/; $vf = pop(@F); $rest = join("\t",@F); print "$vf\t$rest"' > CPM.all.Plk.Swt.Vnt.tsv
(head -n 1 CPM.all.Plk.Swt.Vnt.tsv && tail -n +2 CPM.all.Plk.Swt.Vnt.tsv | sort) > temp
perl ~/scripts/myscripts/hashLookup_tsv.pl temp ../genome/VfES114_fixed.CDS.tsv 1 0 2 | perl -lne 'if ($. == 1) { print "VF_number\tCDS_number\tPlk1\tPlk2\tPlk3\tSwt1\tSwt2\tSwt3\tVnt1\tVnt2\tVnt3\tDescription" } else { print "$_" }' > CPM.all.Plk.Swt.Vnt.descr.tsv
mv temp CPM.all.Plk.Swt.Vnt.tsv
