# to be run on compy
for i in {0..3870}
do
    java -jar ~/bin/mine/MINE.jar $PBS_O_WORKDIR/krse2011_v3_humann.pathwayRelAbund_ECO.csv -masterVariable $i
done
