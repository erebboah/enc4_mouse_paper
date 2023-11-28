#!/bin/sh
#SBATCH --job-name=spipe12A   ## Name of the job
#SBATCH -A seyedam_lab            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=16         ## number of cores the job needs
#SBATCH --output=spipe12A-%J.out ## output log file
#SBATCH --error=spipe12A-%J.err ## error log file
#SBATCH --mem=128G

source ~/miniconda3/bin/activate spipev1

split-pipe \
	--mode all \
	--kit WT \
	--chemistry v1 \
	--genome_dir ../../../genome/mm10 \
	--fq1 ../../fastq/XC_12kA_R1.fastq.gz \
	--fq2 ../../fastq/XC_12kA_R2.fastq.gz \
	--output_dir ../../analysis_12A/ \
	--sample B_C_27 A1-A3 \
	--sample B_C_28 B1-B3 \
	--sample B_C_29 C1-C3 \
	--sample B_C_30 D1-D3 \
	--sample B_HC_27 A4-A6 \
	--sample B_HC_28 B4-B6 \
	--sample B_HC_29 C4-C6 \
	--sample B_HC_30 D4-D6 \
	--sample X_C_33 A7-A9 \
	--sample X_C_34 B7-B9 \
	--sample X_C_35 C7-C9 \
	--sample X_C_36 D7-D9 \
	--sample X_HC_33 A10-A12 \
	--sample X_HC_34 B10-B12 \
	--sample X_HC_35 C10-C12 \
	--sample X_HC_36 D10-D12 \
