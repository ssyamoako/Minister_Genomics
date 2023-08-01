#######################
#!/bin/bash 
# {7_amr.sh}
#######################

# Check for antimicrobial resistance genes using abricate
mkdir 7_AMR
abricate 5_REORDER_CONTIGS/CTL-233B.reordered.fasta > CTL-233B_amr.summary.tab
#abricate vibro.reordered.fasta > vibro_amr.summary.tab

mv CTL-233B_amr.summary.tab 7_AMR