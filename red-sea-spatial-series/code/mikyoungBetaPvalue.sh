perl ~/scripts/myscripts/mikyoungBetaPvalue.pl june30_pathwayCoverage.tsv june30_pathwayCoverage_pvalue1.tsv 0.05 june30_pathwayCoverage_p05.tsv
perl ~/scripts/myscripts/mikyoungBetaPvalue.pl june30_pathwayRelAbund.tsv june30_pathwayRelAbund_pvalue1.tsv 0.05 june30_pathwayRelAbund_p05.tsv

perl ~/scripts/myscripts/hashLookup_v1.pl june30_pathwayCoverage_p05.tsv ~/krse2011/humann/humann_pathwayCoverage.tsv 0 0 1 > temp; mv temp june30_pathwayCoverage_p05.tsv
perl ~/scripts/myscripts/hashLookup_v1.pl june30_pathwayRelAbund_p05.tsv ~/krse2011/humann/humann_pathwayRelAbund.tsv 0 0 1 > temp; mv temp june30_pathwayRelAbund_p05.tsv

