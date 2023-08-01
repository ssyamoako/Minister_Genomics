#####################
#!/bin/bash
# {12_variant_call.sh}
#######################
# install this tools
# conda install -c bioconda bamtools vcflib rtg-tools 
# conda install -c conda-forge matplotlib
# indexing 
samtools faidx 3_POLISHING_PROCESS/CTL-233B.fasta

mkdir 12_VARIANTS
for i in $(cat 1_RAW/Prefix.tsv)
do
    bamtools index -in 11_MAPPING/${i}.sorted.dedup.q20.bam
    # calling variants
    freebayes -p 1 -f 3_POLISHING_PROCESS/CTL-233B.fasta 11_MAPPING/${i}.sorted.dedup.q20.bam > 12_VARIANTS/${i}.freebayes.vcf
    # compress
    bgzip 12_VARIANTS/${i}.freebayes.vcf
    # index
    tabix -p vcf 12_VARIANTS/${i}.freebayes.vcf.gz
    # filtering
    #zcat 15_VARIANTS/${i}.freebayes.vcf.gz | vcffilter -f "QUAL > 1 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" | bgzip > 15_VARIANTS/${i}.freebayes.filtered.vcf.gz
    #tabix -p vcf 15_VARIANTS/${i}.freebayes.filtered.vcf.gz
done