# do not run more than once or the file name will get changed too!
for i in #tab-luke1.txt tab-luke2.txt
do
	sed 's/_/\\us{}/' $i > temp; mv temp $i
done

