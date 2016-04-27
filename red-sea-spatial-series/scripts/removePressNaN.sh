cat krse2011_ctd_my.csv | perl -e 'while(<>){unless(/[0-9]*,[0-9]*,[0-9]*,[0-9\.]*,[0-9\.]*,NaN/){print "$_"}}' > krse2011_ctd_v1.csv
