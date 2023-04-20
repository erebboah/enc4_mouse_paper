library(Matrix)
library(Seurat)
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))

metadata = read.csv("../ref/enc4_mouse_metadata_fixed.csv")
metadata = metadata[metadata$technology == "10x",]
metadata = metadata[metadata$tissue == str_to_title(opt$tissue),]


gene_id_to_name = read.delim("../ref/geneInfo.tab",header=F,col.names=c("gene_id","gene_name","gene_type"))
genes_orig = read.delim("../ref/original_geneIDs.tsv",header=F,col.names=c("gene_id","gene_name","assay"))
parse_genes = read.csv("../ref/parse_genes.csv")

snatac_meta = read.csv(paste0("../../../snatac/",
                              tolower(opt$tissue),"/ref/enc4_mouse_",
                              tolower(opt$tissue),"_snatac_metadata.csv"))

all_samples = paste0(metadata$depth1, "_",metadata$sublibrary,"/",metadata$sample)

for (i in 1:length(all_samples)){
    depth1 = do.call("rbind", strsplit(all_samples[i], "_"))[,1]
    sublibrary = do.call("rbind", strsplit(all_samples[i], "_"))[,2]
    sublibrary = do.call("rbind", strsplit(sublibrary, "/"))[,1]
    sample = do.call("rbind", strsplit(all_samples[i], "/"))[,2]
    
    meta = metadata[metadata$depth1 == depth1,]
    meta = meta[meta$sublibrary == sublibrary,]
    meta = meta[meta$sample == sample,]
    
    counts = Read10X_h5(paste0("../", all_samples[i],"/cellbender.h5"),unique.features = FALSE)
    colnames(counts) = paste0(do.call("rbind", strsplit(colnames(counts), "[.]"))[,1],
                           ".",sublibrary,".",sample)
    # filter > 500 UMI
    counts = counts[,colSums(counts) > 500] # > 500 UMI
    
    # filter for cells also passing snATAC filters
    counts = counts[,colnames(counts) %in% snatac_meta$cellID]

    barcodes = data.frame(cellID = colnames(counts))
    barcodes$depth1 = depth1
    barcodes$sublibrary = sublibrary
    barcodes$sample = sample
    barcodes$sublibrary_sample = paste0(barcodes$sublibrary,"_",barcodes$sample)
    barcodes = left_join(barcodes,snatac_meta[,!(colnames(snatac_meta) %in% colnames(meta))], by = "cellID")
    barcodes$archr_cellID = barcodes$X
    barcodes$X = NULL
    
    # match genes to Parse genes
    genes = data.frame(gene_name = rownames(counts))
    genes_orig = genes_orig[genes_orig$gene_name %in% genes$gene_name,]
    genes = left_join(genes_orig, gene_id_to_name)
    genes$assay = NULL
    table(genes$gene_name == rownames(counts))
    rownames(counts) = genes$gene_id
    
    genes = genes[genes$gene_id %in% parse_genes$gene_id,]
    counts = counts[rownames(counts) %in% parse_genes$gene_id,]
    genes = genes[match(parse_genes$gene_id, genes$gene_id),]
    counts = counts[match(parse_genes$gene_id, rownames(counts)),]
    
    writeMM(counts,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_matrix.mtx"))
    write.csv(barcodes,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_barcodes.csv"),quote=F,row.names=F)
    write.csv(genes,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_genes.csv"),quote=F,row.names=F) 
    
}