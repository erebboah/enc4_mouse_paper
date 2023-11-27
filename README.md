# ENCODE 4 Mouse snRNA-seq and snATAC-seq Analysis

<img src="https://github.com/erebboah/enc4_mouse_paper/blob/main/enc4_mouse_sn_analysis.png" width="773" height="465">

## Overview
Postnatal timecourse of B6/Cast F1 hybrid mouse development in 5 core tissues: cortex, hippocampus, heart, adrenal gland, and gastrocnemius, at 7 timepoints for **Parse snRNA-seq**: PND04, PND10, PND14, PND25, PND36, PNM02, and PNM18-20 and 2 timepoints for **10x Multiome snRNA-seq+snATAC-seq**: PND14 and PNM02, with 2 males and 2 females per timepoint.

### Parse Demultiplexing
Code to run split-pipe per sublibrary (splitpipe_##.sh) and demultiplex fastqs for each sample (individual mouse) to submit to the ENCODE portal (run_demux_fastq.sh).
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/parse_demux)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/parse_demux)
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

### Integrated snRNA analysis
#### 10x Multiome
1. Download counts matrices from ENCODE snRNA standard pipeline
2. Cellbender
3. Scrublet

#### Parse snRNA-seq
1. Download counts matrices from ENCODE snRNA standard pipeline
2. Scrublet

### snATAC analysis
1. Download fragments files from ENCODE snATAC standard pipeline

## Contact info
Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

