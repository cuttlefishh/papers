#!/usr/bin/perl

$usage = qq{

    duplicatesWhoi.pl <nuts-data-whoi>

        <nuts-data-whoi> e.g. nutrients_whoi_v1.csv

        Prints lines that have the same first three fields (station,
        cast, depth).


};

die "$usage" unless @ARGV == 1;

$file1 = $ARGV[0];

open (FILE, $file1) or die "No likey the file $file1!";
@data1 = <FILE>;
close FILE;

$prevSta = 0;
$prevCast = 0;
$prevDepth = 0;
$prevLine = "";

foreach $line (@data1) {
    chomp $line;
    @fields = split(/,/,$line);
    $sta   = $fields[0];
    $cast  = $fields[1];
    $depth = $fields[2];
    if (($sta == $prevSta) && ($cast == $prevCast) && ($depth == $prevDepth)) {
	print "$prevLine\n$line\n";
    }
    $prevSta = $sta;
    $prevCast = $cast;
    $prevDepth = $depth;
    $prevLine = $line;
}

exit;

