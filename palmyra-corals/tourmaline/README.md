## Tourmaline DADA2 workflow

### Format metadata

Master mapping file from Austin (14693_analysis_mapping_cleaned.tsv); then added coral_health_plus_year, position_plus_year, and species_code (14693_analysis_mapping_cleaned_LT.tsv); then split into Bleaching and Corallimorph:

```python
cd /Users/luke.thompson/carter/metadata
import pandas as pd
df = pd.read_csv('14693_analysis_mapping_cleaned_LT.txt', sep='\t', index_col=0)
df_b = df[df.stressor == 'Bleaching']
df_c = df[df.stressor == 'Corallimorph']
dict_zone = {1:'AB', 2:'AB', 3:'CD', 4:'CD', 5:'EF', 6:'EF'}
c_zone = [dict_zone[int(x)] for x in df_c.position]
df_c.insert(69, 'zone', c_zone)
c_zone_plus_year = ['%s_%s' % (df_c.zone[x], df_c.year[x]) for x in df_c.index]
df_c.insert(70, 'zone_plus_year', c_zone_plus_year)
df_b.to_csv('14693_analysis_mapping_cleaned_bleaching.txt', sep='\t')
df_c.to_csv('14693_analysis_mapping_cleaned_corallimorph.txt', sep='\t')
```

### Import metadata

Mapping files for demultiplexing are `10798_prep_4161_qiime_20180418-105730.txt` (1-3) and `10798_prep_4163_qiime_20180418-105731.txt` (4-6) downloaded from Qiita https://qiita.ucsd.edu/study/description/10798. Metadata files for analysis are `14693_analysis_mapping_cleaned_bleaching.txt` and `14693_analysis_mapping_cleaned_corallimorph.txt` described above.

Set up data and imported directories:

```
cd /home/luth1104/carter/tourmaline-bleaching/00-data
ln -s /home/luth1104/carter/metadata/14693_analysis_mapping_cleaned_bleaching.txt metadata.tsv
cd /home/luth1104/carter/tourmaline-corallimorph/00-data
ln -s /home/luth1104/carter/metadata/14693_analysis_mapping_cleaned_corallimorph.txt metadata.tsv
```

### Import fastq

Sequences from Qiita study 10798 were found on Barnacle. They are EMP format so we can import them as a QIIME 2 artifact using `qiime tools import --type EMPPairedEndSequences`.

NOTE: 1-3 and 4-6 have to be demultiplexed SEPARATELY: first import to EMPPairedEndSequences, then demultiplex to PairedEndSequencesWithQuality, which is required by Deblur and DADA2. Then I can split them up by "bleaching" and "corallimorph" projects before running Tourmaline separately for the two projects.

Make symbolic links:

```
cd /home/luth1104/carter/fastq/Carter_Coral_1-3
ln -s /sequencing/ucsd/complete_runs/171120_M05314_0042_000000000-B6H23/Carter_Coral_1-3_S1_L001_I1_001.fastq.gz barcodes.fastq.gz
ln -s /sequencing/ucsd/complete_runs/171120_M05314_0042_000000000-B6H23/Carter_Coral_1-3_S1_L001_R1_001.fastq.gz forward.fastq.gz
ln -s /sequencing/ucsd/complete_runs/171120_M05314_0042_000000000-B6H23/Carter_Coral_1-3_S1_L001_R2_001.fastq.gz reverse.fastq.gz
cd /home/luth1104/carter/fastq/Carter_Coral_4-6
ln -s /sequencing/ucsd/complete_runs/171121_M05314_0043_000000000-BH92J/Carter_Coral_4-6_1_burned_S1_L001_I1_001.fastq.gz barcodes.fastq.gz
ln -s /sequencing/ucsd/complete_runs/171121_M05314_0043_000000000-BH92J/Carter_Coral_4-6_1_burned_S1_L001_R1_001.fastq.gz forward.fastq.gz
ln -s /sequencing/ucsd/complete_runs/171121_M05314_0043_000000000-BH92J/Carter_Coral_4-6_1_burned_S1_L001_R2_001.fastq.gz reverse.fastq.gz
```

Import EMP paired-end sequences:

```
cd /home/luth1104/carter/fastq
qiime tools import \
  --type EMPPairedEndSequences \
  --input-path Carter_Coral_1-3 \
  --output-path emp_paired_end_sequences_1-3.qza
qiime tools import \
  --type EMPPairedEndSequences \
  --input-path Carter_Coral_4-6 \
  --output-path emp_paired_end_sequences_4-6.qza
```

Demultiplex EMP paired-end sequences:

```
qiime demux emp-paired \
  --m-barcodes-file ../metadata/10798_prep_4161_qiime_20180418-105730.txt \
  --m-barcodes-column BarcodeSequence \
  --i-seqs emp_paired_end_sequences_1-3.qza \
  --o-per-sample-sequences demux_1-3.qza \
  --p-rev-comp-barcodes \
  --p-rev-comp-mapping-barcodes
qiime demux emp-paired \
  --m-barcodes-file ../metadata/10798_prep_4163_qiime_20180418-105731.txt \
  --m-barcodes-column BarcodeSequence \
  --i-seqs emp_paired_end_sequences_4-6.qza \
  --o-per-sample-sequences demux_4-6.qza \
  --p-rev-comp-barcodes \
  --p-rev-comp-mapping-barcodes
```

Unzip demuxed sequences to get manifests:

```
unzip demux_1-3.qza
mv ba93b5b8-c8cd-4fba-86c7-f0ef96a91e35/ demux_1-3
unzip demux_4-6.qza
mv 8664c70a-f92a-4937-8dca-ac6283f6cd34/ demux_4-6
```

Merge manifests:

```
echo "sample-id,absolute-filepath,direction" > /home/luth1104/carter/fastq/manifest_1-6.csv
tail -n +2 /home/luth1104/carter/fastq/demux_1-3/data/MANIFEST | sed 's|,10798|,/home/luth1104/carter/fastq/demux_1-3/data/10798|' >> /home/luth1104/carter/fastq/manifest_1-6.csv
tail -n +2 /home/luth1104/carter/fastq/demux_4-6/data/MANIFEST | sed 's|,10798|,/home/luth1104/carter/fastq/demux_4-6/data/10798|' >> /home/luth1104/carter/fastq/manifest_1-6.csv
```

Run `match_manifest_to_metadata.ipynb` on Mac (parameterized version: `~/scripts/myscripts/match_manifest_to_metadata.py`). Given a fastq manifest and a metadata file, this script will generate two new manfiests (one for paired-end, one for single-end) with samples correspoinding to the samples in the metadata file. Code:

```
import pandas as pd

# input paths
path_manifest = '/Users/luke.thompson/carter/metadata/manifest_1-6.csv'
path_metadata_b = '/Users/luke.thompson/carter/metadata/14693_analysis_mapping_cleaned_bleaching.txt'
path_metadata_c = '/Users/luke.thompson/carter/metadata/14693_analysis_mapping_cleaned_corallimorph.txt'

# output paths
path_manifest_b_pe = '/Users/luke.thompson/carter/metadata/manifest_bleaching_pe.csv'
path_manifest_b_se = '/Users/luke.thompson/carter/metadata/manifest_bleaching_se.csv'
path_manifest_c_pe = '/Users/luke.thompson/carter/metadata/manifest_corallimorph_pe.csv'
path_manifest_c_se = '/Users/luke.thompson/carter/metadata/manifest_corallimorph_se.csv'

# import manifest
df_manifest = pd.read_csv(path_manifest, index_col=0)

# import metadata
df_metadata_b = pd.read_csv(path_metadata_b, index_col=0, sep='\t')
df_metadata_c = pd.read_csv(path_metadata_c, index_col=0, sep='\t')

# select manifest rows matching metadata sample ids (paired-end and single-end)
df_manifest_b_pe = df_manifest.loc[df_metadata_b.index]
df_manifest_b_se = df_manifest[df_manifest.direction == 'forward'].loc[df_metadata_b.index]
df_manifest_c_pe = df_manifest.loc[df_metadata_c.index]
df_manifest_c_se = df_manifest[df_manifest.direction == 'forward'].loc[df_metadata_c.index]

# write to csv
df_manifest_b_pe.to_csv(path_manifest_b_pe)
df_manifest_b_se.to_csv(path_manifest_b_se)
df_manifest_c_pe.to_csv(path_manifest_c_pe)
df_manifest_c_se.to_csv(path_manifest_c_se)
```

Then scp these new manifest files to `barnacle:/home/luth1104/carter/fastq`. They will be the starting point for two Tourmaline instances. Make symbolic links to the manifests:

```
cd /home/luth1104/carter/tourmaline-bleaching/00-data
ln -s /home/luth1104/carter/fastq/manifest_bleaching_se.csv manifest_se.csv
ln -s /home/luth1104/carter/fastq/manifest_bleaching_pe.csv manifest_pe.csv
cd /home/luth1104/carter/tourmaline-corallimorph/00-data
ln -s /home/luth1104/carter/fastq/manifest_corallimorph_se.csv manifest_se.csv
ln -s /home/luth1104/carter/fastq/manifest_corallimorph_pe.csv manifest_pe.csv
```

### Import SILVA 16S 97% and 99% reference sequences and taxonomy for QIIME 2

Download SILVA v.132 QIIME version to Barnacle.

```
cd /home/luth1104/databases/silva
wget https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_132_release.zip
unzip Silva_132_release.zip
mv Silva_132_release silva_132_qiime
```

Sequences and taxonomy are already in QIIME 2-compatible format. I will use the taxonomy file `taxonomy_7_levels.txt`, but note this can be switched to another at any time. Below is shown for 99% but subsequently I switched to 97% (done inside snakemake).

```
cd /home/luth1104/databases/qiime2/16s
ln -s /home/luth1104/databases/silva/silva_132_qiime/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna silva_132_99_16S.fna
ln -s /home/luth1104/databases/silva/silva_132_qiime/taxonomy/16S_only/99/taxonomy_7_levels.txt silva_132_99_16S_taxonomy_7_levels.tsv
qiime tools import --type 'FeatureData[Sequence]' --input-path silva_132_99_16S_sequences.fna --output-path silva_132_99_16S_sequences.qza
qiime tools import --type 'FeatureData[Taxonomy]' --source-format HeaderlessTSVTaxonomyFormat --input-path silva_132_99_16S_taxonomy_7_levels.tsv --output-path silva_132_99_16S_taxonomy_7_levels.qza

cd /home/luth1104/carter/tourmaline-bleaching/01-imported
ln -s /home/luth1104/databases/qiime2/16s/silva_132_99_16S_sequences.qza refseqs.qza
ln -s /home/luth1104/databases/qiime2/16s/silva_132_99_16S_taxonomy_7_levels.qza reftax.qza
cd /home/luth1104/carter/tourmaline-corallimorph/01-imported
ln -s /home/luth1104/databases/qiime2/16s/silva_132_99_16S_sequences.qza refseqs.qza
ln -s /home/luth1104/databases/qiime2/16s/silva_132_99_16S_taxonomy_7_levels.qza reftax.qza
```

### Run Tourmaline (dada2-pe, dada2-se, deblur-se)

### Input files

Originally using SILVA 99% but now 97%.

```
ls -l /home/luth1104/carter/tourmaline-bleaching/00-data
manifest_pe.csv -> /home/luth1104/carter/fastq/manifest_bleaching_pe.csv
manifest_se.csv -> /home/luth1104/carter/fastq/manifest_bleaching_se.csv
metadata.tsv -> /home/luth1104/carter/metadata/14693_analysis_mapping_cleaned_bleaching.txt

ls -l /home/luth1104/carter/tourmaline-bleaching/01-imported
classifier.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_classifier_7_levels.qza
fastq_pe.qza
fastq_se.qza
refseqs.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_sequences.qza
reftax.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_taxonomy_7_levels.qza

ls -l /home/luth1104/carter/tourmaline-corallimorph/00-data
manifest_pe.csv -> /home/luth1104/carter/fastq/manifest_corallimorph_pe.csv
manifest_se.csv -> /home/luth1104/carter/fastq/manifest_corallimorph_se.csv
metadata.tsv -> /home/luth1104/carter/metadata/14693_analysis_mapping_cleaned_corallimorph.txt

ls -l /home/luth1104/carter/tourmaline-corallimorph/01-imported
classifier.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_classifier_7_levels.qza
fastq_pe.qza
fastq_se.qza
refseqs.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_sequences.qza
reftax.qza -> /home/luth1104/databases/qiime2/16s/silva_132_97_16S_taxonomy_7_levels.qza
```

#### Config files

Shown is for bleaching. Everything is the same for corallimorph except beta_group_column is position_plus_year.

```
# input files
manifest_se: 00-data/manifest_se.csv
manifest_pe: 00-data/manifest_pe.csv
metadata: 00-data/metadata.tsv
refseqs: 00-data/refseqs.fna
reftax: 00-data/reftax.tsv

# deblur
deblur_trim_length: 150
deblur_sample_stats: --p-sample-stats
deblur_mean_error: 0.005
deblur_indel_prob: 0.01
deblur_indel_max: 3
deblur_min_reads: 10
deblur_min_size: 2
deblur_jobs_to_start: 1
deblur_hashed_feature_ids: --p-hashed-feature-ids

# dada2 single-end
dada2se_trunc_len: 0
dada2se_trim_left: 0
dada2se_max_ee: 2
dada2se_trunc_q: 2
dada2se_chimera_method: consensus
dada2se_min_fold_parent_over_abundance: 1
dada2se_n_threads: 8
dada2se_n_reads_learn: 1000000
dada2se_hashed_feature_ids: --p-hashed-feature-ids

# dada2 paired-end
dada2pe_trunc_len_f: 0
dada2pe_trunc_len_r: 0
dada2pe_trim_left_f: 0
dada2pe_trim_left_r: 0
dada2pe_max_ee: 2
dada2pe_trunc_q: 2
dada2pe_chimera_method: consensus
dada2pe_min_fold_parent_over_abundance: 1
dada2pe_n_threads: 8
dada2pe_n_reads_learn: 1000000
dada2pe_hashed_feature_ids: --p-hashed-feature-ids

# subsampling
alpha_max_depth: 5000
core_sampling_depth: 5000

# statistics
beta_group_column: coral_health_plus_year
```

### PBS files

These were run in order. Note that snakemake output go to both standard output and standard error.

```
ls /home/luth1104/carter/jobs
10_demux.pbs
20_denoise.pbs
30_diversity.pbs
40_stats.pbs
50_report.pbs
studies.txt
```

### Post-processing

#### Filtering non-bacterial taxa

`qiime taxa filter-table` -- add rule to Tourmaline

```
qiime taxa filter-table \
  --i-table ~/carter/tourmaline-bleaching/02-denoised/dada2-pe/table.qza \
  --i-taxonomy ~/carter/tourmaline-bleaching/03-repseqs/dada2-pe/taxonomy.qza \
  --p-exclude Archaea,Chloroplast,Mitochondria \
  --o-filtered-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered.qza

qiime taxa filter-table \
  --i-table ~/carter/tourmaline-corallimorph/02-denoised/dada2-pe/table.qza \
  --i-taxonomy ~/carter/tourmaline-corallimorph/03-repseqs/dada2-pe/taxonomy.qza \
  --p-exclude Archaea,Chloroplast,Mitochondria \
  --o-filtered-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered.qza
```

#### Rarefy to 1000

`qiime feature-table rarefy` -- add rule to Tourmaline

```
qiime feature-table rarefy \
  --i-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered.qza \
  --p-sampling-depth 1000 \
  --o-rarefied-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered_rare1000.qza

qiime feature-table rarefy \
  --i-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered.qza \
  --p-sampling-depth 1000 \
  --o-rarefied-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered_rare1000.qza
```

#### Recalculating alpha diversity

`qiime diversity alpha` -- add rule to Tourmaline

```
qiime diversity alpha \
  --i-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered_rare1000.qza \
  --p-metric observed_otus \
  --o-alpha-diversity ~/carter/post-tourmaline/observed_otus_bleaching_filtered_rare1000.qza

qiime diversity alpha \
  --i-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered_rare1000.qza \
  --p-metric observed_otus \
  --o-alpha-diversity ~/carter/post-tourmaline/observed_otus_corallimorph_filtered_rare1000.qza

# unzip

# rename and move to ~/carter/post-tourmaline
```

#### Taxa barcharts

`qiime taxa collapse` -- add rule to Tourmaline

```
qiime taxa collapse \
  --i-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered.qza \
  --i-taxonomy ~/carter/tourmaline-bleaching/03-repseqs/dada2-pe/taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table ~/carter/post-tourmaline/bleaching_biom_dada2_pe_filtered_level5.qza

qiime taxa collapse \
  --i-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered.qza \
  --i-taxonomy ~/carter/tourmaline-corallimorph/03-repseqs/dada2-pe/taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table ~/carter/post-tourmaline/corallimorph_biom_dada2_pe_filtered_level5.qza
```

notebook: `carter_taxa_barcharts.ipynb`

#### Taxa heatmaps

notebook: `carter_taxa_heatmaps.ipynb`
