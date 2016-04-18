#!/usr/bin/perl

$usage = qq{

    combineKrse2011.pl <ctd-data> <nuts-data-whoi> <nuts-data-ucsb> <outfile>

        <ctd-data> e.g. krse2011_ctd_v1.csv
        <nuts-data-whoi> e.g. nutrients_whoi_v1.csv
        <nuts-data-ucsb> e.g. nutrients_ucsb_v1.csv
        <outfile> e.g. krse2011_v1.csv

        Combines CTD and nutrient data to make uber-table for
        visualizer and Marc Genton.


};

die "$usage" unless @ARGV == 4;

$file1 = $ARGV[0];
$file2 = $ARGV[1];
$file3 = $ARGV[2];
$outfile = $ARGV[3];

open (FILE, $file1) or die "No likey the file $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "No likey the file $file2!";
@data2 = <FILE>;
close FILE;

open (FILE, $file3) or die "No likey the file $file3!";
@data3 = <FILE>;
close FILE;

open(NEWFILE,">$outfile") or die "Cannot open file to write to!\n";

# store UCSB nutrient data to hash
foreach $line (@data3) {
    chomp $line;
    @fields = split(/,/,$line);
    $station  = $fields[0];
    $depth    = $fields[2];
    $phosp    = $fields[4];
    $silicate = "NaN";
    $no3no2   = $fields[7];
    $nh4      = $fields[8];
    $key = "$station-$depth";
    $hash_nuts{$key} = "$phosp,$silicate,$no3no2,$nh4";
}

# store WHOI nutrient data to hash -- will write over UCSB and its own data if nec
foreach $line (@data2) {
    chomp $line;
    @fields = split(/,/,$line);
    $station  = $fields[0];
    $depth    = $fields[2];
    $phosp    = $fields[4];
    $silicate = $fields[5];
    $no3no2   = $fields[7];
    $nh4      = $fields[8];
    $hash_nuts{"$station-$depth"} = "$phosp,$silicate,$no3no2,$nh4";
}

print NEWFILE "station,latitude,longitude,pressure,temperature,salinity,oxygen,fluorescence,turbidity,phosphate,silicate,nitrate,ammonium\n";

foreach $line (@data1) {
    chomp $line;
    @fields = split(/,/,$line);
    $station  = $fields[2];
    $depth    = $fields[5];
    $key = "$station-$depth";
    $ctd = join(",",@fields[2,3,4,5,6,7,8,9,10]);
    if ($hash_nuts{$key}) {
	print NEWFILE "$ctd,$hash_nuts{$key}\n";
    } else {
	print NEWFILE "$ctd,,,,\n";
    }
}

close NEWFILE;

exit;

