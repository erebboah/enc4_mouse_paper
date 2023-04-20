# ENCODE 4 Mouse snRNA-seq and snATAC-seq Analysis
## Overview
Postnatal timecourse of Bl6/Cast F1 hybrid mouse development in 5 core tissues: cortex, hippocampus, heart, adrenal gland, and gastrocnemius, at 7 timepoints for snRNA-seq: PND04, PND10, PND14, PND25, PND36, PNM02, and PNM18-20 and 2 timepoints for multiome snRNA-seq+snATAC-seq: PND14 and PNM02, with 2 males and 2 females per timepoint.

## Contact info
Analyst: Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

### Left cerebral cortex
#### Data
- snRNA-seq ENCODE carts: [Parse](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse/), [10x](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x/)
- snATAC-seq ENCODE carts: [Parse](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse/), [10x](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x/)

#### Preprocessing 
##### snRNA-seq 
1. [step0_splitpipe_*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step0_splitpipe_12A.sh)  
2. [step1_splitfastq.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step1_splitfastq.sh) 
3. [step2_run_snakemake_starsolo_*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step2_run_snakemake_starsolo_12A.sh) 

##### snATAC-seq
1. [step1_get_data*.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step1_get_data.sh)  
2. [step2_archr.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step1_get_data.sh)  

#### Analysis
##### snRNA-seq
1. [step3_qc.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step3_qc.sh)
2. [step4_seurat.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/step4_seurat.sh)
3. step5_topyfic.sh (in progress)

##### snATAC-seq 
1. [step3_process_archr.sh](https://github.com/erebboah/enc4_mouse_paper/blob/main/snatac/cortex/scripts/step3_process_archr.sh) 
2. step4_topics_analysis.sh (in progress)

Note: All Parse snRNA-seq experiments were done at the Mortazavi lab while all 10x multiome experiments were done at the Snyder lab, from nuclei isolation to sequencing.
