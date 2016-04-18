# papers

Repository for code developed in the preparation of peer-reviewed scientific manuscripts by Luke Thompson and colleagues.

## cyanophage-light-dark-transcriptomics

Thompson et al., "", in prep.

Code retrieved from `~/lightdark` using these commands:

  ls */*.sh
  ls */*.pl
  ls */*.py
  ls */*.R
  cat */*.sh | grep ".pl" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.pl) .*/$1/' | sort | uniq | grep ".pl" > cp_to_repo.sh
  cat */*.sh | grep ".py" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.py) .*/$1/' | sort | uniq  >> cp_to_repo.sh
