echo "cluster,sample" > clustersKoNormSamp.csv
echo "cluster,sample" > clustersKoNoneSamp.csv
echo "cluster,ko" > clustersKoNormKos.csv
echo "cluster,ko" > clustersKoNoneKos.csv
for i in {1..12}
do
	export i
	perl -ne '@F = split /,/; print "$ENV{i},$F[1]" if $. > 1' KoNormSampClust$i.csv >> clustersKoNormSamp.csv
	perl -ne '@F = split /,/; print "$ENV{i},$F[1]" if $. > 1' KoNoneSampClust$i.csv >> clustersKoNoneSamp.csv
	perl -ne '@F = split /,/; print "$ENV{i},$F[1]" if $. > 1' KoNormKosClust$i.csv >> clustersKoNormKos.csv
	perl -ne '@F = split /,/; print "$ENV{i},$F[1]" if $. > 1' KoNoneKosClust$i.csv >> clustersKoNoneKos.csv
done

perl ~/scripts/myscripts/hashLookup_csv_6char.pl clustersKoNormSamp.csv ~/krse2011/db/samples.csv 1 0 1 > temp
mv temp clustersKoNormSamp.csv
perl ~/scripts/myscripts/hashLookup_csv_6char.pl clustersKoNoneSamp.csv ~/krse2011/db/samples.csv 1 0 1 > temp
mv temp clustersKoNoneSamp.csv
perl ~/scripts/myscripts/hashLookup_csv_6char.pl clustersKoNormKos.csv ~/krse2011/humann/humann_KOrelAbund.csv 1 0 1 > temp
mv temp clustersKoNormKos.csv
perl ~/scripts/myscripts/hashLookup_csv_6char.pl clustersKoNoneKos.csv ~/krse2011/humann/humann_KOrelAbund.csv 1 0 1 > temp
mv temp clustersKoNoneKos.csv
