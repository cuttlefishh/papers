perl -lne '@F = split /\t/; print "$F[0]\t$F[1]\t$F[11]" if $F[1] ne "NaN"' june30_pathwayRelAbund_p05_sort_b0.tsv > june30_pathwayRelAbund_p05_sort_b0_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[2]\t$F[11]" if $F[2] ne "NaN"' june30_pathwayRelAbund_p05_sort_b1depth.tsv > june30_pathwayRelAbund_p05_sort_b1depth_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[3]\t$F[11]" if $F[3] ne "NaN"' june30_pathwayRelAbund_p05_sort_b2temp.tsv > june30_pathwayRelAbund_p05_sort_b2temp_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[4]\t$F[11]" if $F[4] ne "NaN"' june30_pathwayRelAbund_p05_sort_b3salinity.tsv > june30_pathwayRelAbund_p05_sort_b3salinity_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[5]\t$F[11]" if $F[5] ne "NaN"' june30_pathwayRelAbund_p05_sort_b4oxygen.tsv > june30_pathwayRelAbund_p05_sort_b4oxygen_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[6]\t$F[11]" if $F[6] ne "NaN"' june30_pathwayRelAbund_p05_sort_b5fluor.tsv > june30_pathwayRelAbund_p05_sort_b5fluor_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[7]\t$F[11]" if $F[7] ne "NaN"' june30_pathwayRelAbund_p05_sort_b6turbidity.tsv > june30_pathwayRelAbund_p05_sort_b6turbidity_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[8]\t$F[11]" if $F[8] ne "NaN"' june30_pathwayRelAbund_p05_sort_b7nitrate.tsv > june30_pathwayRelAbund_p05_sort_b7nitrate_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[9]\t$F[11]" if $F[9] ne "NaN"' june30_pathwayRelAbund_p05_sort_b8phosphate.tsv > june30_pathwayRelAbund_p05_sort_b8phosphate_signif.tsv
perl -lne '@F = split /\t/; print "$F[0]\t$F[10]\t$F[11]" if $F[10] ne "NaN"' june30_pathwayRelAbund_p05_sort_b9silicate.tsv > june30_pathwayRelAbund_p05_sort_b9silicate_signif.tsv

