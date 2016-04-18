**Repository:** cyanophage-light-dark-transcriptomics

**Citation:** Thompson et al., "Light energy and electron flow in Prochlorococcus during cyanophage infection", in prep.

This repository contains Bash, Perl, Python, and R scripts used in the preparation of the manuscript cited above. The scripts are not organized in any directory structure. I simply copied all of the scripts I might have used. Perl and Python scripts called by Bash scripts were idenfified with the following commands from within my `~/lightdark` directory:

* `cat */*.sh | grep ".pl" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.pl).*/$1/' | sort | uniq`
* `cat */*.sh | grep ".py" | perl -lpe 's/.*\/([a-zA-Z0-9]*\.py).*/$1/' | sort | uniq`

Scripts within the `~/lightdark` repo were identified in more straightforward fashion:

* `ls */*.sh`
* `ls */*.pl`
* `ls */*.py`
* `ls */*.R`

