#!/bin/perl
#SBATCH --account=epi
#SBATCH --qos=epi
#SBATCH --job-name=virusdetect
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ralcala@ufl.edu
#SBATCH --ntasks=16
#SBATCH --mem=16gb
#SBATCH --time=10:00:00
#SBATCH --output=logs/virusdetect_%A_%a.out
#SBATCH --array=1-1000%50
date; hostname; pwd


#@ Command usage example
#      sbatch virusdetect_v17.sbatch vrl_plant 1-data/papa_reads/ 1-data/papa_genome/papa_Geno_AEWC01.fasta.gz

#@ VirusDetect v1.7 for linux
#@ Processing of small single RNAs to detect viruses in crops
DATABASE=$1 #@ Add PATH to database
FILENAME=$2 #@ Add PATH/file name
DATABASE=$3
RUN=${SLURM_ARRAY_TASK_ID:=42}

# Load modules 
module load ufrc
module load perl
module load virusdetect

# input=$(ls ${FILENAME} | sed -n ${RUN}p)

#@ example program
# perl bin/virus_identify.pl --reference databases/vrl_plant input_contig.fasta
echo 'begging run'
perl ~/virus_detect.pl --reference "$DATABASE" "$RUN" --host_reference "$DATABASE" --thread_num 16
