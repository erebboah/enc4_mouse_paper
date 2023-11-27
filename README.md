# ENCODE 4 Mouse snRNA-seq and snATAC-seq Analysis

<img src="https://github.com/erebboah/enc4_mouse_paper/blob/main/enc4_mouse_sn_analysis.png" width="773" height="465">

## Overview
Postnatal timecourse of B6/Cast F1 hybrid mouse development in 5 core tissues: cortex, hippocampus, heart, adrenal gland, and gastrocnemius, at 7 timepoints for **Parse snRNA-seq**: PND04, PND10, PND14, PND25, PND36, PNM02, and PNM18-20 and 2 timepoints for **10x Multiome snRNA-seq+snATAC-seq**: PND14 and PNM02, with 2 males and 2 females per timepoint.

### Parse Demultiplexing
Code to run split-pipe per sublibrary (splitpipe_##.sh) and demultiplex fastqs for each sample (individual mouse) to submit to the ENCODE portal (run_demux_fastq.sh):
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/parse_demux)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/parse_demux)
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

### Integrated snRNA analysis
Code to download 10x counts matrices from the ENCODE portal
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_adrenal/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_adrenal/)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_cortex/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_cortex/)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_hippocampus/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_hippocampus/)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/preprocessing)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/preprocessing)
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

Code for Seurat processing and cell type annotation:

### snATAC analysis
Code to download fragments files from ENCODE snATAC standard pipeline

## Contact info
Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

