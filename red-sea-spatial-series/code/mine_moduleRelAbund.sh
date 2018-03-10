for i in {0..201}
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/visualizer/krse2011_v3_humann_moduleRelAbund.csv -masterVariable $i
done
mv *moduleRelAbund*Results.csv ~/krse2011/mine/moduleRelAbund
mv *moduleRelAbund*Status.txt ~/krse2011/mine/moduleRelAbund
