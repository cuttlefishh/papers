#!/usr/bin/perl -w
use strict;
use FileHandle;
my $usage = qq{
    $0 <barcode file> <file 1> <file 2>...  

    <barcode file>: the file of the barcodes
    <file 1>: illumina read file in fastq format
    <file 2>: if any more read file
    
    Description: this script is used to sort illumina reads (fastq format) by the barcode encoded in the reads' headers.
    The outputs are in each barcode's subdirectory and have the same file name(s) as the original fastq file(s)
};

die $usage unless @ARGV>=2;

my ($barcodeF, @files) = @ARGV;

my %barcodes = (); #hash table for the barcodes

# not categorized class:
$barcodes{"NC"} = 1;

unless (-d "NC"){
    mkdir "NC" #or die "Can't create NC directory:$!\n";
}

# read in all barcodes from the barcode file
# store the barcodes in %barcodes
# create a directory for each barcode
print "Found barcodes:\n";
open BARCODE, $barcodeF or die "Can't open file $barcodeF:$!\n";
while(<BARCODE>){
    if (/^[\w\W]+\s(\w+)\n/){
        # barcode line
        print $1."\n";
        $barcodes{$1} = 1; # store the barcode in the hash table
        
	unless (-d $1){
	    mkdir $1 #or die "Can't create $1 directory:$!\n"; #make the sub-directory for each barcode
	}
    }
}
close BARCODE;

# create all the read files for each barcode
my %handles = ();
foreach my $bar (keys %barcodes){
    foreach my $file (@files){
        my $fh = FileHandle->new("> $bar/$file");
        $handles{"$bar/$file"} = $fh; # the value of each barcode in the %handles table is the file handler
    }
}

# sort all the reads in all fastq input files
foreach my $file (@files){
    my $fh = $handles{"NC/$file"};
    open READ, "$file" or die "Can't open $file:$!\n";
    while(my $line = <READ>){
        if ($line =~ /^\@/){ # the header line that contains the barcode
            #print $line;
            # find the barcode and the corresponding output file:
	    $fh = $handles{"NC/$file"}; # by default	
            map{
                if ($line =~ /$_/){
                    $fh = $handles{"$_/$file"};
                }
            } keys %barcodes;
        }
        print $fh $line; #once the correct output file is determined, print the line from the original file to the output file
    }
    close READ;   
}

# close all output files
foreach my $foo (keys %handles){
    my $fh = $handles{$foo};
    close $fh;
}

exit;

