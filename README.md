# papers/

Repository for code developed by Luke Thompson and colleagues in the preparation of peer-reviewed scientific manuscripts.

## cyanophage-light-dark-transcriptomics/

Thompson et al., "Light energy and electron flow in Prochlorococcus during cyanophage infection", in prep.

Code retrieved from `~/lightdark` using these commands:

    ls */*.sh
    ls */*.pl
    ls */*.py
    ls */*.R
    cat */*.sh | grep ".pl" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.pl) .*/$1/' | sort | uniq | grep ".pl" > cp_to_repo.sh
    cat */*.sh | grep ".py" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.py) .*/$1/' | sort | uniq  >> cp_to_repo.sh
