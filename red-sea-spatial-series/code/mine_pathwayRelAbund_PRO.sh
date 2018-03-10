# for i in {0..100}
# do
#     java -jar ~/bin/mine/MINE.jar ~/krse2011/db/krse2011_v3_humann.pathwayRelAbund_PRO.csv -masterVariable $i
# done
for i in {0..317}
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/db/krse2011_v3_humann.pathwayRelAbund_ECO.csv -masterVariable $i
done
mv ~/krse2011/db/krse2011_v3_humann.pathwayRelAbund_*.csv\,mv\=*\,cv\=0.0\,B\=n\^0.6\,Results.csv ~/krse2011/mine/pathwayRelAbund
mv ~/krse2011/db/krse2011_v3_humann.pathwayRelAbund_*.csv\,mv\=*\,cv\=0.0\,B\=n\^0.6\,Status.txt ~/krse2011/mine/pathwayRelAbund
