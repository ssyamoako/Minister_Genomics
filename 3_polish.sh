##########################
#!/bin/bash 
# {3_polish.sh}
##########################

# Polish the draft assembly using pilon. This is meant to improve the draft assembly. The scaffolds will be used 
# You can also modify the script to use the contigs and compare the result

#polishing illumina draft assembly using pilon
BASE_DIR="/home1/bcs01/Bacterial_Genomics_Analysis"
cd $BASE_DIR

mkdir 3_POLISHED_ASSEMBLY

#increase the number of threads if you have more cpu cores to make it run faster
threads=16
for i in $(cat 1_RAW/Prefix.tsv)
do
    pilon=$BASE_DIR/APPS/pilon.jar
    R1=$BASE_DIR/1_TRIMMED_READS
    R2=$BASE_DIR/1_TRIMMED_READS
# V1=$BASE_DIR/3_TRIMMED_READS/vibro_1.fastq.gz
# V2=$BASE_DIR/3_TRIMMED_READS/vibro_1.fastq.gz

    mkdir 3_POLISHING_PROCESS
    cd 3_POLISHING_PROCESS

    echo "POLISING DRAFT ASSEMBLY"

    echo "ROUND1"
    cp $BASE_DIR/3_${i}_SPADES_TRIM/scaffolds.fasta ./${i}.fasta
    #cp $BASE_DIR/3_Salmonella_SPADES_TRIM/scaffolds.fasta ./Salmonella.fasta
    bwa index ${i}.fasta
    bwa mem -t $threads ${i}.fasta $R1/${i}_1.fastq.gz $R2/${i}_2.fastq.gz | samtools view - -Sb |samtools sort - -@"threads" -o ${i}1.sorted.bam
    samtools index ${i}1.sorted.bam
    java -Xmx40G -jar  $pilon --genome ${i}.fasta --fix all --changes --frags ${i}1.sorted.bam --threads $threads --output pilon_${i}1 | tee ${i}1.pilon

# echo "ROUND 1 VIBRO"
# cp $BASE_DIR/5_VIBRO_SPADES_TRIM/scaffolds.fasta ./vibro.fasta
# bwa index vibro.fasta
# bwa mem -t $threads vibro.fasta $V1 $V2 | samtools view - -Sb |samtools sort - -@"threads" -o vibro1.sorted.bam
# samtools index vibro1.sorted.bam
# java -Xmx40G -jar  $pilon --genome vibro.fasta --fix all --changes --frags vibro1.sorted.bam --threads $threads --output pilon_vibro1|tee vibro1.pilon

    echo "Round2"
    bwa index pilon_${i}1.fasta
    bwa mem -t $threads pilon_${i}1.fasta $R1/${i}_1.fastq.gz $R2/${i}_2.fastq.gz | samtools view - -Sb | samtools sort - -@"$threads" -o ${i}2.sorted.bam
    samtools index ${i}2.sorted.bam
    java -Xmx40G -jar $pilon --genome pilon_${i}1.fasta --fix all --changes --frags ${i}2.sorted.bam --threads $threads --output pilon_${i}2 | tee ${i}2.pilon

# echo "Round2 VIBRO"

# bwa index pilon_vibro1.fasta
# bwa mem -t $threads pilon_vibro1.fasta $V1 $V2| samtools view - -Sb | samtools sort - -@"$threads" -o vibro2.sorted.bam
# samtools index vibro2.sorted.bam
# java -Xmx40G -jar $pilon --genome pilon_vibro1.fasta --fix all --changes --frags vibro2.sorted.bam --threads $threads --output pilon_vibro2 | tee vibro2.pilon


    echo "Round3"
    bwa index pilon_${i}2.fasta
    bwa mem -t $threads pilon_${i}2.fasta $R1/${i}_1.fastq.gz $R2/${i}_2.fastq.gz | samtools view - -Sb | samtools sort - -@"$threads" -o ${i}3.sorted.bam
    samtools index ${i}3.sorted.bam
    java -Xmx40G -jar $pilon --genome pilon_${i}2.fasta --fix all --changes --frags ${i}3.sorted.bam --threads $threads --output pilon_${i}3 | tee ${i}3.pilon

# echo "Round3 VIBRO"
# bwa index pilon_vibro2.fasta
# bwa mem -t $threads pilon_vibro2.fasta $V1 $V2| samtools view - -Sb | samtools sort - -@"$threads" -o vibro3.sorted.bam
# samtools index vibro3.sorted.bam
# java -Xmx40G -jar $pilon --genome pilon_vibro2.fasta --fix all --changes --frags vibro3.sorted.bam --threads $threads --output pilon_vibro3 | tee vibro3.pilon


    echo "Round4"
    bwa index pilon_${i}3.fasta
    bwa mem -t $threads pilon_${i}3.fasta $R1/${i}_1.fastq.gz $R2/${i}_2.fastq.gz | samtools view - -Sb | samtools sort - -@"$threads" -o ${i}4.sorted.bam
    samtools index ${i}4.sorted.bam
    java -Xmx40G -jar $pilon --genome pilon_${i}3.fasta --fix all --changes --frags ${i}4.sorted.bam --threads $threads --output pilon_${i}4 | tee ${i}4.pilon
    
    cp $BASE_DIR/3_POLISHING_PROCESS/pilon_${i}4.fasta $BASE_DIR/3_POLISHED_ASSEMBLY/${i}.polished.fasta
    #cp $BASE_DIR/5_POLISHING_PROCESS/pilon_Jejuni4.fasta $BASE_DIR/4_POLISHED_ASSEMBLY/Jejuni.polished.fasta
done
# echo "Round4 VIBRO"
# bwa index pilon_vibro3.fasta
# bwa mem -t $threads pilon_vibro3.fasta $V1 $V2| samtools view - -Sb | samtools sort - -@"$threads" -o vibro4.sorted.bam
# samtools index vibro4.sorted.bam
# java -Xmx40G -jar $pilon --genome pilon_vibro3.fasta --fix all --changes --frags vibro4.sorted.bam --threads $threads --output pilon_vibro4 | tee vibro4.pilon

cd ../
cat 3_POLISHING_PROCESS/pilon_CTL-233B4.changes
#cat 5_POLISHING_PROCESS/pilon_Jejuni4.changes