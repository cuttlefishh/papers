echo "SUMMARY: ALL"
perl evalSummary.pl fastqcSummary/summary_samp*
echo ""
echo "SUMMARY: READ 1"
perl evalSummary.pl fastqcSummary/summary_samp*read1.txt
echo ""
echo "SUMMARY: READ 2"
perl evalSummary.pl fastqcSummary/summary_samp*read2.txt
echo ""
echo "SUMMARY: LANE 1"
perl evalSummary.pl fastqcSummary/summary_samp02* fastqcSummary/summary_samp09* fastqcSummary/summary_samp10* fastqcSummary/summary_samp16* fastqcSummary/summary_samp17* fastqcSummary/summary_samp22* fastqcSummary/summary_samp29* fastqcSummary/summary_samp30* fastqcSummary/summary_samp31* fastqcSummary/summary_samp34* fastqcSummary/summary_samp36* fastqcSummary/summary_samp40* fastqcSummary/summary_samp41* fastqcSummary/summary_samp42* fastqcSummary/summary_samp43*
echo ""
echo "SUMMARY: LANE 2"
perl evalSummary.pl fastqcSummary/summary_samp03* fastqcSummary/summary_samp04* fastqcSummary/summary_samp05* fastqcSummary/summary_samp06* fastqcSummary/summary_samp07* fastqcSummary/summary_samp08* fastqcSummary/summary_samp11* fastqcSummary/summary_samp12* fastqcSummary/summary_samp13* fastqcSummary/summary_samp14* fastqcSummary/summary_samp15* fastqcSummary/summary_samp18* fastqcSummary/summary_samp19* fastqcSummary/summary_samp20* fastqcSummary/summary_samp39*
echo ""
echo "SUMMARY: LANE 3"
perl evalSummary.pl fastqcSummary/summary_samp01* fastqcSummary/summary_samp21* fastqcSummary/summary_samp23* fastqcSummary/summary_samp24* fastqcSummary/summary_samp25* fastqcSummary/summary_samp26* fastqcSummary/summary_samp27* fastqcSummary/summary_samp28* fastqcSummary/summary_samp32* fastqcSummary/summary_samp33* fastqcSummary/summary_samp35* fastqcSummary/summary_samp37* fastqcSummary/summary_samp38* fastqcSummary/summary_samp44* fastqcSummary/summary_samp45*
echo ""
