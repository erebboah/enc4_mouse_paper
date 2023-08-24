#!/bin/bash
#SBATCH --job-name=seurat    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=8         ## number of cores the job needs
#SBATCH --output=seurat-%J.out ## output log file
#SBATCH --error=seurat-%J.err ## error log file
#SBATCH --mem=256G

source ~/miniconda3/bin/activate hpc3sc

Rscript seurat_process.R -t adrenal
Rscript predict_celltypes.R -t adrenal
