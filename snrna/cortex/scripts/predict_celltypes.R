library(stringr)
library(Seurat)  
library(ggplot2)  
library(tidyverse)
library(optparse)
 
option_list = list(
  make_option(c("-t", "--tissue"), type="character", default=NULL, 
              help="tissue name", metavar="character")
)

opt = parse_args(OptionParser(option_list=option_list))
tissue = str_to_lower(opt$tissue)

source("plotting_functions.R")

if (tissue == "heart") {
    obj = readRDS(paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
    ref_obj = readRDS("/share/crsp/lab/seyedam/share/igvf_splitseq/igvf_003/ref/external_data/heart_reference_combined.rds")
    obj = predict_celltypes(obj, ref_obj, "celltypes", "predictions")
    
    saveRDS(obj, file=paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
} else if (tissue == "gastrocnemius") {
    obj = readRDS(paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
    ref_obj = readRDS("/share/crsp/lab/seyedam/share/igvf_splitseq/igvf_006/ref/external_data/ta_5month_sct.rds")
    obj = predict_celltypes(obj, ref_obj, "celltypes", "predictions_5mo")

    ref_obj = readRDS("/share/crsp/lab/seyedam/share/igvf_splitseq/igvf_006/ref/external_data/ta_pnd21_sct.rds")
    obj = predict_celltypes(obj, ref_obj, "celltypes", "predictions_pnd21")
    
    saveRDS(obj, file=paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))

} else if (tissue == "cortex") {
    obj = readRDS(paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
    ref_obj = readRDS("/share/crsp/lab/seyedam/share/igvf_splitseq/igvf_003/ref/external_data/brain_atlas.rds")
    obj = predict_celltypes(obj, ref_obj, "subclass_label","predictions")

    ref_obj = readRDS("/dfs5/bio/erebboah/snrna/5xfad_cast_brain/ref/mousebrain_adolescent_all.rds")
    obj = predict_celltypes(obj, ref_obj, "ClusterName","all_adolescent_predictions")

    ref_obj = readRDS("/dfs5/bio/erebboah/snrna/5xfad_cast_brain/ref/mousebrain_adolescent_cortex_hippocampus.rds")
    obj = predict_celltypes(obj, ref_obj, "ClusterName","ctx_hc_adolescent_predictions")

    saveRDS(obj, file=paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
} else if (tissue == "hippocampus") {
    obj = readRDS(paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))
    
    ref_obj = readRDS("/share/crsp/lab/seyedam/share/igvf_splitseq/igvf_003/ref/external_data/brain_atlas.rds")
    obj = predict_celltypes(obj, ref_obj, "subclass_label","predictions")

    ref_obj = readRDS("/dfs5/bio/erebboah/snrna/5xfad_cast_brain/ref/mousebrain_adolescent_all.rds")
    obj = predict_celltypes(obj, ref_obj, "ClusterName","all_adolescent_predictions")

    ref_obj = readRDS("/dfs5/bio/erebboah/snrna/5xfad_cast_brain/ref/mousebrain_adolescent_cortex_hippocampus.rds")
    obj = predict_celltypes(obj, ref_obj, "ClusterName","ctx_hc_adolescent_predictions")

    saveRDS(obj, file=paste0("../seurat/",tissue,"_Parse_10x_integrated.rds"))

} else {
print("Enter valid tissue (no external reference for adrenal gland)")
}

