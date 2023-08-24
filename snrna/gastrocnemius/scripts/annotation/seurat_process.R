library(Matrix)
library(stringr)
library(Seurat)  
library(ggplot2)  
library(glmGamPoi)
library(tidyverse)
library(MAST)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))

# Function to make Seurat objects
seurat_obj = function(tissue){
    counts = t(readMM(paste0("../../scanpy/merged/",tissue,"_sparse_matrix.mtx")))
    meta = read.csv(paste0("../../scanpy/merged/",tissue,"_obs.csv"))
    genes = read.csv(paste0("../../scanpy/merged/",tissue,"_genes.csv"))
    
    rownames(counts) = genes$gene_name
    colnames(counts) = meta$cellID
    rownames(meta) = meta$cellID
    
    obj = CreateSeuratObject(counts = counts, min.cells = 0, min.features = 0, meta.data = meta)
    obj[["percent.mt"]] = PercentageFeatureSet(obj, pattern = "^mt-")
    obj[["percent.ribo"]] <- PercentageFeatureSet(obj, pattern = "^Rp[sl][[:digit:]]|^Rplp[[:digit:]]|^Rpsa")
    out = obj
    }

# Make Seurat object
obj = seurat_obj(str_to_title(opt$tissue))

# Integrate by depth/technology
obj_10x = subset(obj, subset = technology == "10x")
obj_parse_standard = subset(obj, subset = technology == "Parse" & depth1 == "shallow")
obj_parse_deep = subset(obj, subset = technology == "Parse" & depth1 == "deep")

# Filter
#Use QC information in metadata to filter by # UMIs and # genes detected per nucleus, doublet scores, and percent mitochondrial gene expression.

obj_10x <- subset(obj_10x,
                  subset = nCount_RNA > unique(obj_10x$lower_nCount_RNA) &
                  nCount_RNA < unique(obj_10x$upper_nCount_RNA)  &
                  nFeature_RNA > unique(obj_10x$lower_nFeature_RNA) &
                  doublet_scores < unique(obj_10x$upper_doublet_scores) &
                  percent.mt < unique(obj_10x$upper_percent.mt))

obj_parse_standard <- subset(obj_parse_standard,
                            subset = nCount_RNA > unique(obj_parse_standard$lower_nCount_RNA) &
                            nCount_RNA < unique(obj_parse_standard$upper_nCount_RNA)  &
                            nFeature_RNA > unique(obj_parse_standard$lower_nFeature_RNA) &
                            doublet_scores < unique(obj_parse_standard$upper_doublet_scores) &
                            percent.mt < unique(obj_parse_standard$upper_percent.mt))

obj_parse_deep <- subset(obj_parse_deep,
                         subset = nCount_RNA > unique(obj_parse_deep$lower_nCount_RNA) &
                         nCount_RNA < unique(obj_parse_deep$upper_nCount_RNA)  &
                         nFeature_RNA > unique(obj_parse_deep$lower_nFeature_RNA) &
                         doublet_scores < unique(obj_parse_deep$upper_doublet_scores) &
                         percent.mt < unique(obj_parse_deep$upper_percent.mt))

# SCT + CCA normalization and integration 
#Use pretty standard Seurat pipeline to perform SCT normalization and integration. Create list of the 3 Seurat objects, use additional package to increase SCT speed. Use Parse standard Seurat object as reference dataset because it contains all timepoints, while 10x data only contains 2 timepoints.

obj.list = list(obj_10x,obj_parse_standard,obj_parse_deep)
names(obj.list) = c("10x","standard","deep")

obj.list <- lapply(X = obj.list, FUN = SCTransform, method = "glmGamPoi", 
                   vars.to.regress = c("percent.mt","nFeature_RNA"), verbose = T)

features <- SelectIntegrationFeatures(object.list = obj.list, nfeatures = 3000, verbose = T)
obj.list <- PrepSCTIntegration(object.list = obj.list, anchor.features = features, verbose = T)

reference_dataset <- which(names(obj.list) == "standard")

anchors <- FindIntegrationAnchors(object.list = obj.list, normalization.method = "SCT", 
    anchor.features = features, reference = reference_dataset, verbose = T)
combined.sct <- IntegrateData(anchorset = anchors, normalization.method = "SCT", verbose = T)

#Dimensionality reduction and clustering
#Standard Seurat processing with PCA, UMAP, SNN graph construction, and clustering
# PCA
DefaultAssay(combined.sct) = "integrated" # Make sure to cluster on the integrated assay
combined.sct <- RunPCA(combined.sct, verbose = T, npcs = 50)

# UMAP and clustering
combined.sct <- RunUMAP(combined.sct, reduction = "pca", dims = 1:30,verbose = T)
combined.sct <- FindNeighbors(combined.sct, reduction = "pca", dims = 1:30,verbose = T)
combined.sct <- FindClusters(combined.sct,verbose = T)

# Add cell cycle scores 
load("/dfs5/bio/erebboah/snrna/ref/mouse_cellcycle_genes.rda")
combined.sct<- CellCycleScoring(combined.sct, s.features = m.s.genes, g2m.features = m.g2m.genes)

saveRDS(combined.sct,file=paste0("../../seurat/",str_to_lower(opt$tissue),"_Parse_10x_integrated.rds"))
write.csv(combined.sct@meta.data,file=paste0("../../seurat/",str_to_lower(opt$tissue),"_Parse_10x_integrated_metadata.csv"))

## Call cluster marker genes 
DefaultAssay(combined.sct)= "RNA"
Idents(combined.sct) = "seurat_clusters"
markers <- FindAllMarkers(combined.sct, 
                          logfc.threshold = 0.25,
                          test.use = "MAST",
                          min.pct = 0.1,
                          verbose = TRUE,
                          only.pos = TRUE)

system("mkdir ../../seurat/markers/")
write.table(markers,file=paste0("../../seurat/markers/",str_to_lower(opt$tissue),"_cluster_marker_genes_only.pos_min.pct0.25_logfc.threshold0.25.tsv"),
            sep="\t",
            quote=F,
            row.names = F)
