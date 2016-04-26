for i in Ctr1_Dk_0h.txt Ctr1_Dk_1h.txt Ctr1_Dk_2h.txt Ctr1_Dk_4h.txt Ctr1_Dk_8h.txt Ctr1_Lt_0h.txt Ctr1_Lt_1h.txt Ctr1_Lt_2h.txt Ctr1_Lt_4h.txt Ctr1_Lt_8h.txt Ctr2_Dk_0h.txt Ctr2_Dk_1h.txt Ctr2_Dk_2h.txt Ctr2_Dk_4h.txt Ctr2_Dk_8h.txt Ctr2_Lt_0h.txt Ctr2_Lt_1h.txt Ctr2_Lt_2h.txt Ctr2_Lt_4h.txt Ctr2_Lt_8h.txt Inf1_Dk_0h.txt Inf1_Dk_1h.txt Inf1_Dk_2h.txt Inf1_Dk_4h.txt Inf1_Dk_8h.txt Inf1_Lt_0h.txt Inf1_Lt_1h.txt Inf1_Lt_2h.txt Inf1_Lt_4h.txt Inf1_Lt_8h.txt Inf2_Dk_0h.txt Inf2_Dk_1h.txt Inf2_Dk_2h.txt Inf2_Dk_4h.txt Inf2_Dk_8h.txt Inf2_Lt_0h.txt Inf2_Lt_1h.txt Inf2_Lt_2h.txt Inf2_Lt_4h.txt Inf2_Lt_8h.txt
do
	echo -n $i
	echo -n " "
	perl -alne '@f = split /\t/; $sum += $f[6]; END { print $sum }' $i
done
