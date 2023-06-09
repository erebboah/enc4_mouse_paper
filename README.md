# ENCODE 4 Mouse snRNA-seq and snATAC-seq Analysis
## Overview
Postnatal timecourse of Bl6/Cast F1 hybrid mouse development in 5 core tissues: cortex, hippocampus, heart, adrenal gland, and gastrocnemius, at 7 timepoints for snRNA-seq: PND04, PND10, PND14, PND25, PND36, PNM02, and PNM18-20 and 2 timepoints for multiome snRNA-seq+snATAC-seq: PND14 and PNM02, with 2 males and 2 females per timepoint.

## Contact info
Analyst: Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

### Left cerebral cortex
#### Data
- snRNA-seq ENCODE carts: [Parse](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse/), [10x](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x/)
- [snATAC-seq ENCODE cart](https://www.encodeproject.org/carts/enc4_mouse_snatac/)

#### Preprocessing 
##### snRNA-seq 
1. [step0_splitpipe_*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step0_splitpipe_12A.sh) Run split-pipe on each sublibrary separately. Specify which samples belong to which round 1 barcoding well.
2. [step1_splitfastq.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step1_splitfastq.sh) Split fastqs based on results of split-pipe: cell metadata and barcoded fastq. Split each pair original fastqs.
3. [step2_run_snakemake_starsolo_*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step2_run_snakemake_starsolo_12A.sh) Using sublibrary- and sample-demultiplexed fastqs as input into ENCODE STARSolo pipeline. Need 1 [config file](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/shallow_12A/C_4_F_1_config.yaml) per sublibrary/sample. 

##### snATAC-seq
1. [step1_get_data*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step1_get_data.sh)  
2. [step2_archr.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step1_get_data.sh)  

#### Analysis
##### snRNA-seq
1. [step3_qc.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step3_qc.sh) Must run snATAC-seq preprocessing steps to use both RNA and ATAC QC metrics to filter multiome cells. 
2. [step4_seurat.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step4_seurat.sh)
3. step5_topyfic.sh (in progress)

##### snATAC-seq 
1. [step3_process_archr.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step3_process_archr.sh) 
2. step4_topics_analysis.sh (in progress)

