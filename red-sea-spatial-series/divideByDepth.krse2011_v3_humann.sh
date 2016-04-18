for i in krse2011_v3_humann.pathwayRelAbund_ECO.csv krse2011_v3_humann.KOrelAbund_ECO.csv krse2011_v3_humann_KOrelAbund.csv	krse2011_v3_humann_pathwayCoverage.csv krse2011_v3_humann_moduleCoverage.csv krse2011_v3_humann_pathwayRelAbund.csv krse2011_v3_humann_moduleRelAbund.csv
do
	#depth10
	head -n 1 $i > depth010.$i
	perl -lne '@F = split /,/; print if $F[5] eq "10"' $i >> depth010.$i
	#depth25
	head -n 1 $i > depth025.$i
	perl -lne '@F = split /,/; print if $F[5] eq "25"' $i >> depth025.$i
	#depth50
	head -n 1 $i > depth050.$i
	perl -lne '@F = split /,/; print if $F[5] eq "47"' $i >> depth050.$i
	perl -lne '@F = split /,/; print if $F[5] eq "50"' $i >> depth050.$i
	#depth100
	head -n 1 $i > depth100.$i
	perl -lne '@F = split /,/; print if $F[5] eq "100"' $i >> depth100.$i
	#depth200
	head -n 1 $i > depth200.$i
	perl -lne '@F = split /,/; print if $F[5] eq "200"' $i >> depth200.$i
	perl -lne '@F = split /,/; print if $F[5] eq "258"' $i >> depth200.$i
	#depth500
	head -n 1 $i > depth500.$i
	perl -lne '@F = split /,/; print if $F[5] eq "500"' $i >> depth500.$i
done

