########################
#!/bin/bash 
# {6_mlst.sh}
########################

# Perform a multi locus sequence typing using MLST software

s=5_REORDER_CONTIGS/CTL-233B.reordered.fasta
#v=vibro.recordered.fasta

mkdir 6_MLST
mlst --csv $s  > CTL-233B_mlst.csv
#mlst --csv $v  > vibro_mlst.csv

mv CTL-233B_mlst.csv 6_MLST