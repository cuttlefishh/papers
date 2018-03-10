#!/usr/bin/perl

$usage = qq{

    combineKrse2011HumannTaxa.pl <physchemdata> <humannoutput> <outfile>

        <physchemdata> e.g. krse2011_v3_illumina.csv
        <humannoutput> e.g. pathwayRelAbund_PRO.tsv
        <outfile> e.g. krse2011_v3_humann.csv

        Combines physicochemical and humann data for Illumina samples.


};

die "$usage" unless @ARGV == 3;

$file1 = $ARGV[0];
$file2 = $ARGV[1];
$outfile = $ARGV[2];

open (FILE, $file1) or die "No likey the file $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "No likey the file $file2!";
@data2 = <FILE>;
close FILE;

open(NEWFILE,">$outfile") or die "Cannot open file to write to!\n";

# store physicochemical data to hash
$sampleno = -1; # header will be sampleno 0
foreach $line (@data1) {
    chomp $line;
    $sampleno += 1;
    $hash_pc{$sampleno} = $line; # physicochemical data for fwd read data
    unless ($sampleno==0) { # unless header, physicochemical data for rev read data  
        $sampleno += 1;
        $hash_pc{$sampleno} = $line;
    }
}

# store humann data to hash
$lineno = 0; # first line number is 1
foreach $line (@data2) {
    $lineno += 1;
    if ($lineno >= 1) { # start at line 1 (not 15) bc taxa-specific data has no header material
        chomp $line;
        @fields = split(/\t/,$line);
        $index = 0;
        $hash_humann{$index} .= ",$fields[0]"; # index 0 => 0:short_name, 1:long_name
        for ($i=2; $i<=91; $i++) {
            $index = $i-1;
            $hash_humann{$index} .= ",$fields[$i+1]"; # index 1-90 => data; $i+1 bc genome/group
        }
    }
}

# output combined results
for ($j=0; $j<=90; $j++) {
    print NEWFILE "$hash_pc{$j}";        # physicochemical data
    if ($j==0) {                         # read 1:fwd, 2:rev
        print NEWFILE ",read";
    } elsif ($j%2==1) {
        print NEWFILE ",1";
    } elsif ($j%2==0) {
        print NEWFILE ",2";
    }
    print NEWFILE "$hash_humann{$j}\n";  # humann data
}

close NEWFILE;

exit;

