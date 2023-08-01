####################################
#!/bin/bash 
# {10_get_genome_gffs.sh}
####################################

#if you have more cpu cores you can increase the number of cpus
cpus=16

mkdir 10_GFFS
cp 6_CTL-233B_annotation/CTL-233B.gff 10_GFFS/

cd GENOMES
for genome in $(cat GID.tsv)
do
prokka --cpus $cpus --kingdom Bacteria --locustag ${genome} --addgenes --prefix ${genome} ${genome}.fasta
cp ${genome}/${genome}.gff ../10_GFFS
rm -fr ${genome}
done

cd ../