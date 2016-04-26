#!/usr/bin/perl

$usage = qq{

    rnaseqDegAddKegg.pl <file1> <file2> <file3> <file4>

	<file1> rnaseqCompare_senseReads5-5.txt
        <file2> genelist_PMM.tsv
        <file3> pmm_xrefall.list
        <file4> pmm_pathwayNames.list

        Goes through each DEG and matches the MED4-XXXX number to its PMM number,
        then pathway pmm number, then pathway name.  Appends the pathways to end
        of DEG file, with multiple pathways delimited by "/".


};

die "$usage" unless @ARGV == 4;

$file1 = $ARGV[0];
$file2 = $ARGV[1];
$file3 = $ARGV[2];
$file4 = $ARGV[3];

open (FILE, $file1) or die "Cannot open $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "Cannot open $file2!";
@data2 = <FILE>;
close FILE;

open (FILE, $file3) or die "Cannot open $file3!";
@data3 = <FILE>;
close FILE;

open (FILE, $file4) or die "Cannot open $file4!";
@data4 = <FILE>;
close FILE;

foreach $line (@data2) {
    chomp $line;
    ($locus, $PMM) = split(/\t/, $line);
    $hash2{$locus} = $PMM;
}

foreach $line (@data3) {
    chomp $line;
    $line =~ m/pmm:(PMM[0-9]{4}).*path:(.*)/;
    $PMM = $1;
    $pmmlist = $2;
    $hash3{$PMM} = $pmmlist;
}

#while ( my ($key, $value) = each(%hash3) ) {
#    print "$key => $value\n";
#}

foreach $line (@data4) {
    chomp $line;
    ($pmm, $pathway) = split(/  /, $line);
    $hash4{$pmm} = $pathway;
}

foreach $line (@data1) {
    chomp $line;
    @fields = split(/\t/, $line);
    $locus = shift(@fields);
    $info = join("\t", @fields);
    $PMM = $hash2{$locus};
    $pmmlist = $hash3{$PMM};
    @pmmarray = split(/ /, $pmmlist);
    print "$line\t";
    @pathwayarray = ();
    foreach $entry (@pmmarray) {
	@pathwayarray = (@pathwayarray,$hash4{$entry});
    }
    $pathwaylist = join("/", @pathwayarray);
    print "$pathwaylist\n";
}

exit;
