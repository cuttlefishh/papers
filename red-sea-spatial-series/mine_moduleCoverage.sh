for i in {0..130}
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/visualizer/krse2011_v3_humann_moduleCoverage.csv -masterVariable $i
done
mv *moduleCoverage*Results.csv ~/krse2011/mine/moduleCoverage
mv *moduleCoverage*Status.txt ~/krse2011/mine/moduleCoverage
