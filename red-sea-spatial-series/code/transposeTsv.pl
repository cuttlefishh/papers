#!/usr/bin/perl

$usage = qq{

    transposeTsv.pl <file_tsv> <file_out>


};


die "$usage" unless @ARGV == 2;

$file_csv  = $ARGV[0];
$file_out  = $ARGV[1];

open (FILE, $file_csv) or die "No likey the file $file_clusters!";
@data = <FILE>;
close FILE;

open(NEWFILE,">$file_out") or die "Cannot open file to write to!\n";

$numrows = @data;
$rowcounter = 0;

foreach $line (@data) {
    chomp $line;
    $numcols = split(/\t/,$line);
    $hash_rows{$rowcounter} = $line;
    $rowcounter++;
}

for $key (sort {$a<=>$b} keys %hash_rows) {
    @fields = split(/\t/,$hash_rows{$key});
    $colcounter = 0;
    for ($i = 0; $i < $numcols; $i++) {
	$hash_newrows{$colcounter} .= "$fields[$i]\t";
	$colcounter++;
    }
}

for $key (sort {$a<=>$b} keys %hash_newrows) {
    $line = $hash_newrows{$key};
    chop $line;
    print NEWFILE "$line\n";
}

exit;
