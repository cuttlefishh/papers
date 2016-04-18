#!/usr/bin/perl

$usage = qq{

    evalSummary.pl <summary_samp*_read*.txt>

    Counts the number of PASS/WARN/FAIL signals for each run and reports
    the sums (printed to standard output).


};

die "$usage" unless @ARGV >= 1;

$crit1p = 0;
$crit1w = 0;
$crit1f = 0;
$crit2p = 0;
$crit2w = 0;
$crit2f = 0;
$crit3p = 0;
$crit3w = 0;
$crit3f = 0;
$crit4p = 0;
$crit4w = 0;
$crit4f = 0;
$crit5p = 0;
$crit5w = 0;
$crit5f = 0;
$crit6p = 0;
$crit6w = 0;
$crit6f = 0;
$crit7p = 0;
$crit7w = 0;
$crit7f = 0;
$crit8p = 0;
$crit8w = 0;
$crit8f = 0;
$crit9p = 0;
$crit9w = 0;
$crit9f = 0;
$crit10p = 0;
$crit10w = 0;
$crit10f = 0;
$crit11p = 0;
$crit11w = 0;
$crit11f = 0;

foreach $filename (@ARGV) {
    open (FILE, $filename) or die "Cannot open $filename!";
    @data = <FILE>;
    close FILE;
    foreach $line (@data) {
	if ($line =~ /([A-Z]{4})\tBasic Statistics/) {
	    if ($1 eq "PASS") {$crit1p += 1;}
	    if ($1 eq "WARN") {$crit1w += 1;}
	    if ($1 eq "FAIL") {$crit1f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer base sequence quality/) {
	    if ($1 eq "PASS") {$crit2p += 1;}
	    if ($1 eq "WARN") {$crit2w += 1;}
	    if ($1 eq "FAIL") {$crit2f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer sequence quality scores/) {
	    if ($1 eq "PASS") {$crit3p += 1;}
	    if ($1 eq "WARN") {$crit3w += 1;}
	    if ($1 eq "FAIL") {$crit3f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer base sequence content/) {
	    if ($1 eq "PASS") {$crit4p += 1;}
	    if ($1 eq "WARN") {$crit4w += 1;}
	    if ($1 eq "FAIL") {$crit4f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer base GC content/) {
	    if ($1 eq "PASS") {$crit5p += 1;}
	    if ($1 eq "WARN") {$crit5w += 1;}
	    if ($1 eq "FAIL") {$crit5f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer sequence GC content/) {
	    if ($1 eq "PASS") {$crit6p += 1;}
	    if ($1 eq "WARN") {$crit6w += 1;}
	    if ($1 eq "FAIL") {$crit6f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tPer base N content/) {
	    if ($1 eq "PASS") {$crit7p += 1;}
	    if ($1 eq "WARN") {$crit7w += 1;}
	    if ($1 eq "FAIL") {$crit7f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tSequence Length Distribution/) {
	    if ($1 eq "PASS") {$crit8p += 1;}
	    if ($1 eq "WARN") {$crit8w += 1;}
	    if ($1 eq "FAIL") {$crit8f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tSequence Duplication Levels/) {
	    if ($1 eq "PASS") {$crit9p += 1;}
	    if ($1 eq "WARN") {$crit9w += 1;}
	    if ($1 eq "FAIL") {$crit9f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tOverrepresented sequences/) {
	    if ($1 eq "PASS") {$crit10p += 1;}
	    if ($1 eq "WARN") {$crit10w += 1;}
	    if ($1 eq "FAIL") {$crit10f += 1;}
	}
	if ($line =~ /([A-Z]{4})\tKmer Content/) {
	    if ($1 eq "PASS") {$crit11p += 1;}
	    if ($1 eq "WARN") {$crit11w += 1;}
	    if ($1 eq "FAIL") {$crit11f += 1;}
	}
    }
}

print "                            \tPASS\tWARN\tFAIL\n";
print "Basic statistics            \t$crit1p\t$crit1w\t$crit1f\n";
print "Per base sequence quality   \t$crit2p\t$crit2w\t$crit2f\n";
print "Per sequence quality scores \t$crit3p\t$crit3w\t$crit3f\n";
print "Per base sequence content   \t$crit4p\t$crit4w\t$crit4f\n";
print "Per base GC content         \t$crit5p\t$crit5w\t$crit5f\n";
print "Per sequence GC content     \t$crit6p\t$crit6w\t$crit6f\n";
print "Per base N content          \t$crit7p\t$crit7w\t$crit7f\n";
print "Sequence length distribution\t$crit8p\t$crit8w\t$crit8f\n";
print "Sequence duplication levels \t$crit9p\t$crit9w\t$crit9f\n";
print "Overrepresented sequences   \t$crit10p\t$crit10w\t$crit10f\n";
print "Kmer content                \t$crit11p\t$crit11w\t$crit11f\n";

exit;
