#!/usr/bin/perl

$usage = qq{

    noiseqbioMatchDeg.pl <mynoiseqbio.deg.csv> <genes.tsv>

	<mynoiseqbio.deg.csv>: list of differentially expressed genes with 10 fields
            e.g. mynoiseqHo.deg1.inf_lt_0h.ctr_lt_0h.csv
	<genes.tsv>: list of genes, tab-delimited 3 fields: geneNo/length/descr

	This script goes through each line of the csv file, then finds the corresponding
	description for each gene.  It prints the resulting 11-field tsv file to standard
	output.


};

die "$usage" unless @ARGV == 2;

$file1 = $ARGV[0];
$file2 = $ARGV[1];

open (FILE, $file1) or die "Cannot open $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "Cannot open $file2!";
@data2 = <FILE>;
close FILE;

print "Gene_number\tMean1\tMean2\tTheta\tProb\tLog2FC\tLength\tChrom\tStart\tEnd\tDescription\n";

foreach my $line (@data1) {
    chomp $line;
    @fields = split(/,/, $line);
    $fields[1] = sprintf("%1.0f", $fields[1]); #round to 0 decimal places
    $fields[2] = sprintf("%1.0f", $fields[2]); #round to 0 decimal places
    $fields[3] = sprintf("%1.3f", $fields[3]); #round to 3 decimal places
    $fields[4] = sprintf("%1.3f", $fields[4]); #round to 3 decimal places
    $fields[5] = sprintf("%1.3f", $fields[5]); #round to 3 decimal places
    $seqid = $fields[0];
    foreach $linep (@data2) {
	chomp $linep;
	($seqidp, $length, $descr) = split(/\t/, $linep);
	#$descr =~ s/,/ /g;
	if ($seqid eq $seqidp) {
	    push(@fields, $descr);
	    $output = join("\t", @fields);
	    print "$output\n";
	    last;
	}
    }
}

exit;
