#!/usr/bin/perl

$usage = qq{

    rnaseqConsolidate.pl <column> <40-rnaseq-data-files>

        <column> 6=TotalReadsInRegion 7=SenseReads 8=AntisenseReads
        <40-rnaseq-data-files> e.g. Ctr1_Lt_0h, ... , (40 files w/o ext)

        Makes one tab-separated file with the first column the gene numbers
        and the 2nd thru 41st columns the sense strand counts (field 7). 
        Headers are the sample labels.


};

die "$usage" unless @ARGV == 41;

$col = $ARGV[0];

if ($col == 6) {
    open(NEWFILE,">med4phm2_all.tsv") or die "Cannot open file to write to!\n";
} elsif ($col == 7) {
    open(NEWFILE,">med4phm2_sense.tsv") or die "Cannot open file to write to!\n";
} elsif ($col == 8) {
    open(NEWFILE,">med4phm2_anti.tsv") or die "Cannot open file to write to!\n";
} else {
    die "$usage";
}
open(NEWFILE2,">genelist.tsv") or die "Cannot open file to write to!\n";

for ($i=1; $i<41; $i++) {  # i is file counter

    open (FILE, "$ARGV[$i].txt") or die "No likey the file $ARGV[$i]!";
    @data = <FILE>;
    close FILE;

    $j = 0;

    foreach $line (@data) {
	chomp $line;
	@fields = split(/\t/,$line);
	$j += 1;  # j is line counter
	if ($i == 1) {
	    $hash{$j} = $fields[0];
	    print NEWFILE2 "$fields[0]\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t$fields[5]\n";
	}
	$hash{$j} .= "\t$fields[$col]";
    }
}

shift(@ARGV);
$headers = join("\t",@ARGV);

print NEWFILE "\t$headers\n";
foreach $key (sort{$hash{$a} cmp $hash{$b}} keys %hash) {
    print NEWFILE "$hash{$key}\n";
}

close NEWFILE;
close NEWFILE2;

exit;

