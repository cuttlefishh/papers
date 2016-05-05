HUMAnN2 output (not in this directory) were generated with the following humann2 commands and additional scripts.

### Custom ChocoPhlAn database

1. Run MetaPhlAn2 on all samples. `humann2_step1_metaphlan2_1-9.pbs` `humann2_step1_metaphlan2_10-45.pbs`
2. Merge bugs lists. `humann2_step2_bugslist.sh`
3. Add headers and second column.
4. Add taxa I know I need (most of these are not in bugs_list already) ...

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


5. `~/krse2011/metaphlan2/bugs_list.tsv` now has 389 lines (388 genomes out of 4178 in ChocoPhlAn)
6. Build bowtie2 database. `humann2_step3_ntindex.pbs`

### Run HUMAnN2

1. Run HUMAnN2 with nucleotide and translated search. Script: `humann2_step4_humann2.pbs`
Didn't work until I set specified the bowtie2 database directly as `--nucleotide-database $HOME/krse2011/humann2/` `sample01.1.prinseq_humann2_temp/sample01.1.prinseq_bowtie2_index` and set memory requirement as `#PBS -l nodes=1:ppn=8 -l pmem=16gb`.

2. Join tables. Script: `humann2_step5_join_tables.sh`

		humann2_join_tables --input /home/luth1104/krse2011/humann2/2016-v0.7.0/ --file_name genefamilies --output /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies.tsv
		humann2_join_tables --input /home/luth1104/krse2011/humann2/2016-v0.7.0/ --file_name pathabundance --output /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_pathabundance.tsv
		humann2_join_tables --input /home/luth1104/krse2011/humann2/2016-v0.7.0/ --file_name pathcoverage --output /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_pathcoverage.tsv
		
3. Normalize HUMAnN2 output as follows: genefamilies - cpm (copies per million); pathabundance - relab (relative abundance); pathcoverage - none. (Note: relab columns sum to 2 because of duplicate stratified output; cpm columns sum to 2,000,000 because of duplicate stratified output.) Script: `humann2_step6_renorm_table.sh`

		humann2_renorm_table --input /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies.tsv --norm cpm --output /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm.tsv
		humann2_renorm_table --input /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_pathabundance.tsv --norm relab --output /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_pathabundance_relab.tsv

4. Regroup (collapse) genefamilies table into KO, GO, EC, and metacyc rxn. Script: `humann2_step7_regroup_table.sh`

		humann2_regroup_table -i /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm.tsv -g uniref50_ec -o /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm_ec.tsv
		humann2_regroup_table -i /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm.tsv -g uniref50_rxn -o /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm_rxn.tsv
		humann2_regroup_table -i /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm.tsv -c /home/luth1104/bin/humann2_misc/map_ko_uniref50.txt -o /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm_ko.tsv
		humann2_regroup_table -i /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm.tsv -c /home/luth1104/bin/humann2_misc/map_infogo1000_uniref50.txt -o /home/luth1104/krse2011/humann2/krse2011_R1_prinseq_genefamilies_cpm_go.tsv

5. Split strat/unstrat. Split above four plus `*pathabundance_relab.tsv` and `*pathcoverage.tsv` into stratified and unstratified. Script: `humann2_step8_split.pbs`.

		# split into unstratified and stratified
		cat /home/luth1104/krse2011/humann2/${I}.tsv | grep -v "|" > /home/luth1104/krse2011/humann2/${I}_unstrat.tsv
		head -n 1 /home/luth1104/krse2011/humann2/${I}.tsv > /home/luth1104/krse2011/humann2/${I}_strat.tsv; cat /home/luth1104/krse2011/humann2/${I}.tsv | grep "|" >> /home/luth1104/krse2011/humann2/${I}_strat.tsv

