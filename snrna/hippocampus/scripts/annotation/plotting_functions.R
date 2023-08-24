knee_df = function(mtx,expt_name){
    df = as.data.frame(colSums(mtx))
    colnames(df) = c("nUMI")
    df <- tibble(total = df$nUMI,
               rank = row_number(dplyr::desc(total))) %>%
    distinct() %>%
    arrange(rank)
    df$experiment = expt_name
    out = df
}

# Function to predict celltypes from reference data
predict_celltypes = function(igvf_object, ref_object, ref_object_label, predictions_label){
    DefaultAssay(igvf_object) <- "SCT"
    DefaultAssay(ref_object) <- "SCT"

    transfer_anchors <- FindTransferAnchors(
        reference = ref_object,
        query = igvf_object,
        reference.assay = "SCT",
        features = rownames(igvf_object)[rownames(igvf_object) %in% rownames(ref_object)],
        normalization.method = "SCT",
        reference.reduction = "pca",
        recompute.residuals = FALSE,
        dims = 1:50,
        verbose = F)
    
    # gen_celltype
    predictions <- TransferData(
        anchorset = transfer_anchors, 
        refdata = ref_object@meta.data[,colnames(ref_object@meta.data) %in% ref_object_label], 
        weight.reduction = igvf_object[['pca']],
        dims = 1:50,
        verbose = F)

    igvf_object <- AddMetaData(
        object = igvf_object,
        metadata = predictions)
    
    igvf_object@meta.data[[predictions_label]] = igvf_object$predicted.id
         
    out = igvf_object

    }

proportion_barplot = function(metadata, x, fill, xlabel){
    ggplot(metadata, aes(x=x, fill=fill)) + 
    geom_bar(position = "fill") + 
    ylab("Proportion") + xlab(xlabel) + theme_minimal() + 
    theme(text=element_text(size=21), axis.text.x = element_text(angle = 45, hjust = 1))

}

set1_cols = function(metadata, x){
    nclusters = length(unique(metadata[,colnames(metadata) == x]))
    cols = sample(colorRampPalette(brewer.pal(9,"Set1"))(nclusters))
    out = cols
}

set3_cols = function(metadata, x){
    nclusters = length(unique(metadata[,colnames(metadata) == x]))
    cols = sample(colorRampPalette(brewer.pal(12,"Set3"))(nclusters))
    out = cols
}

spectral_cols = function(metadata, x){
    nclusters = length(unique(metadata[,colnames(metadata) == x]))
    cols = colorRampPalette(brewer.pal(11,"Spectral"))(nclusters)
    out = cols
}

featureplot = function(obj,features){
    ncol = ifelse(length(features) > 9, 4, 3)
    print(FeaturePlot(obj, pt.size = 0.1,
            features = features, ncol = ncol,order=T) &
            scale_colour_gradientn(colors = viridis(11)) &
            NoAxes() & 
            theme(text = element_text(size = 18)))
}