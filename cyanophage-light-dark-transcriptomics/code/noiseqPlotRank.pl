#!/usr/bin/perl

$usage = qq{

    noiseqPlotRank.pl <mynoiseq.all...csv> x5 <genes.tsv> <prob_cutoff>

	<mynoiseq.all...csv>: list of differentially expressed genes with 12 fields
            e.g. mynoiseqHo.all.inf_lt_0h.ctr_lt_0h.csv
	<genes.tsv>: list of genes, tab-delimited 3 fields: geneNo/length/descr
        <prob_cutoff>: probability cutoff, e.g. 0.8

	This script goes through NOISeq comparisons (e.g. infected vs control) for
        all genes.  For any gene with prob>=prob_cutoff at any timepoint, it reports
        the probability and ranking in a table.  Fields in table are:
            1. Gene_number
            2. Probability for t=0h
            3. Probability for t=1h
            4. Probability for t=2h
            5. Probability for t=4h
            6. Probability for t=8h
            7. Ranking for t=0h
            8. Ranking for t=1h
            9. Ranking for t=2h
           10. Ranking for t=4h
           11. Ranking for t=8h
           12. Description


};

die "$usage" unless @ARGV == 7;

$file0h = $ARGV[0];
$file1h = $ARGV[1];
$file2h = $ARGV[2];
$file4h = $ARGV[3];
$file8h = $ARGV[4];
$fileGene = $ARGV[5];
$p = $ARGV[6];

open (FILE, $file0h) or die "Cannot open $file0h!";
@data0h = <FILE>;
close FILE;

open (FILE, $file1h) or die "Cannot open $file1h!";
@data1h = <FILE>;
close FILE;

open (FILE, $file2h) or die "Cannot open $file2h!";
@data2h = <FILE>;
close FILE;

open (FILE, $file4h) or die "Cannot open $file4h!";
@data4h = <FILE>;
close FILE;

open (FILE, $file8h) or die "Cannot open $file8h!";
@data8h = <FILE>;
close FILE;

open (FILE, $fileGene) or die "Cannot open $fileGene!";
@dataGene = <FILE>;
close FILE;

foreach $line (@data0h) {
    @fields = split(/,/, $line);
    $seqid = $fields[0];
    $prob = sprintf("%1.4f", $fields[5]); #round to 4 decimal places
    $rank = sprintf("%1.1f", $fields[6]); #round to 1 decimal places
    $hashProb0h{$seqid} = $prob;
    $hashRank0h{$seqid} = $rank;
}

foreach $line (@data1h) {
    @fields = split(/,/, $line);
    $seqid = $fields[0];
    $prob = sprintf("%1.4f", $fields[5]); #round to 4 decimal places
    $rank = sprintf("%1.1f", $fields[6]); #round to 1 decimal places
    $hashProb1h{$seqid} = $prob;
    $hashRank1h{$seqid} = $rank;
}

foreach $line (@data2h) {
    @fields = split(/,/, $line);
    $seqid = $fields[0];
    $prob = sprintf("%1.4f", $fields[5]); #round to 4 decimal places
    $rank = sprintf("%1.1f", $fields[6]); #round to 1 decimal places
    $hashProb2h{$seqid} = $prob;
    $hashRank2h{$seqid} = $rank;
}

foreach $line (@data4h) {
    @fields = split(/,/, $line);
    $seqid = $fields[0];
    $prob = sprintf("%1.4f", $fields[5]); #round to 4 decimal places
    $rank = sprintf("%1.1f", $fields[6]); #round to 1 decimal places
    $hashProb4h{$seqid} = $prob;
    $hashRank4h{$seqid} = $rank;
}

foreach $line (@data8h) {
    @fields = split(/,/, $line);
    $seqid = $fields[0];
    $prob = sprintf("%1.4f", $fields[5]); #round to 4 decimal places
    $rank = sprintf("%1.1f", $fields[6]); #round to 1 decimal places
    $hashProb8h{$seqid} = $prob;
    $hashRank8h{$seqid} = $rank;
}

print "Gene_number\tP_0h\tP_1h\tP_2h\tP_4h\tP_8h\tR_0h\tR_1h\tR_2h\tR_4h\tR_8h\tDescription\n";

foreach $line (@dataGene) {
    chomp $line;
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $descr = $fields[2];
    if (($hashProb0h{$seqid} >= $p) || ($hashProb1h{$seqid} >= $p) || ($hashProb2h{$seqid} >= $p) || ($hashProb4h{$seqid} >= $p) || ($hashProb8h{$seqid} >= $p)) {
	print "$seqid\t$hashProb0h{$seqid}\t$hashProb1h{$seqid}\t$hashProb2h{$seqid}\t$hashProb4h{$seqid}\t$hashProb8h{$seqid}\t$hashRank0h{$seqid}\t$hashRank1h{$seqid}\t$hashRank2h{$seqid}\t$hashRank4h{$seqid}\t$hashRank8h{$seqid}\t$descr\n";
    }
}

exit;
