#!/usr/bin/perl

$usage = qq{

    mikyoungBetaPvalue.pl <betas> <pvals> <cutoff> <outfile>

        <betas>    june30_pathwayRelAbund.tsv
        <pvals>    june30_pathwayRelAbund_pvalue1.tsv
        <cutoff>   0.05 (p-value cutoff)
        <outfile>  june30_pathwayRelAbund_p05.tsv

        Checks p-values of corresponding beta values and prints those
        less than cutoff.

        Input files have colnames (headers) and rownames (pathways/
        modules/genes).


};

die "$usage" unless @ARGV == 4;

$file1   = $ARGV[0];
$file2   = $ARGV[1];
$cutoff  = $ARGV[2];
$outfile = $ARGV[3];

open (FILE, $file1) or die "No likey the file $file1!";
@data1 = <FILE>;
close FILE;

open (FILE, $file2) or die "No likey the file $file2!";
@data2 = <FILE>;
close FILE;

open(NEWFILE,">$outfile") or die "Cannot open file to write to!\n";

# store beta values to hash
$sampleno = -1; # header will be sampleno 0
foreach $line (@data1) {
    chomp $line;
    $sampleno += 1;
    unless ($sampleno==0) { # unless header, split and store data
        @fields = split(/\t/,$line); # path,alpha,eta,epsilon,beta0,..,beta9,optim
        $path = shift(@fields);
        $hash_beta{$path} = "$fields[3]\t$fields[4]\t$fields[5]\t$fields[6]\t$fields[7]\t$fields[8]\t$fields[9]\t$fields[10]\t$fields[11]\t$fields[12]"; # beta0,..,beta9
    }
}

# store p-values to hash
$sampleno = -1; # header will be sampleno 0
foreach $line (@data2) {
    chomp $line;
    $sampleno += 1;
    unless ($sampleno==0) { # unless header, split and store data
        @fields = split(/\t/,$line); # path,pval0,..,pval9
        $path = shift(@fields);
        $hash_pval{$path} = "$fields[0]\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t$fields[5]\t$fields[6]\t$fields[7]\t$fields[8]\t$fields[9]"; # pval0,..,pval9
    }
}

# print header (description will be added in shell script wrapper)
print NEWFILE "pathway\tb0\tb1_depth\tb2_temp\tb3_salinity\tb4_oxygen\tb5_fluor\tb6_turbidity\tb7_nitrate\tb8_phosphate\tb9_silicate\tdescription\n";

# print betas with pvalues < cutoff
foreach $key (sort keys %hash_beta) {
    print NEWFILE "$key";
    @BETAS = split(/\t/,$hash_beta{$key});
    @PVALS = split(/\t/,$hash_pval{$key});
    for ($i=0; $i<=9; $i++) {
        if (($PVALS[$i] < $cutoff) && ($PVALS[$i] ne "NA")) {
            print NEWFILE "\t$BETAS[$i]";
        } else {
            print NEWFILE "\tNaN";
        }
    }
    print NEWFILE "\n";
}

close NEWFILE;

exit;

