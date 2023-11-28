#!/bin/bash
#SBATCH --job-name=adrsplt   ## Name of the job
#SBATCH -A SEYEDAM_LAB            ## account to charge 
#SBATCH -p standard               ## partition/queue name
#SBATCH --nodes=1                 ## (-N) number of nodes to use
#SBATCH --cpus-per-task=16         ## number of cores the job needs
#SBATCH --output=subsplt-%J.out ## output log file
#SBATCH --error=subsplt-%J.err ## error log file
#SBATCH --mem=64G

cd ../../fastq
while read i;
do
    zcat A_4_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_4_F_1_R1.fastq"
    gzip "${i}/A_4_F_1_R1.fastq"

    zcat A_4_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_4_F_1_R2.fastq"
    gzip "${i}/A_4_F_1_R2.fastq"

    zcat A_4_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_4_F_2_R1.fastq"
    gzip "${i}/A_4_F_2_R1.fastq"

    zcat A_4_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_4_F_2_R2.fastq"
    gzip "${i}/A_4_F_2_R2.fastq"

    zcat A_4_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_4_M_1_R1.fastq"
    gzip "${i}/A_4_M_1_R1.fastq"

    zcat A_4_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_4_M_1_R2.fastq"
    gzip "${i}/A_4_M_1_R2.fastq"

    zcat A_4_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_4_M_2_R1.fastq"
    gzip "${i}/A_4_M_2_R1.fastq"

    zcat A_4_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_4_M_2_R2.fastq"
    gzip "${i}/A_4_M_2_R2.fastq"
    
    
    zcat A_10_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_10_F_1_R1.fastq"
    gzip "${i}/A_10_F_1_R1.fastq"

    zcat A_10_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_10_F_1_R2.fastq"
    gzip "${i}/A_10_F_1_R2.fastq"

    zcat A_10_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_10_F_2_R1.fastq"
    gzip "${i}/A_10_F_2_R1.fastq"

    zcat A_10_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_10_F_2_R2.fastq"
    gzip "${i}/A_10_F_2_R2.fastq"

    zcat A_10_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_10_M_1_R1.fastq"
    gzip "${i}/A_10_M_1_R1.fastq"

    zcat A_10_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_10_M_1_R2.fastq"
    gzip "${i}/A_10_M_1_R2.fastq"

    zcat A_10_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_10_M_2_R1.fastq"
    gzip "${i}/A_10_M_2_R1.fastq"

    zcat A_10_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_10_M_2_R2.fastq"
    gzip "${i}/A_10_M_2_R2.fastq"


    zcat A_14_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_14_F_1_R1.fastq"
    gzip "${i}/A_14_F_1_R1.fastq"

    zcat A_14_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_14_F_1_R2.fastq"
    gzip "${i}/A_14_F_1_R2.fastq"

    zcat A_14_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_14_F_2_R1.fastq"
    gzip "${i}/A_14_F_2_R1.fastq"

    zcat A_14_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_14_F_2_R2.fastq"
    gzip "${i}/A_14_F_2_R2.fastq"

    zcat A_14_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_14_M_1_R1.fastq"
    gzip "${i}/A_14_M_1_R1.fastq"

    zcat A_14_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_14_M_1_R2.fastq"
    gzip "${i}/A_14_M_1_R2.fastq"

    zcat A_14_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_14_M_2_R1.fastq"
    gzip "${i}/A_14_M_2_R1.fastq"

    zcat A_14_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_14_M_2_R2.fastq"
    gzip "${i}/A_14_M_2_R2.fastq"
    
    
    zcat A_25_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_25_F_1_R1.fastq"
    gzip "${i}/A_25_F_1_R1.fastq"

    zcat A_25_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_25_F_1_R2.fastq"
    gzip "${i}/A_25_F_1_R2.fastq"

    zcat A_25_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_25_F_2_R1.fastq"
    gzip "${i}/A_25_F_2_R1.fastq"

    zcat A_25_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_25_F_2_R2.fastq"
    gzip "${i}/A_25_F_2_R2.fastq"

    zcat A_25_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_25_M_1_R1.fastq"
    gzip "${i}/A_25_M_1_R1.fastq"

    zcat A_25_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_25_M_1_R2.fastq"
    gzip "${i}/A_25_M_1_R2.fastq"

    zcat A_25_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_25_M_2_R1.fastq"
    gzip "${i}/A_25_M_2_R1.fastq"

    zcat A_25_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_25_M_2_R2.fastq"
    gzip "${i}/A_25_M_2_R2.fastq"
    
    
    zcat A_36_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_36_F_1_R1.fastq"
    gzip "${i}/A_36_F_1_R1.fastq"

    zcat A_36_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_36_F_1_R2.fastq"
    gzip "${i}/A_36_F_1_R2.fastq"

    zcat A_36_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_36_F_2_R1.fastq"
    gzip "${i}/A_36_F_2_R1.fastq"

    zcat A_36_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_36_F_2_R2.fastq"
    gzip "${i}/A_36_F_2_R2.fastq"

    zcat A_36_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_36_M_1_R1.fastq"
    gzip "${i}/A_36_M_1_R1.fastq"

    zcat A_36_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_36_M_1_R2.fastq"
    gzip "${i}/A_36_M_1_R2.fastq"

    zcat A_36_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_36_M_2_R1.fastq"
    gzip "${i}/A_36_M_2_R1.fastq"

    zcat A_36_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_36_M_2_R2.fastq"
    gzip "${i}/A_36_M_2_R2.fastq"
    
    
    zcat A_2m_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_2m_F_1_R1.fastq"
    gzip "${i}/A_2m_F_1_R1.fastq"

    zcat A_2m_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_2m_F_1_R2.fastq"
    gzip "${i}/A_2m_F_1_R2.fastq"

    zcat A_2m_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_2m_F_2_R1.fastq"
    gzip "${i}/A_2m_F_2_R1.fastq"

    zcat A_2m_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_2m_F_2_R2.fastq"
    gzip "${i}/A_2m_F_2_R2.fastq"

    zcat A_2m_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_2m_M_1_R1.fastq"
    gzip "${i}/A_2m_M_1_R1.fastq"

    zcat A_2m_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_2m_M_1_R2.fastq"
    gzip "${i}/A_2m_M_1_R2.fastq"

    zcat A_2m_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_2m_M_2_R1.fastq"
    gzip "${i}/A_2m_M_2_R1.fastq"

    zcat A_2m_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_2m_M_2_R2.fastq"
    gzip "${i}/A_2m_M_2_R2.fastq"
    
    
    zcat A_18m_F_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_18m_F_1_R1.fastq"
    gzip "${i}/A_18m_F_1_R1.fastq"

    zcat A_18m_F_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_18m_F_1_R2.fastq"
    gzip "${i}/A_18m_F_1_R2.fastq"

    zcat A_18m_F_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_18m_F_2_R1.fastq"
    gzip "${i}/A_18m_F_2_R1.fastq"

    zcat A_18m_F_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_18m_F_2_R2.fastq"
    gzip "${i}/A_18m_F_2_R2.fastq"

    zcat A_18m_M_1_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_18m_M_1_R1.fastq"
    gzip "${i}/A_18m_M_1_R1.fastq"

    zcat A_18m_M_1_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_18m_M_1_R2.fastq"
    gzip "${i}/A_18m_M_1_R2.fastq"

    zcat A_18m_M_2_R1.fastq.gz |  grep -A 3 "1:N:0:${i}" > "${i}/A_18m_M_2_R1.fastq"
    gzip "${i}/A_18m_M_2_R1.fastq"

    zcat A_18m_M_2_R2.fastq.gz |  grep -A 3 "2:N:0:${i}" > "${i}/A_18m_M_2_R2.fastq"
    gzip "${i}/A_18m_M_2_R2.fastq"
    
done < ../../ref/BARCODES.txt

mv GATCAG ../shallow_12A
mv TAGCTT ../shallow_12B
mv ATGTCA ../shallow_12C
mv CTTGTA ../shallow_12D
mv AGTCAA ../shallow_12E
mv AGTTCC ../shallow_12F

