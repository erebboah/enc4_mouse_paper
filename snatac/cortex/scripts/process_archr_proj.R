library(Seurat)
suppressPackageStartupMessages(library(ArchR))
set.seed(1234)
library(parallel)
addArchRThreads(16)
addArchRGenome("mm10")
library(tidyverse)

tissue = "cortex"

setwd("../archr/")

proj = loadArchRProject(path = paste0("ENC4_Mouse_",str_to_title(tissue)))

proj_meta = as.data.frame(proj@cellColData)

rna_metadata = read.csv(paste0("../../../snrna/",str_to_lower(tissue),"/seurat/",str_to_lower(tissue),"_Parse_10x_integrated_metadata.csv"),row.names = "X")

print("how many ATAC cells passed RNA filters?")
table(proj_meta$cellID %in% rna_metadata$cellID)

# filter cells from ATAC that are not in RNA
atac_cells_filt = proj$cellNames[proj_meta$cellID %in% rna_metadata$cellID]
proj = subsetArchRProject(
    ArchRProj = proj,
    outputDirectory = paste0("ENC4_Mouse_",str_to_title(tissue)),
    cells = atac_cells_filt,
    dropCells = TRUE,
    force = TRUE)

# archr processing
proj = addIterativeLSI(proj, sampleCellsPre = 40000, varFeatures = 100000,
                       useMatrix = "TileMatrix",name = "IterativeLSI", force = T)

proj = addClusters(proj, maxClusters = 40, 
                   reducedDims = "IterativeLSI",
                   force = TRUE)

proj = addUMAP(proj, reducedDims = "IterativeLSI", force = T)


# add metadata from RNA cell type annotation
proj_meta = as.data.frame(proj@cellColData)
proj_meta = as.data.frame(proj_meta[,c("cellID")])
colnames(proj_meta) = "cellID"
proj_meta = dplyr::left_join(proj_meta, rna_metadata, "cellID") # merge by cellID

atac_metadata = read.csv(paste0("../ref/enc4_mouse_snatac_metadata.csv"))
atac_metadata = atac_metadata[,c("rna_experiment_accession","library_accession",
                                 "rna_library_accession",
                                 "rna_experiment_accession","experiment_accession",
                                "file_accession","multiome_experiment_accession")]
proj_meta = dplyr::left_join(proj_meta, atac_metadata, "rna_experiment_accession") # merge by rna_experiment_access
table(proj_meta$cellID == proj$cellID) # sanity check

# add selected RNA metadata to ATAC
proj$nCount_RNA= proj_meta$nCount_RNA
proj$nFeature_RNA= proj_meta$nFeature_RNA
proj$sublibrary_sample= proj_meta$sublibrary_sample
proj$sublibrary= proj_meta$sublibrary
proj$batch= proj_meta$batch
proj$archr_cellID= proj_meta$archr_cellID
proj$percent.mt= proj_meta$percent.mt
proj$percent.ribo= proj_meta$percent.ribo
proj$seurat_clusters= proj_meta$seurat_clusters
proj$depth2 = proj_meta$depth2

proj$technology= proj_meta$technology
proj$genotype= proj_meta$genotype
proj$timepoint= proj_meta$timepoint
proj$sex= proj_meta$sex
proj$rep= proj_meta$rep
proj$tissue = proj_meta$tissue
proj$sample = proj_meta$sample
proj$gen_celltype = proj_meta$gen_celltype
proj$celltypes = proj_meta$celltypes
proj$subtypes = proj_meta$subtypes

proj$rna_experiment_accession = proj_meta$rna_experiment_accession
proj$library_accession = proj_meta$library_accession
proj$rna_library_accession = proj_meta$rna_library_accession
proj$rna_experiment_accession = proj_meta$rna_experiment_accession
#proj$experiment_accession = proj_meta$experiment_accession
proj$file_accession = proj_meta$file_accession
proj$multiome_experiment_accession = proj_meta$multiome_experiment_accession


proj$max_topic = proj_meta$max_topic

p1 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "sample", embedding = "UMAP")
p2 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "sex", embedding = "UMAP")
p3 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "timepoint", embedding = "UMAP")
p4 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "gen_celltype", embedding = "UMAP")
p5 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "celltypes", embedding = "UMAP")
p6 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "subtypes", embedding = "UMAP")

plotPDF(p1,p2,p3,p4,p5,p6, name = "Plot-UMAP-Sample-Clusters.pdf", 
        ArchRProj = proj, addDOC = FALSE, width = 5, height = 5)

saveArchRProject(
  ArchRProj = proj,
  outputDirectory = paste0("ENC4_Mouse_",str_to_title(tissue)),
)
