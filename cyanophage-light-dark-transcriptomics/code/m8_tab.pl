#!/usr/bin/perl

## this script reads an -m 8 blast file and prints the requested field (0,1,2,...)
## usage: perl m8_seqid.pl <input blast file> <field number>
## splits input file using \t (whitespace: tab only)


my $field;

$field = $ARGV[1];

open(IN, $ARGV[0]) or die "cannot open file $ARGV[0]\n";

while ($line = <IN>)  {
    chomp $line;
    @info = split(/\t/,$line);
    $seqid = $info[$field];
    print $seqid, "\n";
}
