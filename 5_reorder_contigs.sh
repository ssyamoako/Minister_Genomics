##################################
#!/bin/bash 
# {5_reorder_contigs.sh}
##################################

# Generate draft genome by reordering contigs against a reference genome using ragtag
#reference genome
ref=GENOME/Kleb.fasta

mkdir 5_REORDER_CONTIGS
for i in $(cat 1_RAW/Prefix.tsv)
do
    ragtag.py scaffold $ref 3_POLISHED_ASSEMBLY/${i}.polished.fasta -o 5_REORDER_CONTIGS/${i}_reordered
    python extract_reordered.py 5_REORDER_CONTIGS/${i}_reordered/ragtag.scaffold.fasta NC_016845.1 NC_016838.1 NC_016846.1 NC_016839.1 NC_016840.1 NC_016847.1 NC_016841.1
done
mv CTL-233B.reordered.fasta 5_REORDER_CONTIGS

#s=GENOME/Salmonella.fasta
#v=GENOME/Jejuni.fasta

#mkdir 7_REORDER_CONTIGS
#ragtag.py scaffold $s 4_POLISHED_ASSEMBLY/Salmonella.polished.fasta -o 7_REORDER_CONTIGS/Salmonella_reordered
#ragtag.py scaffold $v 4_POLISHED_ASSEMBLY/Jejuni.polished.fasta -o 7_REORDER_CONTIGS/Jejuni_reoredered

#extract the reordered contig with a custom python script
#the scripts accept name of the ragtag file containing the reordered contigs and accession number for the reference genome
#accession number is found in the first line of the reference genome fasta file

## Make some changes in the extract_reordered.py

#python extract_reordered.py 7_REORDER_CONTIGS/Salmonella_reordered/ragtag.scaffold.fasta NC_003197.2 NC_003277.2
#python extract_reordered.py 7_REORDER_CONTIGS/Jejuni_reoredered/ragtag.scaffold.fasta NC_002163.1 

#mv Salmonella.reordered.fasta 7_REORDER_CONTIGS