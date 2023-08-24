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
metadata = metadata[metadata$technology == "Parse",]

# selected genes
gene_id_to_name = read.delim("../../../ref/geneInfo.tab",header=F,col.names=c("gene_id","gene_name","gene_type"))
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


write.csv(gene_id_to_name, file = "../../../ref/parse_genes.csv")

samples = metadata$sublibrary_sample

for (sample in metadata$sublibrary_sample){
    this_sample = metadata[metadata$sublibrary_sample == sample,]
        
    path = paste0("../../parse/",this_sample$sublibrary_sample,"/raw/")
    barcodes = read.delim(paste0(path,'barcodes.tsv'),header = F, col.names="cellID")
    counts =  readMM(paste0(path,'UniqueAndMult-EM.mtx'))
    features = read.delim(paste0(path,'features.tsv'),header = F) 
    
    rownames(counts) = features$V1 # gene id!!
    
    if (this_sample$depth1 == "standard") {
        colnames(counts) = barcodes$cellID
    } else {    
        colnames(counts) = paste0(this_sample$rna_library_accession, "-", barcodes$cellID)
    }
        
    # filter > 500 UMI
    counts = counts[,colSums(counts) > 500] # > 500 UMI
    
    # make metadata 
    barcodes = data.frame(cellID = colnames(counts))
    barcodes$sublibrary_sample = sample
    barcodes = left_join(barcodes, metadata)
    barcodes$rna_bc = do.call("rbind", strsplit(barcodes$cellID, "-"))[,2]
    
    # filter genes
    counts = counts[rownames(counts) %in% gene_id_to_name$gene_id,]
    counts = counts[match(gene_id_to_name$gene_id, rownames(counts)),]
    
    # save
    writeMM(counts,file=paste0("../../scrublet/",sample,"_matrix.mtx"))
    write.csv(barcodes,file=paste0("../../scrublet/",sample,"_barcodes.csv"),quote=F,row.names=F)
    write.csv(gene_id_to_name,file=paste0("../../scrublet/",sample,"_genes.csv"),quote=F,row.names=F) 

}
