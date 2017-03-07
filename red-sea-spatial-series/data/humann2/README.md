### HUMAnN2 of Red Sea metagenomes using custom pangenome database

#### KO observation tables

* `krse2011_humann2_ko_cpm_strat.tsv` KO relative abundances "stratified" by pangenome
* `krse2011_humann2_ko_cpm_unstrat.tsv` KO relative abundances summed over all pangenomes ("unstratified")

#### Methods

We applied [HUMAnN2](https://bitbucket.org/biobakery/humann2) to profile 45 metagenomes collected during the 2011 KAUST Red Sea Expedition, which were previously analyzed using HUMAnN1 ([Thompson et al., 2016](http://dx.doi.org/10.1038/ismej.2016.99)). 

##### Main processing

MetaPhlAn2 was run on all samples as a "joint prescreen" for all samples. In other words, if a species was detected in any of the 45 metagenomes, then its pangenome was included in the analysis of all samples. This "dataset-specific" (versus sample-specific) pangenome was used to add robustness to missing MetaPhlAn2 marker genes, which we expect to be more common in less-well-characterized communities. Pangenomes (388) were selected in this manner, including many examples from known marine clades, such as *Nitrospina*, *Nitrospira*, *Prochlorococcus*, *Synechococcus*, *Synechocystis*, *Candidatus* Pelagibacter, alphaproteobacterium (SAR11 clade), *Polymorphum*, and SAR116 cluster. Each sample was then profiled against the custom pangenome database and UniRef50 protein database via tiered search. 

Commands:

```bash
$ metaphlan2.py sample0${PBS_ARRAYID}.1.prinseq.fasta --mpa_pkl mpa_v20_m200.pkl --bowtie2db mpa_v20_m200 --bowtie2out sample0${PBS_ARRAYID}.bowtie2.bz2 --nproc 8 --input_type fasta > sample0${PBS_ARRAYID}.metaphlan2.txt
$ cat *.metaphlan2.txt | perl -ne '@F = split /\t/; print "$F[0]\n"' | sort | uniq > bugs_list.tsv

Add to bugs_lists.tsv:
g__Nitrospina.s__Nitrospina_gracilis 0.001
g__Nitrospina.s__Nitrospina_sp_AB_629_B06 0.001
g__Nitrospina.s__Nitrospina_sp_AB_629_B18 0.001
g__Nitrospina.s__Nitrospina_sp_SCGC_AAA288_L16 0.001
g__Nitrospira.s__Candidatus_Nitrospira_defluvii 0.001
g__Prochlorococcus.s__Prochlorococcus_marinus 0.001
g__Synechococcus.s__Synechococcus_elongatus 0.001
g__Synechococcus.s__Synechococcus_sp_BL107 0.001
g__Synechococcus.s__Synechococcus_sp_CB0101 0.001
g__Synechococcus.s__Synechococcus_sp_CB0205 0.001
g__Synechococcus.s__Synechococcus_sp_CC9311 0.001
g__Synechococcus.s__Synechococcus_sp_CC9605 0.001
g__Synechococcus.s__Synechococcus_sp_CC9902 0.001
g__Synechococcus.s__Synechococcus_sp_JA_2_3B_a_2_13 0.001
g__Synechococcus.s__Synechococcus_sp_JA_3_3Ab 0.001
g__Synechococcus.s__Synechococcus_sp_PCC_6312 0.001
g__Synechococcus.s__Synechococcus_sp_PCC_7002 0.001
g__Synechococcus.s__Synechococcus_sp_PCC_7335 0.001
g__Synechococcus.s__Synechococcus_sp_PCC_7336 0.001
g__Synechococcus.s__Synechococcus_sp_PCC_7502 0.001
g__Synechococcus.s__Synechococcus_sp_RCC307 0.001
g__Synechococcus.s__Synechococcus_sp_RS9916 0.001
g__Synechococcus.s__Synechococcus_sp_RS9917 0.001
g__Synechococcus.s__Synechococcus_sp_WH_5701 0.001
g__Synechococcus.s__Synechococcus_sp_WH_7803 0.001
g__Synechococcus.s__Synechococcus_sp_WH_7805 0.001
g__Synechococcus.s__Synechococcus_sp_WH_8016 0.001
g__Synechococcus.s__Synechococcus_sp_WH_8102 0.001
g__Synechococcus.s__Synechococcus_sp_WH_8109 0.001
g__Synechocystis.s__Synechocystis_sp_PCC_6803 0.001
g__Synechocystis.s__Synechocystis_sp_PCC_7509 0.001
g__Candidatus_Pelagibacter.s__Candidatus_Pelagibacter_sp_HTCC7211 0.001
g__Candidatus_Pelagibacter.s__Candidatus_Pelagibacter_sp_IMCC9063 0.001
g__Candidatus_Pelagibacter.s__Candidatus_Pelagibacter_ubique 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_BAL199 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_HIMB114 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_HIMB59 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_HIMB5 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA024_N17 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA027_C06 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA027_J10 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA027_L15 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA280_B11 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA280_P20 0.001
g__Alphaproteobacteria_noname.s__alpha_proteobacterium_SCGC_AAA300_J04 0.001
g__Alphaproteobacteria_noname.s__Polymorphum_gilvum 0.001
g__Alphaproteobacteria_noname.s__SAR116_cluster_alpha_proteobacterium_HIMB100 0.001

$ humann2 -i sample01.1.prinseq.fasta -o . -v --threads 1 --bypass-prescreen --taxonomic-profile bugs_list.tsv --bypass-translated-search
$ humann2 -i ${PBS_ARRAYID} -o . -v --threads 8 --memory maximum --bypass-prescreen --bypass-nucleotide-index --nucleotide-database sample01.1.prinseq_bowtie2_index --protein-database uniref
```

##### Post-processing

UniRef50 abundances were regrouped to KO abundances using UniRef50-to-KO mapping to enable comparison with HUMAnN1-based profiles. KO abundances were then normalized over total reads using the counts per million (CPM) method. UNMAPPED and UNGROUPED reads were included in the total counts, which gives an indication of the total mass of reads assigned (or not) to KOs across samples.

Commands:

```bash
$ humann2_join_tables --input . --output all_samples.tsv --file_name genefamilies.tsv --verbose
$ humann2_regroup_table --input all_samples.tsv --output all_samples_KOs.tsv --group uniref50_ko
$ humann2_renorm_table --input all_samples_KOs.tsv --output all_samples_KOs_renorm.tsv --units cpm
$ humann2_split_stratified_table --input all_samples_KOs_renorm.tsv --output split_stratified_output
```

<!--
Original Feature Count: 750230; Grouped 1+ times: 144556 (19.3%); Grouped 2+ times: 498 (0.1%)
-->

