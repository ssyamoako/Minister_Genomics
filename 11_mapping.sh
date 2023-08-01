###########################
# !#/bin/bash
# {11_mapping.sh}
##########################

mkdir 11_MAPPING 
# 3.3.1 code: BWA indexing
bwa index 3_POLISHING_PROCESS/CTL-233B.fasta  

# 3.3.2 code: BWA mapping
# trimmed data
for i in $(cat 1_RAW/Prefix.tsv)
do
    bwa mem 3_POLISHING_PROCESS/CTL-233B.fasta 1_TRIMMED_READS/${i}_1.fastq.gz 1_TRIMMED_READS/${i}_2.fastq.gz > 14_MAPPING/${i}.sam;
    # 3.3.3 code: Mapping post-processing
    # sort
    samtools sort -n -O sam 11_MAPPING/${i}.sam | samtools fixmate -m -O bam - 11_MAPPING/${i}.fixmate.bam;
    samtools sort -O bam -o 11_MAPPING/${i}.sorted.bam 11_MAPPING/${i}.fixmate.bam;
    # mark duplicates
    samtools markdup -r -S 11_MAPPING/${i}.sorted.bam 11_MAPPING/${i}.sorted.dedup.bam;
    samtools view -h -b -q 20 11_MAPPING/${i}.sorted.dedup.bam > 11_MAPPING/${i}.sorted.dedup.q20.bam
    # statistics
    #qualimap bamqc -bam mapping/${i}.sorted.dedup.bam
done

# clean up 
rm 11_MAPPING/*.sam
rm 11_MAPPING/*.fixmate.bam
rm 11_MAPPING/*.sorted.bam
rm 11_MAPPING/*.sorted.dedup.bam