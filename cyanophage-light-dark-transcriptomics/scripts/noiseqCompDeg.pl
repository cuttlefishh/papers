#!/usr/bin/perl

$usage = qq{

    noiseqCompDeg.pl <mynoiseq.up...tsv> x5 <mynoiseq.dn...tsv> x5 <genes.tsv>

	<mynoiseq.deg.csv>: list of differentially expressed genes with 13 fields
            e.g. mynoiseqHo.up.inf_lt_0h_vs_ctr.tsv
	<genes.tsv>: list of genes, tab-delimited 3 fields: geneNo/length/descr

	This script goes through comparisons of infected versus control for 5
        timepoints (up-reg and down-reg lists) and combines the files to make a
        table of all genes up- or down-regulated in any condition.  Fields in
        table are:
            1. Gene_number
            2. P_sum - sum of probablilities ONLY for timepoints where diff expr
            3. R_sum - sum of ranking values ONLY for timepoints where diff expr
            4. t=0h - probability up (+) or down (-) at t=0h
            5. t=1h - probability up (+) or down (-) at t=1h
            6. t=2h - probability up (+) or down (-) at t=2h
            7. t=4h - probability up (+) or down (-) at t=4h
            8. t=8h - probability up (+) or down (-) at t=8h
            9. Description


};

die "$usage" unless @ARGV == 11;

$file0hUp = $ARGV[0];
$file1hUp = $ARGV[1];
$file2hUp = $ARGV[2];
$file4hUp = $ARGV[3];
$file8hUp = $ARGV[4];
$file0hDn = $ARGV[5];
$file1hDn = $ARGV[6];
$file2hDn = $ARGV[7];
$file4hDn = $ARGV[8];
$file8hDn = $ARGV[9];
$fileGene = $ARGV[10];

open (FILE, $file0hUp) or die "Cannot open $file0hUp!";
@data0hUp = <FILE>;
close FILE;

open (FILE, $file1hUp) or die "Cannot open $file1hUp!";
@data1hUp = <FILE>;
close FILE;

open (FILE, $file2hUp) or die "Cannot open $file2hUp!";
@data2hUp = <FILE>;
close FILE;

open (FILE, $file4hUp) or die "Cannot open $file4hUp!";
@data4hUp = <FILE>;
close FILE;

open (FILE, $file8hUp) or die "Cannot open $file8hUp!";
@data8hUp = <FILE>;
close FILE;

open (FILE, $file0hDn) or die "Cannot open $file0hDn!";
@data0hDn = <FILE>;
close FILE;

open (FILE, $file1hDn) or die "Cannot open $file1hDn!";
@data1hDn = <FILE>;
close FILE;

open (FILE, $file2hDn) or die "Cannot open $file2hDn!";
@data2hDn = <FILE>;
close FILE;

open (FILE, $file4hDn) or die "Cannot open $file4hDn!";
@data4hDn = <FILE>;
close FILE;

open (FILE, $file8hDn) or die "Cannot open $file8hDn!";
@data8hDn = <FILE>;
close FILE;

open (FILE, $fileGene) or die "Cannot open $fileGene!";
@dataGene = <FILE>;
close FILE;

foreach $line (@data0hUp) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash0hUp{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data1hUp) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash1hUp{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data2hUp) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash2hUp{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data4hUp) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash4hUp{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data8hUp) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash8hUp{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data0hDn) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash0hDn{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data1hDn) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash1hDn{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data2hDn) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash2hDn{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data4hDn) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash4hDn{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@data8hDn) {
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $prob = $fields[5];
    $rank = $fields[6];
    $hash8hDn{$seqid} = $prob;
    $hashProb{$seqid} += $prob;
    $hashRank{$seqid} += $rank;
}

foreach $line (@dataGene) {
    $flag0h = 0;
    $flag1h = 0;
    $flag2h = 0;
    $flag4h = 0;
    $flag8h = 0;
    chomp $line;
    @fields = split(/\t/, $line);
    $seqid = $fields[0];
    $descr = $fields[2];
    $hashDescr{$seqid} = $descr;
    foreach $key (keys %hash0hUp) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "$hash0hUp{$seqid}+";
	    $flag0h = 1;
	}
    }
    foreach $key (keys %hash0hDn) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "$hash0hDn{$seqid}-";
	    $flag0h = 1;
	}
    }
    if ($flag0h == 0) {
	$hashList{$seqid} .= "";
    }
    foreach $key (keys %hash1hUp) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash1hUp{$seqid}+";
	    $flag1h = 1;
	}
    }
    foreach $key (keys %hash1hDn) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash1hDn{$seqid}-";
	    $flag1h = 1;
	}
    }
    if ($flag1h == 0) {
	$hashList{$seqid} .= "\t";
    }
    foreach $key (keys %hash2hUp) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash2hUp{$seqid}+";
	    $flag2h = 1;
	}
    }
    foreach $key (keys %hash2hDn) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash2hDn{$seqid}-";
	    $flag2h = 1;
	}
    }
    if ($flag2h == 0) {
	$hashList{$seqid} .= "\t";
    }
    foreach $key (keys %hash4hUp) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash4hUp{$seqid}+";
	    $flag4h = 1;
	}
    }
    foreach $key (keys %hash4hDn) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash4hDn{$seqid}-";
	    $flag4h = 1;
	}
    }
    if ($flag4h == 0) {
	$hashList{$seqid} .= "\t";
    }
    foreach $key (keys %hash8hUp) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash8hUp{$seqid}+";
	    $flag8h = 1;
	}
    }
    foreach $key (keys %hash8hDn) {
	if ($seqid eq $key) {
	    $hashList{$seqid} .= "\t$hash8hDn{$seqid}-";
	    $flag8h = 1;
	}
    }
    if ($flag8h == 0) {
	$hashList{$seqid} .= "\t";
    }
}

print "Gene_number\tP_sum\tR_sum\tt=0h\tt=1h\tt=2h\tt=4h\tt=8h\tDescription\n";

foreach $key (sort{$hashProb{$b}<=>$hashProb{$a}} keys(%hashProb)) {
    if ($key =~ /MED4|PHM2/) {
	$prob = sprintf("%1.3f", $hashProb{$key}); #round to 3 decimal places
	$rank = sprintf("%1.0f", $hashRank{$key}); #round to no decimal places
	print "$key\t$prob\t$rank\t$hashList{$key}\t$hashDescr{$key}\n";
    }
}

exit;
