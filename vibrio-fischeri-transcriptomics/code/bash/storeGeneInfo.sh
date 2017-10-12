# description list: VfES114_fixed.CDS.tsv
perl -lne '@e = split /\t/; $bp = $e[4]-$e[3]+1; $e[8] =~ s/gene_id=([a-z0-9]*);.*product=([^;]*);.*/$1\t$bp\t$2/; print $e[8]' VfES114_fixed.CDS.gff > VfES114_fixed.CDS.tsv

# gene name list: VfES114_fixed_cds_gene_VF.tsv
cat VfES114_fixed.gff | grep "Parent=" | perl -lne '@F = split /\t/; @G = split(/;/, $F[8]); print "$G[0],$G[2]"' | perl -lpe 's/(gene_id=[cp].)(cds[0-9]+),Parent=(gene[0-9]+)/$1$2\t$1$3/' > list1.tsv
cat VfES114_fixed.gff | grep ";locus_tag=" | perl -lne '@F = split /\t/; $f = $F[8]; $f =~ s/(gene_id=[a-z0-9]*);.*;(locus_tag=VF_[A-Z0-9]{4,5}).*/$1\t$2/; print $f' > list2.tsv
hashLookup_tsv.pl list1.tsv list2.tsv 1 0 1 | grep "locus_tag" | sed 's/gene_id=//g' | sed 's/locus_tag=//g' > VfES114_fixed_cds_gene_VF.tsv

# gene name list with descriptions: VfES114_fixed_cds_gene_VF_descr.tsv
hashLookup_tsv.pl VfES114_fixed_cds_gene_VF.tsv VfES114_fixed.CDS.tsv 0 0 2 > VfES114_fixed_cds_gene_VF_descr.tsv
