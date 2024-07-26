# ENCODE4 Mouse snRNA-seq and snATAC-seq Analysis

## Cell type annotation overview

<img src="https://github.com/erebboah/enc4_mouse_paper/blob/main/enc4_mouse_sn_analysis.png" width="773" height="465">

Postnatal timecourse of B6/Cast F1 hybrid mouse development in 5 core tissues: cortex, hippocampus, heart, adrenal gland, and gastrocnemius, at 7 timepoints for **Parse snRNA-seq**: PND04, PND10, PND14, PND25, PND36, PNM02, and PNM18-20 and 2 timepoints for **10x Multiome snRNA-seq+snATAC-seq**: PND14 and PNM02, with 2 males and 2 females per timepoint.

### Parse snRNA Demultiplexing
Run split-pipe per sublibrary and demultiplex fastqs for each sample (individual mouse) for submissoion to the ENCODE portal:
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/parse_demux)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/parse_demux)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/parse_demux)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/parse_demux)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/parse_demux)
   - [B6CAST/5xFAD cortex/hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/5xfad_cast_brain/scripts/parse_demux)
   - [B6/5xFAD cortex/hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/5xfad_brain/scripts/parse_demux)

### Integrated snRNA analysis
Download snRNA-seq counts matrices from the ENCODE portal, filter genes, detect ambient RNA (Cellbender), and detect doublets (Scrublet):
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_adrenal/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_adrenal/)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_cortex/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_cortex/)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_hippocampus/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_hippocampus/)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_heart/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_heart/)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/preprocessing), [10x data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_10x_gastrocnemius/) and [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_gastrocnemius/)
   - B6CAST/5xFAD cortex/hippocampus [Parse data cart](https://www.encodeproject.org/carts/enc4_mouse_snrna_parse_5xfad_ctx_hc/)
   - B6/5xFAD cortex/hippocampus [GEO link](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE255965) and [ENCODE link](https://www.encodeproject.org/files/ENCFF237UOD/) to processed data

Integrated Seurat processing and **cell type annotation**. If the data includes 10x Multiome, snATAC preprocessing code must be run first! 10x Multiome nuclei are filtered by both RNA and ATAC quality metrics. Annotation of Seurat clusters is performed within Jupyter notebooks.
   - [B6CAST Adrenal](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/adrenal/scripts/annotation), [annotation notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/adrenal/scripts/annotation/ADR_snRNA_annotation.ipynb)
   - [B6CAST Cortex](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/cortex/scripts/annotation), [annotation notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/cortex/scripts/annotation/CX_snRNA_annotation.ipynb)
   - [B6CAST Hippocampus](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/hippocampus/scripts/annotation), [annotation notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/hippocampus/scripts/annotation/HC_snRNA_annotation.ipynb)
   - [B6CAST Heart](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/heart/scripts/annotation), [annotation notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/heart/scripts/annotation/HT_snRNA_annotation.ipynb)
   - [B6CAST Gastrocnemius](https://github.com/erebboah/enc4_mouse_paper/tree/main/snrna/gastrocnemius/scripts/annotation), [annotation notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/snrna/gastrocnemius/scripts/annotation/GC_snRNA_annotation.ipynb)
   - B6CAST/5xFAD cortex/hippocampus
   - B6/5xFAD cortex/hippocampus

### snATAC analysis
Download fragments files from ENCODE snATAC standard pipeline, construct ArchR projects, and filter nuclei by > 1,000 fragments, > 4 TSS enrichment, and remove doublets:
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

<img align="left" src="https://github.com/erebboah/enc4_mouse_paper/blob/main/enc4_topyfic_overview.png" width="441" height="572">

Run Topyfic on each tissue:
   - B6CAST Adrenal
   - B6CAST Cortex
   - B6CAST Hippocampus
   - B6CAST Heart
   - B6CAST Gastrocnemius

## Figure 1
[R Jupyter notebook for panels b-d](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Fig1.ipynb)
## Figure 2
[Python Jupyter notebook for panels a-g](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Fig2.ipynb)
## Figure 3
[Python Jupyter notebook for panels a-m](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Fig3.ipynb)
## Figure 4
[R Jupyter notebook for panels a-e](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Fig4_a-e.ipynb)
## Supplementary figures 1-5
[R Jupyter notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Supp_fig_1-5.ipynb)
## Supplementary figures 6-10
[R Jupyter notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Supp_fig_6-10.ipynb)
## Supplementary figure 11
[R Jupyter notebook](https://github.com/erebboah/enc4_mouse_paper/blob/main/figures/Supp_fig11.ipynb)

## Contact info
Liz Rebboah, Mortazavi Lab. erebboah@uci.edu

