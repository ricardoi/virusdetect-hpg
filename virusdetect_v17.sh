#!/bin/perl

#@ Command usage example
#      sh virusdetect_v17.sh vrl_plant 1-data/papa_reads/Pun-040.clean.fq.gz

#@ VirusDetect v1.7 for linux
#@ Processing of small single RNAs to detect viruses in crops
DATABASE=$1 #@ Add PATH to database
FILENAME=$2 #@ Add PATH/file name

module load ufrc
module load perl
module load virusdetect

#@ example program
# perl bin/virus_identify.pl --reference databases/vrl_plant input_contig.fasta

#####@ 1, tengo un erro al leer el archivo de la base de datos - no se por qué, si es el archivo de entrada, o el $PATH
#@ 1R el PATH a la base de datos esta fijo a '/apps/virusdetect/1.7/databases/' entonces tengo que pedirle a la gente del hpg que me actualice esa base de datos o que me de acceso a modificar el PATH

#@ 2, tengo que hacer un paso recomendado en virusdetect que es remover 
	#@  It's highly recommended to remove ribosomal RNA (rRNA) sequences from the input sequences before running VirusDetect. 
	#@ Users can align sRNA reads to the Silva rRNA database using bowtie. Here is the command we recommend (assuming the sRNA sequence file is in fasta format):
#@ See get_rRNAs.sh for version of rRNAs
#@ Example
  #bowtie -v 1 -k 1 --un cleaned_sRNA -f -p 15 Silva_rRNA_database sRNA_sequences sRNA_rRNA_match

#bowtie -v 1 -k 1 --un cleaned_sRNA -f -p 15 Silva_rRNA_database sRNA_sequences sRNA_rRNA_match

#@ runing virusdetect 

perl ~/virus_detect.pl --reference "$DATABASE" "$FILENAME" --host_reference 1-data/papa_genome/papa_Geno_AEWC01.fasta.gz --thread_num 8
