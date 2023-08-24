library(Matrix)
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))
tissue = opt$tissue 

system("mkdir ../../parse")
setwd("../../parse")

# download tar.gz files
system(paste0("xargs -L 1 curl -O -J -L < ../../ref/encode_parse_",
              tolower(tissue),"_scrna_files.txt"))

# filter metadata
metadata = read.csv("../../ref/enc4_mouse_metadata_fixed.csv")
metadata = metadata[metadata$tissue == str_to_title(tissue),]
metadata = metadata[metadata$technology == "Parse",]

# loop through files, unzip, and change folder name to be human-readable sublibrary_sample
for (file in metadata$rna_file_accession){
    this_sample = metadata[metadata$rna_file_accession == file,]
    
    system(paste0("tar -xf ",this_sample$rna_file_accession,".tar.gz"))
    
    system(paste0("mv GeneFull_Ex50pAS/ ", this_sample$sublibrary_sample))
    }

system("rm *.tar.gz")