for i in {0..5793} #0..5793
do
    java -jar ~/bin/mine/MINE.jar ~/krse2011/visualizer/krse2011_v3_humann_KOrelAbund.csv -masterVariable $i
done
mv *KOrelAbund*Results.csv ~/krse2011/mine/KOrelAbund
mv *KOrelAbund*Status.txt ~/krse2011/mine/KOrelAbund
