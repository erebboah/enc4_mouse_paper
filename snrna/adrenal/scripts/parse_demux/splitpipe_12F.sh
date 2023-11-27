#!/bin/sh
#SBATCH --job-name=spipe12F   ## Name of the job
#SBATCH -A seyedam_lab            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=16         ## number of cores the job needs
#SBATCH --output=spipe12F-%J.out ## output log file
#SBATCH --error=spipe12F-%J.err ## error log file
#SBATCH --mem=128G

source ~/miniconda3/bin/activate spipev1

split-pipe \
	--mode all \
	--kit WT \
	--chemistry v1 \
	--genome_dir ../../../genome/mm10 \
	--fq1 ../../fastq/Adr_12kF_R1.fastq.gz \
	--fq2 ../../fastq/Adr_12kF_R2.fastq.gz \
	--output_dir ../../analysis_12F/ \
	--sample A_4_F1 A1-A1 \
	--sample A_4_F2 B1-B1 \
	--sample A_4_M1 C1-C1 \
	--sample A_4_M2 D1-D1 \
	--sample A_10_F1 A2-A2 \
	--sample A_10_F2 B2-B2 \
	--sample A_10_M1 C2-C2 \
	--sample A_10_M2 D2-D2 \
	--sample A_14_F1 A3-A3,B3-B3 \
	--sample A_14_F2 A4-A4,B4-B4 \
	--sample A_14_M1 C3-C3,D3-D3 \
	--sample A_14_M2 C4-C4,D4-D4 \
	--sample A_25_F1 A5-A5,B5-B5 \
	--sample A_25_F2 A6-A6,B6-B6 \
	--sample A_25_M1 C5-C5,D5-D5 \
	--sample A_25_M2 C6-C6,D6-D6 \
	--sample A_36_F1 A7-A7,B7-B7 \
	--sample A_36_F2 A8-A8,B8-B8 \
	--sample A_36_M1 C7-C7,D7-D7 \
	--sample A_36_M2 C8-C8,D8-D8 \
	--sample A_2m_F1 A9-A9,B9-B9 \
	--sample A_2m_F2 A10-A10,B10-B10 \
	--sample A_2m_M1 C9-C9,D9-D9 \
	--sample A_2m_M2 C10-C10,D10-D10 \
	--sample A_18m_F1 A11-A11,B11-B11 \
	--sample A_18m_F2 A12-A12,B12-B12 \
	--sample A_18m_M1 C11-C11,D11-D11 \
	--sample A_18m_M2 C12-C12,D12-D12 
