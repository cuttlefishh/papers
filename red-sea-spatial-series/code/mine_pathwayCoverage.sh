for i in {0..159}
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/visualizer/krse2011_v3_humann_pathwayCoverage.csv -masterVariable $i
done
mv *pathwayCoverage*Results.csv ~/krse2011/mine/pathwayCoverage
mv *pathwayCoverage*Status.txt ~/krse2011/mine/pathwayCoverage
