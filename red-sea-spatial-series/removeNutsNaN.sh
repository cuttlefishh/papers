cat nutrients_whoi_v1.csv | perl -e 'while(<>){unless(/NaN,NaN,NaN,NaN/){print "$_"}}' > temp
mv temp nutrients_whoi_v1.csv
cat nutrients_ucsb_v1.csv | perl -e 'while(<>){unless(/NaN,NaN,NaN,NaN/){print "$_"}}' > temp
mv temp nutrients_ucsb_v1.csv
