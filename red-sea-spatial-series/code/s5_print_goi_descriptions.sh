# print out descriptions for genes of interest
cat ../humann/humann_KOrelAbund.list | grep `cat goi_CCA_filt3.grep`

# # print out top 20 CAP1 genes, CAP2 genes, CAP1 pathways, CAP2 pathways
# echo "TOP 20 CAP1 GENES"; cat CAP_loadings_genes_sort_CAP1.tsv | head -n 21 | tail -n +2 | perl -ane 'print "@F[0]\\\|"' | perl -pe 'chomp; chop; chop' > temp; cat ../humann/humann_KOrelAbund.list | grep `cat temp`; /bin/rm temp
# echo "TOP 20 CAP2 GENES"; cat CAP_loadings_genes_sort_CAP2.tsv | head -n 21 | tail -n +2 | perl -ane 'print "@F[0]\\\|"' | perl -pe 'chomp; chop; chop' > temp; cat ../humann/humann_KOrelAbund.list | grep `cat temp`; /bin/rm temp
# echo "TOP 20 CAP1 PATHWAYS"; cat CAP_loadings_pathways_sort_CAP1.tsv | head -n 21 | tail -n +2 | perl -ane 'print "@F[0]\\\|"' | perl -pe 'chomp; chop; chop' > temp; cat ../humann/humann_pathwayRelAbund.list | grep `cat temp`; /bin/rm temp
# echo "TOP 20 CAP2 PATHWAYS"; cat CAP_loadings_pathways_sort_CAP2.tsv | head -n 21 | tail -n +2 | perl -ane 'print "@F[0]\\\|"' | perl -pe 'chomp; chop; chop' > temp; cat ../humann/humann_pathwayRelAbund.list | grep `cat temp`; /bin/rm temp


