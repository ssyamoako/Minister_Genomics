############################
#!/bin/bash 
# {8_annotate.sh}
############################

# Annotate the draft genome using prokka
#Genome annotation using prokka

#if you have more cpus you can increase the number of cpus
cpus=16

prokka \
    --cpus $cpus \
    --kingdom Bacteria \
    --locustag CTL-233B \
    --outdir 8_CTL-233B_annotation \
    --prefix CTL-233B \
    --addgenes 5_REORDER_CONTIGS/CTL-233B.reordered.fasta

# Get some statistics on the annotation. Features such as genes, CDS will be counted and displayed. 
# The scripts requires you to specify the folder where annotations were saved . i.e. CTL-233B

./get_pseudo.pl 8_CTL-233B_annotation/CTL-233B.faa | tee 8_CTL-233B_annotation/CTL-233B.pseudo.txt

# Python should be used to run that script
python get_annot_stats.py 8_CTL-233B_annotation CTL-233B