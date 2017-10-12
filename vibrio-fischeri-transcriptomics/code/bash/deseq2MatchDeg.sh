for i in mydeseq2.sig.Swt.Vnt mydeseq2.sig.Plk.Vnt mydeseq2.sig.Plk.Swt mydeseq2.all.Swt.Vnt mydeseq2.all.Plk.Vnt mydeseq2.all.Plk.Swt
do
    # deseq results with description added (venn ipynb uses this)
    perl ~/scripts/myscripts/deseq2MatchDeg.pl ${i}.csv ../genome/VfES114_fixed.CDS.tsv > ${i}.venn.tsv
    # deseq results prepended with VF numbers (for everything else)
    perl ~/scripts/myscripts/hashLookup_tsv.pl ${i}.venn.tsv ../genome/VfES114_fixed_cds_gene_VF.tsv 0 0 2 | perl -lne 'if ($. == 1) { print "$_\tVF_number" } else { print "$_" }' | sed 's/Gene_number/CDS_number/' | perl -alne '@F = split /\t/; $vf = pop(@F); $rest = join("\t",@F); print "$vf\t$rest"' > ${i}.tsv
done
