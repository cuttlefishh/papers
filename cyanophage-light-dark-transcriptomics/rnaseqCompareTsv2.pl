#!/usr/bin/perl

$usage = qq{

    rnaseqCompareTsv.pl <genelist> <deg1> <deg2> <deg1type> <deg2type>

	<genelist> list of locus_tags, eg genelist_med4phm2
        <deg1> TSV file with locus_tag1, additional info, eg mydeseq2Ho.updn.inf_lt_0h_vs_ctr.tsv
        <deg2> TSV file with locus_tag2, additional info, eg mynoiseqHo.updn.inf_lt_0h_vs_ctr.tsv
        <deg1type> string incidating method, eg "deseq2" -- deseq must come first
        <deg2type> string incidating method, eg "noiseq" -- noiseq must come second

        This script goes through the list of locus tags and finds the corresponding diff expr ones
        in the list of DEGs.  It then prints to standard output a new TSV file with the locus tags
        that are found in one or more list of DEGs.


};

die "$usage" unless @ARGV == 5;

$cogsfile = $ARGV[0];
$gen1file = $ARGV[1];
$gen2file = $ARGV[2];
$deg1type = $ARGV[3];
$deg2type = $ARGV[4];

open (FILE, $cogsfile) or die "Cannot open $cogsfile!";
@datacogs = <FILE>;
close FILE;

open (FILE, $gen1file) or die "Cannot open $gen1file!";
@datagen1 = <FILE>;
close FILE;

open (FILE, $gen2file) or die "Cannot open $gen2file!";
@datagen2 = <FILE>;
close FILE;

if ($deg1type eq "deseq2") {
    $foldfield1 = 1;
} elsif ($deg1type eq "noiseq") {
    $foldfield1 = 4;
} else {
    die "Error: $deg1type is not a valid value for deg2type!\n";
}

if ($deg2type eq "deseq2") {
    $foldfield2 = 1;
} elsif ($deg2type eq "noiseq") {
    $foldfield2 = 4;
} else {
    die "Error: $deg2type is not a valid value for deg2type!\n";
}

foreach $line (@datagen1) {
    chomp $line;
    @fields = split(/\t/, $line);
    $locus = shift(@fields);
    $info = join("\t", @fields);
    $hash1{$locus} = $info;
}

foreach $line (@datagen2) {
    chomp $line;
    @fields = split(/\t/, $line);
    $locus = shift(@fields);
    $info = join("\t", @fields);
    $hash2{$locus} = $info;
}

foreach $cog (@datacogs) {
    chomp $cog;
    if ($hash1{$cog} || $hash2{$cog}) {
	print "$cog\t";
	if ($hash1{$cog}) {
	    @deginfo = split(/\t/,$hash1{$cog});
	    $fold1 = sprintf("%1.3f", $deginfo[$foldfield1]);
	    print "$deg1type\t$fold1\t";
	} else {
	    print "\t\t";
	}
	if ($hash2{$cog}) {
	    @deginfo = split(/\t/,$hash2{$cog});
	    $fold2 = sprintf("%1.3f", $deginfo[$foldfield2]);
	    $infct2 = sprintf("%1.0f", $deginfo[0]);
	    $ctrct2 = sprintf("%1.0f", $deginfo[1]);
	    print "$deg2type\t$fold2\t$infct2\t$ctrct2\t";
	} else {
	    print "\t\t\t\t";
	}
	if ($hash1{$cog}) {
	    @deginfo = split(/\t/,$hash1{$cog});
	    $descr = pop(@deginfo);
	    print "$descr\n";
	} else {
	    @deginfo = split(/\t/,$hash2{$cog});
	    $descr = pop(@deginfo);
	    print "$descr\n";
	}
    }
}

exit;
