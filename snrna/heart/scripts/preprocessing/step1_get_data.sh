#!/bin/bash
#SBATCH --job-name=process    ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=8         ## number of cores the job needs
#SBATCH --output=process-%J.out ## output log file
#SBATCH --error=process-%J.err ## error log file
#SBATCH --mem=128G
#SBATCH --time=06:00:00

source ~/miniconda3/bin/activate hpc3sc

############# Get data #############

Rscript get_counts_parse.R -t heart
Rscript get_counts_10x.R -t heart
