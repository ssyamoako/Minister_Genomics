###############################
#!/bin/bash 
# {9_dendogram.sh}
###############################

# Generate dendogram using dREP

mkdir tmp_fastas
cp GENOME/*.fasta tmp_fastas
cp 5_REORDER_CONTIGS/CTL-233B.reordered.fasta tmp_fastas/


mkdir 9_DENDOGRAM
dRep compare 9_DENDOGRAM -g tmp_fastas/*.fasta
rm -fr tmp_fastas

echo "9_DENDOGRAM generated"
echo "output: ./9_DENDOGRAM"