#############################
#!/bin/bash 
# {4_qc_assembly.sh}
#############################

# Perform QC for both raw assembly and polished assembly 
mkdir 4_QC_ASSEMBLY 4_QUAST
for i in $(cat 1_RAW/Prefix.tsv)
do
    quast.py -o 4_QC_ASSEMBLY -R GENOME/Kleb.fasta 2_${i}_SPADES_TRIM/scaffolds.fasta 3_POLISHED_ASSEMBLY/${i}.polished.fasta
    quast.py -o 4_QUAST 3_${i}_SPADES_TRIM/scaffolds.fasta  2_${i}_SPADES_RAW/scaffolds.fasta 3_POLISHED_ASSEMBLY/${i}.polished.fasta
done
#mkdir 6_QC_ASSEMBLY_Salmonella 6_QC_ASSEMBLY_Jejuni

#quast.py -o 6_QC_ASSEMBLY_Salmonella -R GENOME/Salmonella.fasta 3_Salmonella_SPADES_TRIM/scaffolds.fasta 4_POLISHED_ASSEMBLY/Salmonella.polished.fasta
#quast.py -o 8_QC_ASSEMBLY_Jejuni -R GENOME/Jejuni.fasta 3_Jejuni_SPADES_TRIM/scaffolds.fasta 4_POLISHED_ASSEMBLY/Jejuni.polished.fasta


#quast.py -o 8.1_QUAST_SALMONELLA 5_SALMONELLA_SPADES_TRIM/scaffolds.fasta  5_SALMONELLA_SPADES_RAW/scaffolds.fasta 6_POLISHED_ASSEMBLY/salmonella.polished.fasta
#quast.py -o 8.1_QUAST_VIBRO 5_VIBRO_SPADES_TRIM/scaffolds.fasta  5_VIBRO_SPADES_RAW/scaffolds.fasta 6_POLISHED_ASSEMBLY/vibro.polished.fasta