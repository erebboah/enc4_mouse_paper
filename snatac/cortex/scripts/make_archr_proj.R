library(Seurat)
suppressPackageStartupMessages(library(ArchR))
set.seed(1234)
library(parallel)
addArchRThreads(16)
addArchRGenome("mm10")
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))

system("mkdir ../archr")
setwd("../archr")
metadata = read.csv("../ref/enc4_mouse_snatac_metadata.csv")
metadata = metadata[metadata$tissue == str_to_title(opt$tissue),]

# read in fragment files from ENCODE portal
inputFiles = paste0("../fragments/",metadata$sample,
                    "/fragments/fragments.tsv.gz")

names(inputFiles) = metadata$sample

ArrowFiles <- createArrowFiles(
  inputFiles = inputFiles,
  sampleNames = names(inputFiles),
  offsetPlus = 0,
  offsetMinus = 0,
  minTSS = 4,
  minFrags = 1000, 
  excludeChr = c("chrM"),
  addTileMat = TRUE,
  addGeneScoreMat = TRUE
)

# make archr project
proj <- ArchRProject(
  ArrowFiles = ArrowFiles, 
  outputDirectory = paste0("ENC4_Mouse_",str_to_title(opt$tissue)))

# match ATAC barcodes to RNA barcodes
proj_meta = as.data.frame(proj@cellColData)
proj_meta$cellNames = rownames(proj_meta)
proj_meta$sample = proj$Sample

# read in 10x barcode sequences
atac_bcs = read.delim("../ref/atac_737K-arc-v1.txt",header = F)
rna_bcs = read.delim("../ref/gene_exp_737K-arc-v1.txt",header = F)
bcs = cbind(atac_bcs,rna_bcs)
colnames(bcs) = c("atac_bc","rna_bc")

# match RNA and ATAC cell barcodes
proj_meta$atac_bc = do.call("rbind", strsplit(as.character(proj_meta$cellNames), "#"))[,2]
proj_meta$atac_bc = toupper(spgs::reverseComplement(proj_meta$atac_bc))

proj_meta = dplyr::left_join(proj_meta, bcs) # merge by atac_bc
proj_meta$cellID = paste0(proj_meta$rna_bc,
                          ".10x.",proj_meta$sample) # re-create RNA cell IDs

table(proj_meta$cellNames == proj$cellNames)
proj$original_atac_bc= do.call("rbind", strsplit(proj$cellNames, "#"))[,2]
proj$atac_bc = proj_meta$atac_bc
proj$rna_bc = proj_meta$rna_bc
proj$cellID = proj_meta$cellID
proj$sample = proj$Sample

# add doublet scores and filter
proj = addDoubletScores(proj, k = 10, knnMethod = "LSI")
proj = filterDoublets(proj)

write.csv(as.data.frame(proj@cellColData),
          file=paste0("../ref/enc4_mouse_",tolower(opt$tissue),"_snatac_metadata.csv"))

saveArchRProject(
  ArchRProj = proj,
  outputDirectory = paste0("ENC4_Mouse_",str_to_title(opt$tissue))
)
