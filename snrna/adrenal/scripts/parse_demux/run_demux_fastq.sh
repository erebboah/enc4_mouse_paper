#!/bin/bash
#SBATCH --job-name=splitfastq    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --mem=256G
#SBATCH --output=fastqsplit-%J.out ## output log file
#SBATCH --error=fastqsplit-%J.err ## error log file
#SBATCH -n 32

source ~/miniconda3/bin/activate seqtkpython3

gunzip ../../fastq/Adr_12kA_R*.fastq.gz
gunzip ../../analysis_12A/process/barcode_head.fastq.gz
  
python demux_fastqs.py \
  -o ../../standard_12A/ \
  -cell_meta ../../analysis_12A/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12A/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kA_R1.fastq \
  -f2 ../../fastq/Adr_12kA_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kA_R*.fastq
gzip ../../analysis_12A/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_12kB_R*.fastq.gz
gunzip ../../analysis_12B/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../standard_12B/ \
  -cell_meta ../../analysis_12B/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12B/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kB_R1.fastq \
  -f2 ../../fastq/Adr_12kB_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kB_R*.fastq
gzip ../../analysis_12B/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_12kC_R*.fastq.gz
gunzip ../../analysis_12C/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../standard_12C/ \
  -cell_meta ../../analysis_12C/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12C/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kC_R1.fastq \
  -f2 ../../fastq/Adr_12kC_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kC_R*.fastq
gzip ../../analysis_12C/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_12kD_R*.fastq.gz
gunzip ../../analysis_12D/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../standard_12D/ \
  -cell_meta ../../analysis_12D/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12D/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kD_R1.fastq \
  -f2 ../../fastq/Adr_12kD_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kD_R*.fastq
gzip ../../analysis_12D/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_12kE_R*.fastq.gz
gunzip ../../analysis_12E/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../standard_12E/ \
  -cell_meta ../../analysis_12E/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12E/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kE_R1.fastq \
  -f2 ../../fastq/Adr_12kE_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kE_R*.fastq
gzip ../../analysis_12E/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_12kF_R*.fastq.gz
gunzip ../../analysis_12F/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../standard_12F/ \
  -cell_meta ../../analysis_12F/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_12F/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_12kF_R1.fastq \
  -f2 ../../fastq/Adr_12kF_R2.fastq \
  -t 32

gzip ../../fastq/Adr_12kF_R*.fastq
gzip ../../analysis_12F/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_2kA_R*.fastq.gz
gunzip ../../analysis_2A/process/barcode_head.fastq.gz
  
python demux_fastqs.py \
  -o ../../lr_match_2A/ \
  -cell_meta ../../analysis_2A/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_2A/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_2kA_R1.fastq \
  -f2 ../../fastq/Adr_2kA_R2.fastq \
  -t 32

gzip ../../fastq/Adr_2kA_R*.fastq
gzip ../../analysis_2A/process/barcode_head.fastq

############

gunzip ../../fastq/Adr_2kB_R*.fastq.gz
gunzip ../../analysis_2B/process/barcode_head.fastq.gz

python demux_fastqs.py \
  -o ../../lr_match_2B/ \
  -cell_meta ../../analysis_2B/all-well/DGE_unfiltered/cell_metadata.csv \
  -sp_fastq ../../analysis_2B/process/barcode_head.fastq \
  -f1 ../../fastq/Adr_2kB_R1.fastq \
  -f2 ../../fastq/Adr_2kB_R2.fastq \
  -t 32

gzip ../../fastq/Adr_2kB_R*.fastq
gzip ../../analysis_2B/process/barcode_head.fastq
