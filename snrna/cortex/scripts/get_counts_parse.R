# Load and format data
library(Matrix)
library(stringr)
library(Seurat)
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))


#Read in gene reference and filter by biotypes of interst
metadata = read.csv("../ref/enc4_mouse_metadata_fixed.csv")
metadata = metadata[metadata$technology == "Parse",]
metadata = metadata[metadata$tissue == str_to_title(opt$tissue),]

gene_id_to_name = read.delim("../ref/geneInfo.tab",header=F,col.names=c("gene_id","gene_name","gene_type"))
gene_id_to_name = gene_id_to_name[-1,]

gene_id_to_name = gene_id_to_name[gene_id_to_name$gene_type %in% c("protein_coding",
                                                                      "miRNA",
                                                                      # lncRNA https://www.gencodegenes.org/pages/biotypes.html
                                                                      "3prime_overlapping_ncRNA",
                                                                      "antisense",
                                                                      "bidirectional_promoter_lncRNA",
                                                                      "lincRNA",
                                                                      "macro_lncRNA",
                                                                      "non_coding",
                                                                      "processed_transcript",
                                                                      "sense_intronic",
                                                                      "sense_overlapping",
                                                                      # pseudogenes
                                                                      "processed_pseudogene",
                                                                      "transcribed_unprocessed_pseudogene",
                                                                      "unprocessed_pseudogene",
                                                                      "transcribed_processed_pseudogene",
                                                                      "unitary_pseudogene",
                                                                      "pseudogene",
                                                                      "polymorphic_pseudogene",
                                                                      "transcribed_unitary_pseudogene",
                                                                      "translated_unprocessed_pseudogene"),]



# Read in data and filter
## 1. gene with biotype specified above 
## 2. > 500 UMIs/nucleus 

get_counts = function(this_sample){
    depth1 = do.call("rbind", strsplit(this_sample, "_"))[,1]
    sublibrary = do.call("rbind", strsplit(this_sample, "_"))[,2]
    sublibrary = do.call("rbind", strsplit(sublibrary, "/"))[,1]
    sample = do.call("rbind", strsplit(this_sample, "/"))[,2]
    meta = metadata[metadata$depth1 == depth1,]
    meta = meta[meta$sublibrary == sublibrary,]
    meta = meta[meta$sample == sample,]    

    path = paste0("../",this_sample, "/GeneFull_Ex50pAS/raw/")
    barcodes = read.delim(paste0(path,'barcodes.tsv'),header = F, col.names="barcode")
    counts = readMM(paste0(path,'UniqueAndMult-EM.mtx'))
    features = read.delim(paste0(path,'features.tsv'),header = F) 
    
    rownames(counts) = features$V1
    colnames(counts) = barcodes$barcode
    
    counts = counts[,colSums(counts) > 500] # > 500 UMI
    counts = counts[rownames(counts) %in% gene_id_to_name$gene_id,]
    out = counts

}

all_samples = paste0(metadata$depth1, "_",metadata$sublibrary,"/",metadata$sample)

for (i in 1:length(all_samples)){
    counts = get_counts(all_samples[i])
    
    depth1 = do.call("rbind", strsplit(all_samples[i], "_"))[,1]
    sublibrary = do.call("rbind", strsplit(all_samples[i], "_"))[,2]
    sublibrary = do.call("rbind", strsplit(sublibrary, "/"))[,1]
    sample = do.call("rbind", strsplit(all_samples[i], "/"))[,2]
    
    meta = metadata[metadata$depth1 == depth1,]
    meta = meta[meta$sublibrary == sublibrary,]
    meta = meta[meta$sample == sample,]
    
    barcodes = data.frame(barcode = colnames(counts))
    barcodes$depth1 = depth1
    barcodes$sublibrary = sublibrary
    barcodes$sample = sample
    barcodes$cellID = paste0(barcodes$barcode,".",barcodes$sublibrary,".",barcodes$sample)
    barcodes$sublibrary_sample = paste0(barcodes$sublibrary,"_",barcodes$sample)
    
    genes = gene_id_to_name[gene_id_to_name$gene_id %in% rownames(counts),]
    genes = genes[match(rownames(counts), gene_id_to_name$gene_id),]
    
    writeMM(counts,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_matrix.mtx"))
    write.csv(barcodes,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_barcodes.csv"),quote=F,row.names=F)
    write.csv(genes,file=paste0("../scrublet/",paste0(meta$sublibrary,".",meta$sample),"_genes.csv"),quote=F,row.names=F)    
}