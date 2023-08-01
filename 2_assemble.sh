##################
#!/bin/bash 
# {2_assemble.sh}
####################

# Perform de novo assembly using spades on 1_RAW and  3_TRIMMED_READS

for i in $(cat 1_RAW/Prefix.tsv)
do
    spades.py \
        -t 16 \
        --careful \
        -o 2_${i}_SPADES_TRIM \
        -1 1_TRIMMED_READS/${i}_1.fastq.gz \
        -2 1_TRIMMED_READS/${i}_2.fastq.gz 

    spades.py \
        -t 16 \
        --careful \
        -o 2_${i}_SPADES_RAW \
        -1 1_RAW/${i}_1.fastq.gz \
        -2 1_RAW/${i}_2.fastq.gz 
done