#!/bin/sh
#SBATCH --account=epi
#SBATCH --qos=epi-b
#SBATCH --job-name=virusdetect
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ralcala@ufl.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16gb
#SBATCH --time=10:00:00
#SBATCH --output=logs/virusdetect_%A_%a.out
#SBATCH --array=1-13%3 # 1159%100
date; hostname; pwd

# Load modules
module load ufrc
module load perl
module load virusdetect

RUN=${SLURM_ARRAY_TASK_ID}

#@ Command usage example
#      sbatch virusdetect_v17.sbatch vrl_Plants_239_U95 reads/ genome/name_file.fasta.gz

#@ VirusDetect v1.7 for linux
#@ Processing of small single RNAs to detect viruses in crops
DATABASE=$1 #@ DATABASE $PATH
IN_DIR=$2 #@ READ_NAMES $PATH
HOST=$3 #@ HOST $PATH

# Array task
in_file=$(ls ${IN_DIR} | sed -n ${RUN}p)
echo "Run ${RUN}: Input file ${in_file}"

#@ example program
# perl bin/virus_identify.pl --reference databases/vrl_plant input_contig.fasta
echo 'begging run'
virus_detect.pl --reference "$DATABASE" "$IN_DIR$in_file" --host_reference "$HOST" --thread_num 16

