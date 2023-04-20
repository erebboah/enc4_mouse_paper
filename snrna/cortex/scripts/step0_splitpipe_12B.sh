#!/bin/sh
#SBATCH --job-name=spipe12B   ## Name of the job
#SBATCH -A seyedam_lab            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=16         ## number of cores the job needs
#SBATCH --output=spipe12B-%J.out ## output log file
#SBATCH --error=spipe12B-%J.err ## error log file
#SBATCH --mem=128G

source ~/miniconda3/bin/activate env3.7
datapath=/share/crsp/lab/seyedam/share/Heidi_Liz/cortex

split-pipe \
	--mode all \
	--genome_dir /share/crsp/lab/seyedam/share/Heidi_Liz/genomes/mm10 \
	--fq1 "${datapath}/fastq/Ctx_12kB_R1.fastq.gz" \
	--fq2 "${datapath}/fastq/Ctx_12kB_R2.fastq.gz" \
	--output_dir "${datapath}/analysis_12B/" \
	--sample C_4_F_1 A3-A4 \
	--sample C_4_F_2 B3-B4 \
	--sample C_4_M_1 C3-C4 \
	--sample C_4_M_2 D3-D4 \
	--sample C_10_F_1 A5-A6 \
	--sample C_10_F_2 B5-B6 \
	--sample C_10_M_1 C5-C6 \
	--sample C_10_M_2 D5-D6 \
	--sample C_14_F_1 A7-A8 \
	--sample C_14_F_2 B7-B8 \
	--sample C_14_M_1 C7-C8 \
	--sample C_14_M_2 D7-D8 \
	--sample C_25_F_1 A9-A10 \
	--sample C_25_F_2 B9-B10 \
	--sample C_25_M_1 C9-C10 \
	--sample C_25_M_2 D9-D10 \
	--sample C_36_F_1 A1-A1 \
	--sample C_36_F_2 B1-B1 \
	--sample C_36_M_1 C1-C1 \
	--sample C_36_M_2 D1-D1 \
	--sample C_2m_F_1 A11-A12 \
	--sample C_2m_F_2 B11-B12 \
	--sample C_2m_M_1 C11-C12 \
	--sample C_2m_M_2 D11-D12 \
	--sample C_18m_F_1 A2-A2 \
	--sample C_18m_F_2 B2-B2 \
	--sample C_18m_M_1 C2-C2 \
	--sample C_18m_M_2 D2-D2 
