#!/usr/bin/perl

$usage = qq{

    rnaseqSizes.pl <rnaseq-data>

        <rnaseq-data> e.g. Ctr1_Lt_0h.txt or AAAAAA.txt

        Take any counts file and output gene sizes and products
        in tab-delimited format to standard ouput.


};

die "$usage" unless @ARGV == 1;

$file = $ARGV[0];
$med4 = 0;
$phm2 = 0;

open (FILE, $file) or die "No likey the file $file!";
@data = <FILE>;
close FILE;

foreach $line (@data) {
    chomp $line;
    @fields = split(/\t/,$line);
    if ($fields[0] eq "MED4") {
	$med4 += 1;
	if ($med4 < 10) {
	    $name = "MED4-000$med4";
	} elsif ($med4 < 100) {
	    $name = "MED4-00$med4";
	} elsif ($med4 < 1000) {
	    $name = "MED4-0$med4";
	} else {
	    $name = "MED4-$med4";
	}
	$size = $fields[4]-$fields[3]+1;
	$product = $fields[5];
	$product =~ s/Name=//;
	print "$name\t$size\t$product\n";
    }
    if ($fields[0] eq "PHM2") {
	$phm2 += 1;
	if ($phm2 < 10) {
	    $name = "PHM2-00$phm2";
	} elsif ($phm2 < 100) {
	    $name = "PHM2-0$phm2";
	} else {
	    $name = "PHM2-$phm2";
	}
	$size = $fields[4]-$fields[3]+1;
	$product = $fields[5];
	$product =~ s/Name=//;
	print "$name\t$size\t$product\n";
    }
}

exit;

