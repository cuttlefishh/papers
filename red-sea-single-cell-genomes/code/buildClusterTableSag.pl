#!/usr/bin/perl

$usage = qq{

    buildClusterTableSag.pl <clusters> <cat_of_gbk.tsv> <outfile>

        <clusters> e.g. groups.all_pro.txt
        <cat_of_gbk.tsv> e.g. pro.gbk.tsv
        <outfile> e.g. table.all_pro.txt

    Builds table of COGs with size and acc-no,locus-tag,description


};

die "$usage" unless @ARGV == 3;

$file_clusters = $ARGV[0];
$file_genbank = $ARGV[1];
$file_out = $ARGV[2];

open (FILE, $file_clusters) or die "No likey the file $file_clusters!";
@data_clusters = <FILE>;
close FILE;

open (FILE, $file_genbank) or die "No likey the file $file_genbank!";
@data_genbank = <FILE>;
close FILE;

open(NEWFILE,">$file_out") or die "Cannot open file to write to!\n";

#store clusters data as cluster=>accnos
foreach $line (@data_clusters) {
    chomp $line;
    ($cluster,
     @members) = split(/ /, $line);
    $cluster =~ s/([A-Z0-9]*):/$1/;
    @members = sort(@members);
    foreach $line (@members) {
	$line =~ s/gnl\|[A-Z0-9]{3,4}\|(.*)/$1/;
	$hash_clusters{$cluster} .= "$line,";
    }
}

#store genbank data as accno=>locus_tag,product
foreach $line (@data_genbank) {
    chomp $line;
    ($genome,
     $locus_tag,
     $product) = split(/\t/, $line);
    $hash_genbank{$locus_tag} = "$genome\t$product\t$locus_tag";
}

#match clusters/accnos to locus tags and products and write to new file
foreach $key (sort(keys %hash_clusters)) {
    $value = $hash_clusters{$key};
    chop $value;
    @accnos = split(/,/, $value);
    print NEWFILE "****************************** $key ******************************\n";
    $size_accnos = @accnos;
    print NEWFILE "SIZE:$size_accnos\n";
    foreach $entry (@accnos) {
	@info = split(/\t/, $hash_genbank{$entry});
	print NEWFILE "$info[0]\t$info[1]\t$info[2]\n";
    }
    print NEWFILE "\n";
}

close NEWFILE;

exit;
