#!/usr/bin/perl

$usage = qq{

    rnaseqIds.pl <rnaseq-data>

        <rnaseq-data> e.g. Ctr1_Lt_0h.txt or AAAAAA.txt


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
	    $fields[0] = "MED4-000$med4";
	} elsif ($med4 < 100) {
	    $fields[0] = "MED4-00$med4";
	} elsif ($med4 < 1000) {
	    $fields[0] = "MED4-0$med4";
	} else {
	    $fields[0] = "MED4-$med4";
	}
	$newline = join("\t",@fields);
	print "$newline\n";
    }
    if ($fields[0] eq "PHM2") {
	$phm2 += 1;
	if ($phm2 < 10) {
	    $fields[0] = "PHM2-00$phm2";
	} elsif ($phm2 < 100) {
	    $fields[0] = "PHM2-0$phm2";
	} else {
	    $fields[0] = "PHM2-$phm2";
	}
	$newline = join("\t",@fields);
	print "$newline\n";
    }
}

exit;

