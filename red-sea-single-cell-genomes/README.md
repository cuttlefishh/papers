## red-sea-single-cell-genomes

The basic organization of mapping files and observation tables is shown below:


|                | Metadata table        | Observation table        | Rename to                  |
|----------------|-----------------------|--------------------------|----------------------------|
| Tara samples   | tara_metadata_SRF.tsv | tara_proch_all_SRF.csv   | proch_ogs_in_tara_srf.csv  |
|                |                       | tara_pelag_all_SRF.csv   | pelag_ogs_in_tara_srf.csv  |
| Genomes        | genome_metadata.tsv   | matrix_pro_full.csv      | proch_ogs_in_genomes.csv   |
|                |                       | matrix_sar_full.csv      | pelag_ogs_in_genomes.csv   |
|                |                       | jellyfish_proch_6mer.csv | proch_6mers_in_genomes.csv |
|                |                       | jellyfish_pelag_6mer.csv | pelag_6mers_in_genomes.csv |
| OGs            | og_metadata.tsv       | -----                    | -----                      |