for i in {1..9}
do
	cat /home/luth1104/krse2011/ublast/SAMP0$i.1.prinseq.usearch.top1 | perl -alne '$entry = $F[2]; $entry =~ m/([a-z]{3}):(.*)/; print $1' | sort | uniq -c > /home/luth1104/krse2011/ublast/SAMP0$i.1.wcTaxa.txt
	cat /home/luth1104/krse2011/ublast/SAMP0$i.2.prinseq.usearch.top1 | perl -alne '$entry = $F[2]; $entry =~ m/([a-z]{3}):(.*)/; print $1' | sort | uniq -c > /home/luth1104/krse2011/ublast/SAMP0$i.2.wcTaxa.txt
	cat /home/luth1104/krse2011/ublast/SAMP0$i.1.prinseq.usearch.top1 | perl -alne '$entry = $F[2]; $entry =~ m/([a-z]{3}):(.*)/; print $2' | sort | uniq -c > /home/luth1104/krse2011/ublast/SAMP0$i.1.wcGenes.txt
	cat /home/luth1104/krse2011/ublast/SAMP0$i.2.prinseq.usearch.top1 | perl -alne '$entry = $F[2]; $entry =~ m/([a-z]{3}):(.*)/; print $2' | sort | uniq -c > /home/luth1104/krse2011/ublast/SAMP0$i.2.wcGenes.txt
done
