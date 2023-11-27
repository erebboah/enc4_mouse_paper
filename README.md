# ENCODE 4 Mouse snRNA-seq and snATAC-seq Analysis

<img src="https://github.com/erebboah/enc4_mouse_paper/blob/main/enc4_mouse_sn_analysis.png" width="773" height="465">

## Cell type annotation overview
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
Download snRNA-seq counts matrices from the ENCODE portal, filter genes, detect ambient RNA (Cellbender), and detect doublets (Scrublet):
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_adrenal/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_adrenal/)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_cortex/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_cortex/)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_hippocampus/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_hippocampus/)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_heart/) and [Parse cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_heart/)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_gastrocnemius/) and [Parse cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_gastrocnemius/)
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

Integrated Seurat processing and cell type annotation, which are run AFTER snATAC preprocessing code!
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/annotation)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/annotation)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/annotation)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/annotation)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/annotation)
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

### snATAC analysis
Download fragments files from ENCODE snATAC standard pipeline, construct ArchR projects, and filter nuclei by > 1,000 fragments, > 4 TSS enrichment, and remove ArchR doublets:
   - B6CAST Adrenal
   - B6CAST Cortex
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius

Carry over cell type annotations to ArchR projects and further processing:
   - B6CAST Adrenal
   - B6CAST Cortex
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius

## Topics Modeling Overview

Run Topyfic on each tissue:
   - B6CAST Adrenal
   - B6CAST Cortex
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius

## Figure 1
## Figure 2
## Figure 3

## Contact info
Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

