cd ~/krse2011/db
echo "for i in {0..N}"
echo "krse2011_v3_humann_KOrelAbund.csv"
head -n 1 krse2011_v3_humann_KOrelAbund.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann_moduleCoverage.csv"
head -n 1 krse2011_v3_humann_moduleCoverage.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann_moduleRelAbund.csv"
head -n 1 krse2011_v3_humann_moduleRelAbund.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann_pathwayCoverage.csv"
head -n 1 krse2011_v3_humann_pathwayCoverage.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann_pathwayRelAbund.csv"
head -n 1 krse2011_v3_humann_pathwayRelAbund.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann.pathwayRelAbund_PRO.csv"
head -n 1 krse2011_v3_humann.pathwayRelAbund_PRO.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann.pathwayRelAbund_ECO.csv"
head -n 1 krse2011_v3_humann.pathwayRelAbund_ECO.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
echo "krse2011_v3_humann.KOrelAbund_ECO.csv"
head -n 1 krse2011_v3_humann.KOrelAbund_ECO.csv | perl -alne 'chomp; @f = split /,/; $size = @f; print $size-1'
cd ~/krse2011/mine
