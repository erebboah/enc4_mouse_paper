source ~/miniconda3/bin/activate dcc2

module load singularity
cd /dfs5/bio/erebboah/snrna/adrenal/shallow_12F/

cd A_4_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_4_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_4_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_4_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_4_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_4_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_4_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_4_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

#####

cd ../A_10_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_10_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_10_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_10_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_10_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_10_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_10_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_10_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

#####

cd ../A_14_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_14_F_1_config.yaml

cd ../A_14_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_14_F_2_config.yaml

cd ../A_14_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_14_M_1_config.yaml

cd ../A_14_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_14_M_2_config.yaml

#####

cd ../A_25_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_25_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_25_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_25_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_25_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_25_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_25_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_25_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

#####

cd ../A_36_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_36_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_36_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_36_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_36_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_36_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_36_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_36_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

#####

cd ../A_2m_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_2m_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_2m_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_2m_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_2m_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_2m_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_2m_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_2m_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

#####

cd ../A_18m_F_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_18m_F_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_18m_F_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_18m_F_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_18m_M_1
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_18m_M_1_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz

cd ../A_18m_M_2
snakemake --use-singularity --snakefile ../../../woldlab-rna-seq/workflow/process-encode-splitseq.snakefile --cluster "sbatch -A SEYEDAM_LAB -t 001:00:00 -p standard -N 1 --mem 32G" --jobs 20 --cores 20 --configfile ../A_18m_M_2_config.yaml
tar -xf GeneFull_Ex50pAS_EM_raw.tar.gz
