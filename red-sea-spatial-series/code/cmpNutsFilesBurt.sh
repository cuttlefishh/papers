perl ~/scripts/myscripts/combineKrse2011.pl ../visualizer/krse2011_ctd_v1.csv ../visualizer/nutrients_whoi_v1.csv ../visualizer/empty.csv krse2011_v1_whoiOnly.csv
perl ~/scripts/myscripts/combineKrse2011.pl ../visualizer/krse2011_ctd_v1.csv ../visualizer/empty.csv ../visualizer/nutrients_ucsb_v1.csv krse2011_v1_ucsbOnly.csv
cat krse2011_v1_whoiOnly.csv | perl -ne '!/,,,,$/ && print' > temp
mv temp krse2011_v1_whoiOnly.csv
cat krse2011_v1_ucsbOnly.csv | perl -ne '!/,,,,$/ && print' > temp
mv temp krse2011_v1_ucsbOnly.csv
