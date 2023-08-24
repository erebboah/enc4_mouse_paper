library(Matrix)
library(Seurat)
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))
tissue = opt$tissue

# filter metadata
metadata = read.csv("../../../ref/enc4_mouse_metadata_fixed.csv")
metadata = metadata[metadata$tissue == str_to_title(tissue),]
metadata = metadata[metadata$technology == "10x",]

# get a lot of gene metadata -- fixing my mistake of setting gene names and not ids initially...
gene_id_to_name = read.delim("../../../ref/geneInfo.tab",header=F,col.names=c("gene_id","gene_name","gene_type"))
genes_orig = read.delim("../../../ref/original_geneIDs.tsv",header=F,col.names=c("gene_id","gene_name","assay"))
parse_genes = read.csv("../../../ref/parse_genes.csv")

# get snatac metadata to exclude nuclei that failed snatac filters
snatac_meta = read.csv(paste0("../../../../snatac/ref/enc4_mouse_",
                              tolower(tissue),"_snatac_metadata.csv"))

samples = metadata$sublibrary_sample

for (sample in samples){
    this_sample = metadata[metadata$sublibrary_sample == sample, ]
    
    # read in cellbender h5
    counts = Read10X_h5(paste0("../../10x/", sample, "/cellbender.h5"),unique.features = FALSE)
    
    # set column names (cellID)
    rna_bc = do.call("rbind", strsplit(colnames(counts), "[.]"))[,1]
    colnames(counts) = paste0(this_sample$rna_library_accession, "-", rna_bc)
    
    # filter > 500 UMI
    counts = counts[,colSums(counts) > 500] # > 500 UMI
    
    # filter for cells also passing snATAC filters
    counts = counts[,colnames(counts) %in% snatac_meta$cellID]
    
    # make metadata -- sync up ATAC and RNA
    barcodes = data.frame(cellID = colnames(counts))
    barcodes$sublibrary_sample = sample
    barcodes = left_join(barcodes, metadata)
    barcodes = left_join(barcodes, snatac_meta)
    barcodes$atac_cellNames = barcodes$X
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
    
    table(genes$gene_id == rownames(counts))
    
    # save
    writeMM(counts,file=paste0("../../scrublet/",sample,"_matrix.mtx"))
    write.csv(barcodes,file=paste0("../../scrublet/",sample,"_barcodes.csv"),quote=F,row.names=F)
    write.csv(genes,file=paste0("../../scrublet/",sample,"_genes.csv"),quote=F,row.names=F) 
    
}