library(Matrix)
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))
tissue = opt$tissue 

system("mkdir ../../10x")
setwd("../../10x")

# download tar.gz files
system(paste0("xargs -L 1 curl -O -J -L < ../../ref/encode_10x_",
              tolower(tissue),"_scrna_files.txt"))

# filter metadata
metadata = read.csv("../../ref/enc4_mouse_metadata_fixed.csv")
metadata = metadata[metadata$tissue == str_to_title(tissue),]
metadata = metadata[metadata$technology == "10x",]

# loop through files, unzip, and change folder name to be human-readable sublibrary_sample
for (file in metadata$rna_file_accession){
    this_sample = metadata[metadata$rna_file_accession == file,]
    
    system(paste0("tar -xf ",this_sample$rna_file_accession,".tar.gz"))
    
    system(paste0("mv GeneFull_Ex50pAS/ ", this_sample$sublibrary_sample))
    }

system("rm *.tar.gz")

setwd("../scripts/preprocessing")

# format data 
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

for (sample in metadata$sublibrary_sample){
    this_sample = metadata[metadata$sublibrary_sample == sample,]
    
    path = paste0("../../10x/",this_sample$sublibrary_sample,"/raw/")
    barcodes = read.delim(paste0(path,'barcodes.tsv'),header = F, col.names="barcode")
    counts = readMM(paste0(path,'UniqueAndMult-EM.mtx'))
    features = read.delim(paste0(path,'features.tsv'),header = F) 
    
    rownames(counts) = features$V2 
    colnames(counts) = barcodes$barcode 
    
    counts = counts[rownames(counts) %in% gene_id_to_name$gene_name,]
    counts = counts[,colSums(counts) > 0] # > 0 UMI
    
    writeMM(counts,file=paste0("../../10x/",sample,"/matrix.mtx"))
    write.table(colnames(counts),file=paste0("../../10x/",sample,"/barcodes.tsv"),quote=F,row.names=F,col.names=F,sep="\t")
    write.table(rownames(counts),file=paste0("../../10x/",sample,"/genes.tsv"),quote=F,row.names=F,col.names=F,sep="\t")

}