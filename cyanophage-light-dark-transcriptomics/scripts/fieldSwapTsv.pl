#!/usr/bin/perl

$usage = qq{

    fieldSwapTsv.pl <tsvMulticol> <fieldToSwap> <tsv2col> <fieldOld> <fieldNew>

	<tsvMulticol> TSV file with one field you want to swap
        <fieldToSwap> The field you want to swap (0,1,2,...)
        <tsv2col> TSV file with two columns, usually matching,new
        <fieldOld> The field that matches up to existing file (0 or 1)
        <fieldNew> The field that contains the new string to use (0 or 1)

        General script for replacing names, etc. in one field with a corresponding
        set of new names.


};

die "$usage" unless @ARGV == 5;

$file1 = $ARGV[0];
$fieldSwap = $ARGV[1];
$file2 = $ARGV[2];
$fieldOld = $ARGV[3];
$fieldNew = $ARGV[4];

open (FILE, $file1) or die "Cannot open $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "Cannot open $file2!";
@data2 = <FILE>;
close FILE;

foreach $line (@data2) {
    chomp $line;
    @fields = split(/\t/, $line);
    $old = $fields[$fieldOld];
    $new = $fields[$fieldNew];
    $hashMatch{$old} = $new;
}

foreach $line (@data1) {
    chomp $line;
    @fields = split(/\t/, $line);
    if ($hashMatch{$fields[$fieldSwap]}) {
	$fields[$fieldSwap] = $hashMatch{$fields[$fieldSwap]};
    } else {
	$fields[$fieldSwap] = "nomatch";
    }
    $newline = join("\t", @fields);
    print "$newline\n";
}

exit;
