#!/usr/bin/perl

$usage = qq{

    hashLookup_csv_6char.pl <file1> <file2> <field1> <field2a> <field2b>

        <file1> table or list of IDs to look up (.csv)
        <file2> lookup table with two or more fields (.csv)
        <field1> field of file1 to match (eg 0)
        <field2a> field of file2 that matches file1 field
        <field2b> field of file2 that should be output

        Goes through each line of file1, and for each field1, finds the
        matching value in field2a of file2, then prints both the full
        line of file1 and the looked up value field2b.

        Files must be comma-delimited. Count fields from 0.
        ONLY FIRST 6 CHARACHTERS OF FIELD1 ARE CHECKED.


};

die "$usage" unless @ARGV == 5;

$file1 = $ARGV[0];
$file2 = $ARGV[1];
$field1 = $ARGV[2];
$field2a = $ARGV[3];
$field2b = $ARGV[4];

open (FILE, $file1) or die "Cannot open $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "Cannot open $file2!";
@data2 = <FILE>;
close FILE;

foreach $line (@data2) {
    chomp $line;
    @FIELDS2 = split(/,/, $line);
    $hash{$FIELDS2[$field2a]} = $FIELDS2[$field2b];
}

foreach $line (@data1) {
    chomp $line;
    @FIELDS1 = split(/,/, $line);
    # print "$FIELDS1[$field1],$hash{$FIELDS1[$field1]}\n";  #prints only one field from file1
    print "$line,$hash{substr($FIELDS1[$field1],0,6)}\n";  #prints all fields from file1
}

exit;
