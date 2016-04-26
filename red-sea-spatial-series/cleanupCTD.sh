cat CTD_cal_all.csv | perl -e 'while(<>){unless($_=="0,0,0,0,0,0,0,0,0,0,0\n"){print "$_"}}' > krse2011_ctd_all.csv;
cat CTD_headers.csv krse2011_ctd_all.csv > temp;
mv temp krse2011_ctd_all.csv;
cat CTD_cal_deep.csv | perl -e 'while(<>){unless($_=="0,0,0,0,0,0,0,0,0,0,0\n"){print "$_"}}' > krse2011_ctd_deep.csv;
cat CTD_headers.csv krse2011_ctd_deep.csv > temp;
mv temp krse2011_ctd_deep.csv;
cat CTD_cal_my.csv | perl -e 'while(<>){unless($_=="0,0,0,0,0,0,0,0,0,0,0\n"){print "$_"}}' > krse2011_ctd_my.csv;
cat CTD_headers.csv krse2011_ctd_my.csv > temp;
mv temp krse2011_ctd_my.csv;
