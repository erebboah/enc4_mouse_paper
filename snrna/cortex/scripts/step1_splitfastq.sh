#!/bin/bash
#SBATCH --job-name=splitfastq    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --mem=256G
#SBATCH --output=fastqsplit-%J.out ## output log file
#SBATCH --error=fastqsplit-%J.err ## error log file
#SBATCH -n 32

source ~/miniconda3/bin/activate seqtkpython3

datapath=/share/crsp/lab/seyedam/share/Heidi_Liz/cortex
outpath=/dfs5/bio/erebboah/snrna/

#### Sublibrary 12A

gunzip ${datapath}/fastq/Ctx_12kA_R*.fastq.gz
gunzip ${datapath}/analysis_12A/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12A/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12A/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kA_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kA_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kA_R*.fastq
gzip ${datapath}/analysis_12A/process/single_cells_barcoded_head.fastq

#### Sublibrary 12B

gunzip ${datapath}/fastq/Ctx_12kB_R*.fastq.gz
gunzip ${datapath}/analysis_12B/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12B/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12B/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kB_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kB_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kB_R*.fastq
gzip ${datapath}/analysis_12B/process/single_cells_barcoded_head.fastq

#### Sublibrary 12C

gunzip ${datapath}/fastq/Ctx_12kC_R*.fastq.gz
gunzip ${datapath}/analysis_12C/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12C/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12C/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kC_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kC_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kC_R*.fastq
gzip ${datapath}/analysis_12C/process/single_cells_barcoded_head.fastq

#### Sublibrary 12D

gunzip ${datapath}/fastq/Ctx_12kD_R*.fastq.gz
gunzip ${datapath}/analysis_12D/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12D/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12D/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kD_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kD_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kD_R*.fastq
gzip ${datapath}/analysis_12D/process/single_cells_barcoded_head.fastq

#### Sublibrary 12E

gunzip ${datapath}/fastq/Ctx_12kE_R*.fastq.gz
gunzip ${datapath}/analysis_12E/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12E/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12E/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kE_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kE_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kE_R*.fastq
gzip ${datapath}/analysis_12E/process/single_cells_barcoded_head.fastq

#### Sublibrary 12F

gunzip ${datapath}/fastq/Ctx_12kF_R*.fastq.gz
gunzip ${datapath}/analysis_12F/process/single_cells_barcoded_head.fastq.gz
  
python demux_fastqs.py \
 -o "${outpath}/cortex/shallow_12F/"
 -cell_meta "${datapath}/old/analysis/all-well/DGE_unfiltered/cell_metadata.csv" \
 -sp_fastq "${datapath}/analysis_12F/process/single_cells_barcoded_head.fastq" \
 -f1 "${datapath}/fastq/Ctx_12kF_R1.fastq" \
 -f2 "${datapath}/fastq/Ctx_12kF_R2.fastq" \
 -t 32

gzip ${datapath}/fastq/Ctx_12kF_R*.fastq
gzip ${datapath}/analysis_12F/process/single_cells_barcoded_head.fastq
