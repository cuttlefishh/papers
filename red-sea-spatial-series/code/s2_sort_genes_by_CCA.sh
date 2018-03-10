for i in CCA_genes_filt3_loadings #CCA_genes_all_loadings CCA_genes_gt1000_loadings CCA_genes_gt20000_loadings CCA_genes_gt50000_loadings
do
	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tMagnitude\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = sqrt($F[1]**2 + $F[2]**2); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_mag.tsv

	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tAbs_CCA1\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = abs($F[1]); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_CCA1.tsv

	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tAbs_CCA2\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = abs($F[2]); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_CCA2.tsv
done
