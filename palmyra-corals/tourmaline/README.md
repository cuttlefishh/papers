## Tourmaline DADA2 workflow

### Clone Tourmaline repository once for each project

```
cd $HOME/carter
git clone https://github.com/NOAA-AOML/tourmaline
mv tourmaline tourmaline-bleaching
git clone https://github.com/NOAA-AOML/tourmaline
mv tourmaline tourmaline-corallimorph
```

### Metadata setup

The metadata (mapping) file was downloaded from Qiita study [10798](https://qiita.ucsd.edu/study/description/10798); added to this were the columns `coral_health_plus_year`, `position_plus_year`, and `species_code`; the resulting file was saved as `14693_analysis_mapping_cleaned_LT.txt`. This file was the split by project (Bleaching, Corallimorph) and the columns `zone` and `zone_plus_year` were added to the Corallimorph metadata file:

```python
cd $HOME/carter/metadata
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

The final metadata files are `14693_analysis_mapping_cleaned_bleaching.txt` and `14693_analysis_mapping_cleaned_corallimorph.txt`.

Set up data directories and create links to metadata files:

```
mkdir $HOME/carter/tourmaline-bleaching/00-data
cd $HOME/carter/tourmaline-bleaching/00-data
ln -s $HOME/carter/metadata/14693_analysis_mapping_cleaned_bleaching.txt metadata.tsv

mkdir $HOME/carter/tourmaline-corallimorph/00-data
cd $HOME/carter/tourmaline-corallimorph/00-data
ln -s $HOME/carter/metadata/14693_analysis_mapping_cleaned_corallimorph.txt metadata.tsv
```

### Fastq setup

After demultiplexing using `qiime demux emp-paired` (see Tourmaline recipe TBD), create fastq manifest files (see QIIME 2 documentation) and create links to them:

```
cd $HOME/carter/tourmaline-bleaching/00-data
ln -s $HOME/carter/fastq/manifest_bleaching_se.csv manifest_se.csv
ln -s $HOME/carter/fastq/manifest_bleaching_pe.csv manifest_pe.csv
cd $HOME/carter/tourmaline-corallimorph/00-data
ln -s $HOME/carter/fastq/manifest_corallimorph_se.csv manifest_se.csv
ln -s $HOME/carter/fastq/manifest_corallimorph_pe.csv manifest_pe.csv
```

### Reference database

Import SILVA 16S 97% reference sequences and taxonomy for QIIME 2. Download SILVA Release 132 QIIME version to Barnacle:

```
cd $HOME/databases/silva
wget https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_132_release.zip
unzip Silva_132_release.zip
mv Silva_132_release silva_132_qiime
```

Sequences and taxonomy are already in QIIME 2-compatible format. We are using the taxonomy file `taxonomy_7_levels.txt`.

```
cd $HOME/databases/qiime2/16s
ln -s $HOME/databases/silva/silva_132_qiime/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna silva_132_99_16S.fna
ln -s $HOME/databases/silva/silva_132_qiime/taxonomy/16S_only/99/taxonomy_7_levels.txt silva_132_99_16S_taxonomy_7_levels.tsv
qiime tools import --type 'FeatureData[Sequence]' --input-path silva_132_99_16S_sequences.fna --output-path silva_132_99_16S_sequences.qza
qiime tools import --type 'FeatureData[Taxonomy]' --source-format HeaderlessTSVTaxonomyFormat --input-path silva_132_99_16S_taxonomy_7_levels.tsv --output-path silva_132_99_16S_taxonomy_7_levels.qza

cd $HOME/carter/tourmaline-bleaching/01-imported
ln -s $HOME/databases/qiime2/16s/silva_132_99_16S_sequences.qza refseqs.qza
ln -s $HOME/databases/qiime2/16s/silva_132_99_16S_taxonomy_7_levels.qza reftax.qza
cd $HOME/carter/tourmaline-corallimorph/01-imported
ln -s $HOME/databases/qiime2/16s/silva_132_99_16S_sequences.qza refseqs.qza
ln -s $HOME/databases/qiime2/16s/silva_132_99_16S_taxonomy_7_levels.qza reftax.qza
```

### Run Tourmaline (dada2-pe, dada2-se, deblur-se)

### Input files

Below just shows the output of listing the directory contents:

```
ls -l $HOME/carter/tourmaline-bleaching/00-data
manifest_pe.csv -> $HOME/carter/fastq/manifest_bleaching_pe.csv
manifest_se.csv -> $HOME/carter/fastq/manifest_bleaching_se.csv
metadata.tsv -> $HOME/carter/metadata/14693_analysis_mapping_cleaned_bleaching.txt

ls -l $HOME/carter/tourmaline-bleaching/01-imported
classifier.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_classifier_7_levels.qza
fastq_pe.qza
fastq_se.qza
refseqs.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_sequences.qza
reftax.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_taxonomy_7_levels.qza

ls -l $HOME/carter/tourmaline-corallimorph/00-data
manifest_pe.csv -> $HOME/carter/fastq/manifest_corallimorph_pe.csv
manifest_se.csv -> $HOME/carter/fastq/manifest_corallimorph_se.csv
metadata.tsv -> $HOME/carter/metadata/14693_analysis_mapping_cleaned_corallimorph.txt

ls -l $HOME/carter/tourmaline-corallimorph/01-imported
classifier.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_classifier_7_levels.qza
fastq_pe.qza
fastq_se.qza
refseqs.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_sequences.qza
reftax.qza -> $HOME/databases/qiime2/16s/silva_132_97_16S_taxonomy_7_levels.qza
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
ls $HOME/carter/jobs
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
