#!/usr/bin/perl

$usage = qq{

    humannCombineTaxa.pl <humannoutput>

        <humannoutput> e.g. 01-hit-keg.txt

        Combines taxonomic data (from humann) for Illumina samples.


};

die "$usage" if @ARGV == 0;

foreach $file (@ARGV) {
    open (FILE, $file) or die "No likey the file $file!";
    @data = <FILE>;
    close FILE;

    # store humann data to hash
    foreach $line (@data) {
        if ($line =~ m/^#.*/) {
            chomp $line;
            @fields = split(/\t/,$line);
            $genome = $fields[1];
            $count = $fields[2];
            $hash{$genome} .= ",$count";
        }
    }
}

# print header
print "genome";
for ($i=1; $i <= 45; $i++) {
    print ",SAMP$i.1,SAMP$i.2";
}
print "\n";

# print data
foreach $key ( sort keys %hash ) {
    print "$key$hash{$key}\n";
}

exit;

