for i in {0..180}
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/visualizer/krse2011_v3_humann_pathwayRelAbund.csv -masterVariable $i
done
mv *pathwayRelAbund*Results.csv ~/krse2011/mine/pathwayRelAbund
mv *pathwayRelAbund*Status.txt ~/krse2011/mine/pathwayRelAbund
