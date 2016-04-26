# papers/

Repository for code developed for and/or used in the preparation of peer-reviewed scientific manuscripts.

## cyanophage-light-dark-transcriptomics/

Thompson et al., "Light energy and electron flow in _Prochlorococcus_ during cyanophage infection", in prep.

Code retrieved from local directory `$HOME/lightdark/` using these commands:

    ls */*.sh
    ls */*.pl
    ls */*.py
    ls */*.R
    ls */*.ipynb
    cat */*.sh | grep -E "\.pl" | perl -lpe 's/.*[\/\t ]([a-zA-Z0-9_]*.pl) .*/$1/' | sort | uniq
    cat */*.sh | grep -E "\.py" | perl -lpe 's/.*[\/\t ]([a-zA-Z0-9_]*.py) .*/$1/' | sort | uniq

## red-sea-single-cell-genomes/

Thompson et al., "Single-cell genomics of _Pelagibacter_ and _Prochlorococcus_ from the Red Sea", in prep.

*STILL NEEDS TO BE COPIED --* Code retrieved from local directory `$HOME/singlecell/` using above commands to select files with extensions .sh, .pl, .py, and .R.

## red-sea-spatial-series/

Thompson et al., "Metagenomic covariation along densely sampled environmental gradients in the Red Sea", in review.

Code retrieved from local directory `$HOME/krse2011/` using above commands to select files with extensions .sh, .pl, .py, and .R.

## vibrio-fischeri-transcriptomics/

Thompson et al., "Transcriptional characterization of _Vibrio fischeri_ during colonization of juvenile _Euprymna scolopes_", in prep.

Code retrieved from local directory `$HOME/vibrio/` using above commands to select files with extensions .sh, .pl, .py, and .R.