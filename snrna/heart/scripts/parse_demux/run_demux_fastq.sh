#!/bin/bash
#SBATCH --job-name=splitfastq    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --mem=256G
#SBATCH --output=fastqsplit-%J.out ## output log file
#SBATCH --error=fastqsplit-%J.err ## error log file
#SBATCH -n 32

source ~/miniconda3/bin/activate seqtkpython3

gunzip ../../fastq/H_12kA_R*.fastq.gz
gunzip ../../analysis_12A/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o ../../standard_12A/ \
 -cell_meta ../../analysis_12A/all-well/DGE_unfiltered/cell_metadata.csv \
 -sp_fastq ../../analysis_12A/process/single_cells_barcoded_head.fastq \
 -f1 ../../fastq/H_12kA_R1.fastq \
 -f2 ../../fastq/H_12kA_R2.fastq \
 -t 32

gzip ../../fastq/H_12kA_R*.fastq
gzip ../../analysis_12A/process/single_cells_barcoded_head.fastq

############

gunzip ../../fastq/H_12kB_R*.fastq.gz
gunzip ../../analysis_12B/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o ../../standard_12B/ \
 -cell_meta ../../analysis_12B/all-well/DGE_unfiltered/cell_metadata.csv \
 -sp_fastq ../../analysis_12B/process/single_cells_barcoded_head.fastq \
 -f1 ../../fastq/H_12kB_R1.fastq \
 -f2 ../../fastq/H_12kB_R2.fastq \
 -t 32

gzip ../../fastq/H_12kB_R*.fastq
gzip ../../analysis_12B/process/single_cells_barcoded_head.fastq

############

gunzip ../../fastq/H_12kC_R*.fastq.gz
gunzip ../../analysis_12C/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o ../../standard_12C/ \
 -cell_meta ../../analysis_12C/all-well/DGE_unfiltered/cell_metadata.csv \
 -sp_fastq ../../analysis_12C/process/single_cells_barcoded_head.fastq \
 -f1 ../../fastq/H_12kC_R1.fastq \
 -f2 ../../fastq/H_12kC_R2.fastq \
 -t 32

gzip ../../fastq/H_12kC_R*.fastq
gzip ../../analysis_12C/process/single_cells_barcoded_head.fastq

############

gunzip ../../fastq/H_12kD_R*.fastq.gz
gunzip ../../analysis_12D/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o ../../standard_12D/ \
 -cell_meta ../../analysis_12D/all-well/DGE_unfiltered/cell_metadata.csv \
 -sp_fastq ../../analysis_12D/process/single_cells_barcoded_head.fastq \
 -f1 ../../fastq/H_12kD_R1.fastq \
 -f2 ../../fastq/H_12kD_R2.fastq \
 -t 32

gzip ../../fastq/H_12kD_R*.fastq
gzip ../../analysis_12D/process/single_cells_barcoded_head.fastq

############

gunzip ../../fastq/H_2kA_R*.fastq.gz
gunzip ../../analysis_2A/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o ../../lr_match_2A/ \
 -cell_meta ../../analysis_2A/all-well/DGE_unfiltered/cell_metadata.csv \
 -sp_fastq ../../analysis_2A/process/single_cells_barcoded_head.fastq \
 -f1 ../../fastq/H_2kA_R1.fastq \
 -f2 ../../fastq/H_2kA_R2.fastq \
 -t 32

gzip ../../fastq/H_2kA_R*.fastq
gzip ../../analysis_2A/process/single_cells_barcoded_head.fastq
