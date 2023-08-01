####################
#!/bin/bash 
# {1_trim_reads.sh}
#####################
 
BASE_DIR="/home1/bcs01/Bacterial_Genomics_Analysis"
cd $BASE_DIR

mkdir 1_TRIMMED_READS

for i in $(cat 1_RAW/Prefix.tsv)
do
    fastp --detect_adapter_for_pe \
        --overrepresentation_analysis \
        --correction --cut_right --thread 16 \
        --html 1_TRIMMED_READS/${i}.fastp.html --json 1_TRIMMED_READS/${i}.fastp.json \
        -i 1_RAW/${i}_1.fastq.gz -I 1_RAW/${i}_2.fastq.gz \
        -o 1_TRIMMED_READS/${i}_1.fastq.gz -O 1_TRIMMED_READS/${i}_2.fastq.gz
done