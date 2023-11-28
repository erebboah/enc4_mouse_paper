#!/bin/sh
#SBATCH --job-name=spipe12D   ## Name of the job
#SBATCH -A seyedam_lab            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=16         ## number of cores the job needs
#SBATCH --output=spipe12D-%J.out ## output log file
#SBATCH --error=spipe12D-%J.err ## error log file
#SBATCH --mem=128G

source ~/miniconda3/bin/activate spipev1

split-pipe \
	--mode all \
	--kit WT \
	--chemistry v1 \
	--genome_dir ../../../genome/mm10 \
	--fq1 ../../fastq/HC_12kD_R1.fastq.gz \
	--fq2 ../../fastq/HC_12kD_R2.fastq.gz \
	--output_dir ../../analysis_12D/ \
	--sample HC_10_F_1 A1-A2 \
	--sample HC_10_F_2 B1-B2 \
	--sample HC_10_M_1 C1-C2 \
	--sample HC_10_M_2 D1-D2 \
	--sample HC_14_F_1 A3-A4 \
	--sample HC_14_F_2 B3-B4 \
	--sample HC_14_M_1 C3-C4 \
	--sample HC_14_M_2 D3-D4 \
	--sample HC_25_F_1 A5-A6 \
	--sample HC_25_F_2 B5-B6 \
	--sample HC_25_M_1 C5-C6 \
	--sample HC_25_M_2 D5-D6 \
	--sample HC_36_F_1 A7-A8 \
	--sample HC_36_F_2 B7-B8 \
	--sample HC_36_M_1 C7-C8 \
	--sample HC_36_M_2 D7-D8 \
	--sample HC_2m_F_1 A9-A10 \
	--sample HC_2m_F_2 B9-B10 \
	--sample HC_2m_M_1 C9-C10 \
	--sample HC_2m_M_2 D9-D10 \
	--sample HC_18m_M_1 A11-A12,C11-C12 \
	--sample HC_18m_M_2 B11-B12,D11-D12 