#!/bin/bash
#SBATCH --job-name=integrate    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p highmem               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=8         ## number of cores the job needs
#SBATCH --output=integrate-%J.out ## output log file
#SBATCH --error=integrate-%J.err ## error log file
#SBATCH --mem=256G

source ~/miniconda3/bin/activate hpc3sc

mkdir ../../seurat

Rscript seurat_process.R -t adrenal