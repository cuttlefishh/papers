#!/usr/bin/perl

$usage = qq{

    sagGosHitsToClusters.pl <clusters> <top1ct>

        <clusters> e.g. groups.all.prodigal3.txt
        <top1ct> e.g. GS000a.usearch.allProdigal3.top1ct

    Makes hash table from clusters with protein=>cluster. Then
    goes through each line of count data, finds protein in hash,
    and adds the count to a second hash with cluster=>sum.
    Prints to standard output.


};

die "$usage" unless @ARGV == 2;

$file_cluster = $ARGV[0];
$file_counts = $ARGV[1];

open (FILE, $file_cluster) or die "No likey the file $file_cluster!";
@DATA_CLUSTER = <FILE>;
close FILE;

open (FILE, $file_counts) or die "No likey the file $file_counts!";
@DATA_COUNTS = <FILE>;
close FILE;

foreach $line (@DATA_CLUSTER) {
    chomp $line;
    @fields = split(/ /, $line);
    $cluster = shift(@fields);
    chop $cluster;
    foreach $protein (@fields) {
	$hash1{$protein} = $cluster;
    }
}

foreach $line (@DATA_COUNTS) {
    chomp $line;
    @fields = split(/\s+/, $line);
    $count = $fields[1];
    $protein = $fields[2];
    $cluster = $hash1{$protein};
    $hash_sum{$cluster} += $count;
}

foreach $key (sort(keys %hash_sum)) {
    print "$key\t$hash_sum{$key}\n";
}

exit;

