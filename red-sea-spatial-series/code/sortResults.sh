# # pathwayCoverage - all/original
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k1) > humannPathwayCoverage_sort_alpha.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k2) > humannPathwayCoverage_sort_eta.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k3) > humannPathwayCoverage_sort_epsilon.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k4) > humannPathwayCoverage_sort_b0.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k5) > humannPathwayCoverage_sort_b1depth.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k6) > humannPathwayCoverage_sort_b2temp.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k7) > humannPathwayCoverage_sort_b3salinity.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k8) > humannPathwayCoverage_sort_b4oxygen.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k9) > humannPathwayCoverage_sort_b5fluor.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k10) > humannPathwayCoverage_sort_b6turbidity.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k11) > humannPathwayCoverage_sort_b7nitrate.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k12) > humannPathwayCoverage_sort_b8phosphate.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k13) > humannPathwayCoverage_sort_b9silicate.tsv
# (head -n 1 humannPathwayCoverage.T.tsv && tail -n +2 humannPathwayCoverage.T.tsv | sort -g -r -k14) > humannPathwayCoverage_sort_code.tsv

# # pathwayRelAbund - all/original
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k1) > humannPathwayRelAbund_sort_alpha.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k2) > humannPathwayRelAbund_sort_eta.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k3) > humannPathwayRelAbund_sort_epsilon.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k4) > humannPathwayRelAbund_sort_b0.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k5) > humannPathwayRelAbund_sort_b1depth.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k6) > humannPathwayRelAbund_sort_b2temp.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k7) > humannPathwayRelAbund_sort_b3salinity.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k8) > humannPathwayRelAbund_sort_b4oxygen.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k9) > humannPathwayRelAbund_sort_b5fluor.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k10) > humannPathwayRelAbund_sort_b6turbidity.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k11) > humannPathwayRelAbund_sort_b7nitrate.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k12) > humannPathwayRelAbund_sort_b8phosphate.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k13) > humannPathwayRelAbund_sort_b9silicate.tsv
# (head -n 1 humannPathwayRelAbund.T.tsv && tail -n +2 humannPathwayRelAbund.T.tsv | sort -g -r -k14) > humannPathwayRelAbund_sort_code.tsv

# pathwayCoverage - june30
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k2) > june30_pathwayCoverage_p05_sort_b0.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k3) > june30_pathwayCoverage_p05_sort_b1depth.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k4) > june30_pathwayCoverage_p05_sort_b2temp.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k5) > june30_pathwayCoverage_p05_sort_b3salinity.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k6) > june30_pathwayCoverage_p05_sort_b4oxygen.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k7) > june30_pathwayCoverage_p05_sort_b5fluor.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k8) > june30_pathwayCoverage_p05_sort_b6turbidity.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k9) > june30_pathwayCoverage_p05_sort_b7nitrate.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k10) > june30_pathwayCoverage_p05_sort_b8phosphate.tsv
(head -n 1 june30_pathwayCoverage_p05.tsv && tail -n +2 june30_pathwayCoverage_p05.tsv | sort -g -r -k11) > june30_pathwayCoverage_p05_sort_b9silicate.tsv

# pathwayRelAbund - june30
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k2) > june30_pathwayRelAbund_p05_sort_b0.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k3) > june30_pathwayRelAbund_p05_sort_b1depth.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k4) > june30_pathwayRelAbund_p05_sort_b2temp.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k5) > june30_pathwayRelAbund_p05_sort_b3salinity.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k6) > june30_pathwayRelAbund_p05_sort_b4oxygen.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k7) > june30_pathwayRelAbund_p05_sort_b5fluor.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k8) > june30_pathwayRelAbund_p05_sort_b6turbidity.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k9) > june30_pathwayRelAbund_p05_sort_b7nitrate.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k10) > june30_pathwayRelAbund_p05_sort_b8phosphate.tsv
(head -n 1 june30_pathwayRelAbund_p05.tsv && tail -n +2 june30_pathwayRelAbund_p05.tsv | sort -g -r -k11) > june30_pathwayRelAbund_p05_sort_b9silicate.tsv

