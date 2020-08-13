#!/bin/perl

#@ VirusDetect v1.7 for linux
#@ Processing of small single RNAs to detect viruses in crops

FILENAME=$1

module load ufrc
module load perl
module load virusdetect

#@ example program
# perl bin/virus_identify.pl --reference databases/vrl_plant input_contig.fasta

#@ 1, tengo un erro al leer el archivo de la base de datos - no se por qué, si es el archivo de entrada, o el $PATH
#@ 2, tengo que hacer un paso recomendado en virusdetect que es remover 
	#@  It's highly recommended to remove ribosomal RNA (rRNA) sequences from the input sequences before running VirusDetect. 
	#@ Users can align sRNA reads to the Silva rRNA database using bowtie. Here is the command we recommend (assuming the sRNA sequence file is in fasta format):
#@ See get_rRNAs.sh for version of rRNAs
#@ Example
  #bowtie -v 1 -k 1 --un cleaned_sRNA -f -p 15 Silva_rRNA_database sRNA_sequences sRNA_rRNA_match

bowtie -v 1 -k 1 --un cleaned_sRNA -f -p 15 Silva_rRNA_database sRNA_sequences sRNA_rRNA_match

#@ runing virusdetect 

perl ~/virus_detect.pl --reference 1-data/plant_232_U95/vrl_Plants_232_U95 1-data/papa_reads/"$FILENAME" --thread_num 8
