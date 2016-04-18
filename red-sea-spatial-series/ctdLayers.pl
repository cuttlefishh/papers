#!/usr/bin/perl

$usage = qq{

    ctdLayers.pl <ctdFile> <field-sta> <field-press> <field-temp> <field-ox> <field-fluor>

	<ctdFile>: ctd data, .csv removed, fields as below, optional header row
	<field-sta>:   eg 0
        <field-press>: eg 3
        <field-temp>:  eg 4
        <field-ox>:    eg 6
        <field-fluor>: eg 7

	This script goes through each line of the csv file, and for each station
        calculates the mixed layer depth (temp diff of 0.5C), OMZ depth (max ox),
        and fluorescence maximum depth (max fluor).  Write to output files:
            krse2011.mixed.csv
            krse2011.oxmin.csv
            krse2011.chlmax.csv


};

die "$usage" unless @ARGV == 6;

$file1  = $ARGV[0];
$fSta   = $ARGV[1];
$fPress = $ARGV[2];
$fTemp  = $ARGV[3];
$fOx    = $ARGV[4];
$fFluor = $ARGV[5];

open (FILE, "$file1.csv") or die "Cannot open $file1!";
@data1 = <FILE>;
close FILE;

open(NEWFILE1,">$file1.mixed.csv") or die "Cannot open file to write to!\n";
open(NEWFILE2,">$file1.oxmin.csv") or die "Cannot open file to write to!\n";
open(NEWFILE3,">$file1.chlmax.csv") or die "Cannot open file to write to!\n";

print NEWFILE1 "station,temp,mixed\n";
print NEWFILE2 "station,ox,oxmin\n";
print NEWFILE3 "station,chl,chlmax\n";

foreach my $line (@data1) {
    if ($line =~ /^[a-zA-Z].*/) { #ignore header line
	next;
    }
    chomp $line;
    @fields = split(/,/, $line);
    $sta = $fields[$fSta];
    $press = $fields[$fPress];
    $temp = $fields[$fTemp];
    $ox = $fields[$fOx];
    $fluor = $fields[$fFluor];
    unless ($staFlag{$sta} == 1) { #new station
	if ($temp ne "NaN") {
	    $surfTemp = $temp; #store temperature at surface
	    $staFlag{$sta} = 1;
	    $oxMin{$sta} = 100; #reset oxygen minimum
	    $fluorMax{$sta} = -10; #reset fluorescence maximum
	}
    }
    unless ($tempFlag{$sta} == 1) { #check if temperature is 0.5 less than surface
	if ($surfTemp-$temp >= 0.5) {
	    print NEWFILE1 "$sta,$temp,$press\n";
	    $tempFlag{$sta} = 1;
	}
    }
    if ($ox < $oxMin{$sta}) {
	$oxMin{$sta} = $ox;
	$oxMinPress{$sta} = $press;
    }
    if ($fluor > $fluorMax{$sta}) {
	$fluorMax{$sta} = $fluor;
	$fluorMaxPress{$sta} = $press;
    }
}

foreach $sta (sort{$a<=>$b} keys(%oxMin)) {
    print NEWFILE2 "$sta,$oxMin{$sta},$oxMinPress{$sta}\n";
}

foreach $sta (sort{$a<=>$b} keys(%fluorMax)) {
    print NEWFILE3 "$sta,$fluorMax{$sta},$fluorMaxPress{$sta}\n";
}

close NEWFILE1;
close NEWFILE2;
close NEWFILE3;

exit;
