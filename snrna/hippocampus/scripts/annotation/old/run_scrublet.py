import scrublet as scr
import scanpy as sc
import scipy.sparse as sparse
import scipy.io as sio
import os
import pandas as pd
import anndata
import glob
import numpy as np
from optparse import OptionParser

parser = OptionParser()

# add options
parser.add_option('-t', dest = 'tissue',
                  type = 'string',
                  help = 'tissue name',
                  metavar = "STRING")

(options, args) = parser.parse_args()
tissue = options.tissue

os.chdir("../../scrublet")

samples = glob.glob('*_matrix.mtx')
samples =[x[:-11] for x in samples]

for sample in samples:
    obs = pd.read_csv(sample + "_barcodes.csv")
    var = pd.read_csv(sample + "_genes.csv")
    adata = sc.read_mtx(sample + "_matrix.mtx").transpose()
    X = adata.X
    adata = anndata.AnnData(X=X, obs=obs, var=var)        
    print(sample)
    print(adata.X.shape[0])
    if adata.X.shape[0] <= 10: # if number of cells is very low, don't call doublets, fill in 
        adata.obs["doublet_scores"] = 0
    if adata.X.shape[0] > 10: # number of cells has to be more than number of PCs
        scrub = scr.Scrublet(adata.X)
        doublet_scores, predicted_doublets = scrub.scrub_doublets(min_counts=1, 
                                                                  min_cells=1, 
                                                                  min_gene_variability_pctl=85, 
                                                                  n_prin_comps=10)
        adata.obs["doublet_scores"] = doublet_scores
    adata.write_h5ad("../../scanpy/" + sample + ".h5ad") # save each sample-level anndata object in a folder


# merge samples 
filelist = glob.glob('../../scanpy/*.h5ad')
adata = sc.read(filelist[0])
adatas = []
for f in filelist[1:]:
    adatas.append(sc.read(f))
    
adata = adata.concatenate(adatas, join='outer', index_unique = None)

meta = pd.read_csv("/dfs5/bio/erebboah/snrna/ref/enc4_mouse_metadata_fixed.csv")
cols_to_use = meta.columns.difference(adata.obs.columns)
cols_to_use = cols_to_use.tolist()
cols_to_use.append('sublibrary_sample')

adata.obs = adata.obs.merge(meta[cols_to_use], how = "left", left_on = "sublibrary_sample", right_on = "sublibrary_sample")

adata.write_h5ad("../../scanpy/merged/" + tissue.capitalize() + ".h5ad")

# also save raw data outside h5ad to read into R
sparse_X = sparse.csr_matrix(adata.X)
sio.mmwrite("../../scanpy/merged/" + tissue.capitalize() + "_sparse_matrix.mtx",sparse_X)
adata.obs.to_csv("../../scanpy/merged/" + tissue.capitalize() + "_obs.csv")
adata.var.to_csv("../../scanpy/merged/" + tissue.capitalize() + "_genes.csv")
 

