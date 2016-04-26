# not needed
for i in CAP_genes_loadings CAP_pathways_loadings
do
	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tMagnitude\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = sqrt($F[1]**2 + $F[2]**2); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_mag.tsv

	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tAbs_CAP1\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = abs($F[1]); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_CAP1.tsv

	head -n 1 ${i}.tsv | perl -ne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[2]\tAbs_CAP2\n"' > temp
	tail -n +2 ${i}.tsv | perl -ne '@F = split /\t/; $entry = "$F[0]\t$F[1]\t$F[2]"; $hash{$entry} = abs($F[2]); END { foreach(sort{$hash{$b} <=> $hash{$a}} keys %hash) { print "$_\t$hash{$_}\n" } }' >> temp
	mv temp ${i}_sort_CAP2.tsv
done
