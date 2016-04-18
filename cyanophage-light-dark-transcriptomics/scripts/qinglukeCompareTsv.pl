#!/usr/bin/perl

$usage = qq{

    qinglukeCompareTsv.pl <sharedCogs> <genelist1> <genelist2>

	<sharedCogs> CSV file with cluster information, e.g. med4+natl2a.v3.csv. Fields are:
            0. cluster_id_V3
            1. locus_tag1
            2. locus_tag2
        <genelist1> TSV file with locus_tag1, additional info
        <genelist2> TSV file with locus_tag2, additional info

        This script goes through the list of shared COGs and finds the corresponding locus tags
        in the gene list files.  It then prints to standard output a new TSV file with the cog_id 
        (version 3), locus_tag1 + addl info, and locus_tag2 + addl info.


};

die "$usage" unless @ARGV == 3;

$cogsfile = $ARGV[0];
$gen1file = $ARGV[1];
$gen2file = $ARGV[2];

open (FILE, $cogsfile) or die "Cannot open $cogsfile!";
@datacogs = <FILE>;
close FILE;

open (FILE, $gen1file) or die "Cannot open $gen1file!";
@datagen1 = <FILE>;
close FILE;

open (FILE, $gen2file) or die "Cannot open $gen2file!";
@datagen2 = <FILE>;
close FILE;

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

#THIS DISPLAYS ONLY SHARED ORTHOLOGS UP/DN IN ONE OR BOTH DATA SETS
foreach $line (@datacogs) {
    chomp $line;
    @fields = split(/,/, $line);
    $cog = $fields[0];
    $locus1 = $fields[1];
    $locus2 = $fields[2];
    if ($hash1{$locus1} || $hash2{$locus2}) {
	print "$cog\t";
	print "$locus1\t";
	if ($hash1{$locus1}) {
	    print "$hash1{$locus1}\t";
	} else {
	    print "\t\t";
	}
	print "$locus2\t";
	if ($hash2{$locus2}) {
	    print "$hash2{$locus2}\n";
	} else {
	    print "\t\n";
	}
    }
}

#THIS WOULD DISPLAY ALL SHARED ORTHOLOGS
#foreach $line (@datacogs) {
#    chomp $line;
#    @fields = split(/,/, $line);
#    $cog = $fields[0];
#    $locus1 = $fields[1];
#    $locus2 = $fields[2];
#    print "$cog\t";
#    print "$locus1\t";
#    if ($hash1{$locus1}) {
#	print "$hash1{$locus1}\t";
#    } else {
#	print "\t\t";
#    }
#    print "$locus2\t";
#    if ($hash2{$locus2}) {
#	print "$hash2{$locus2}\n";
#    } else {
#	print "\t\n";
#    }
#}

exit;
