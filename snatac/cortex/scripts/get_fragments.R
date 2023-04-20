library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))

system("mkdir ../fragments")
setwd("../fragments")
system(paste0("xargs -L 1 curl -O -J -L < ../ref/encode_",
              tolower(opt$tissue),"_10x_fragment_files.txt"))

metadata = read.csv("../ref/enc4_mouse_snatac_metadata.csv")
metadata = metadata[metadata$tissue == str_to_title(opt$tissue),]

for (file in metadata$file_accession){
    meta = metadata[metadata$file_accession == file,]
    
    system(paste0("tar -xf ",meta$file_accession,".tar.gz"))
    
    system(paste0("mv encode_scatac_dcc_2/results/",
                  meta$experiment_accession,"-1/ ",meta$sample))
    }

system("rm -r encode_scatac_dcc_2")