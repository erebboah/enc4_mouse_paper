import pandas as pd
import ternary
import matplotlib.pyplot as plt
import matplotlib as mpl
from sklearn import preprocessing
from collections import defaultdict
import matplotlib.ticker as tck
import numpy as np
import pdb

def plot_simplex(df,

            # arguments for which things are shown
            left,
            right,
            bottom,
                 

            # arguments for what plotting style is used
            density=False, # used in main, passed to scatter
            sectors=False, # used in main
            scatter=True, # used in main
            jitter=False, # used in main

            density_scale=1, # used in main
            density_cbar=False, # used in main
            density_vmax=None, # not used in main but needs explicit passing
            title=None, # used in main

            size_scale=1,

            fname=None,
            **kwargs):
    """
    Plot a simplex plot from CerberusAnnotation triplets
    Parameters:
        density (bool): Plot density plot
        sectors (bool): Include lines that bound each sector
        scatter (bool): Plot scatter plot
        jitter (bool): Jitter scattered points
        density_scale (float): Number of triangles to plot per side
        density_cbar (bool): Include reference colorbar
        density_vmax (float): Value to serve as max. in density colorbar
        title (str): Title to display on plot
        size_scale (float): How large to make figure
        fname (str): File to save figure as
        **kwargs: Arguments to pass to TODO
    Returns:
        temp (pandas DataFrame): Points plotted in this plot
    """
    
    # figure size handling
    size_dict = {}

    # heights / widths
    size_dict['height'] = 10
    size_dict['width1'] = 13.6
    size_dict['width2'] = 17.2
    size_dict['width3'] = 10.716
    # size_dict['width3'] = 11.2


    # linewidths
    size_dict['linewidth'] = 3
    size_dict['linewidth2'] = 2

    # marker sizes
    size_dict['big_source_marker'] = 200
    size_dict['big_marker'] = 100
    size_dict['small_marker'] = 50
    size_dict['marker_max'] = 500
    size_dict['marker_min'] = 50

    # jitter
    size_dict['sigma'] = (1/250)*density_scale

    # ticks
    size_dict['tick_linewidth'] = 2

    # fontsizes
    size_dict['tick_size'] = 30
    size_dict['cbar_size'] = 16
    size_dict['title_size'] = 36.6
    size_dict['label_size'] = 36.6
    size_dict['cbar_tick_size'] = 16

    size_dict['title_pad'] = 50

    for key, item in size_dict.items():
        # area scale
        if 'marker' in key:
            size_dict[key] = item*size_scale*size_scale
        # linear scale
        else:
            size_dict[key] = item*size_scale


    # offsets don't need to be scaled
    size_dict['left_label_offset'] = 0.15
    size_dict['right_label_offset'] = 0.18
    size_dict['bottom_label_offset'] = 0.1
    size_dict['tick_offset'] = 0.025

    #### subset dataset and transform numbers as needed ####
    temp = df.copy(deep=True)

    # plot settings
    mpl.rcParams['font.family'] = 'Arial'
    mpl.rcParams['pdf.fonttype'] = 42


    # scale and assign which columns to use
    c = dict()
    c['a'] = left
    c['b'] = right
    c['c'] = bottom

    # density
    if density:
        if 'hue' in kwargs:
            hue = kwargs['hue']
            if temp[hue].dtype.name == 'object':
                pad = 0.1
            else:
                pad = 0.0
        else:
            pad = 0.1
        # pad = pad*size_scale
        figure, tax, temp = density_dorito(temp, c,
                                 size_dict,
                                 density_scale=density_scale,
                                 pad=pad,
                                 density_cbar=density_cbar,
                                 density_vmax=density_vmax,
                                 **kwargs)
        scale = density_scale
        if density_cbar:
            figure.set_size_inches(size_dict['width1'],size_dict['height'])
        else:
            figure.set_size_inches(size_dict['width3'], size_dict['height'])

    # if we're jittering, adjust the points for each thing
    if jitter:
        temp, c = jitter_dorito(temp, c, density_scale, size_dict)

    # figure layout parameters
    fontsize = 18
    offset = 0.1
    mult = 1/5

    # if we don't already have a fig and axis from density,
    # make one
    if not density:
        figure, tax = ternary.figure(scale=1, permutation='210')
        figure.set_facecolor('white')

    # plot gridlines below the scatterplot
    tax.gridlines(linewidth=size_dict['linewidth'],
            multiple=mult,
            color='white',
            zorder=1,
            linestyle=None)

    # scatter
    if scatter:
        figure, tax = scatter_dorito(temp, c,
                        figure, tax,
                        density_cbar,
                        size_dict,
                        **kwargs)

    # sectors
    if sectors:
        line_dorito(figure, tax, 1, size_dict, **kwargs)

    # title handler
    fdict = {}
    if not title:
        title = ''
    else:
        title = '{}'.format(title)

    tax.set_title(title, fontsize=size_dict['title_size'],
                  fontdict=fdict, pad=size_dict['title_pad'])
    tax.boundary(linewidth=size_dict['linewidth2'], c='#e5ecf6')
    labels = ['{:.1f}'.format(n) for n in np.arange(0, 1.2, .2)]
    tax.ticks(ticks=labels,
        axis='lbr', linewidth=size_dict['tick_linewidth'], multiple=mult,
        tick_formats="%.1f", offset=size_dict['tick_offset'],
        fontsize=size_dict['tick_size'])

    tax.clear_matplotlib_ticks()
    tax.get_axes().axis('off')
    tax.set_background_color('#e5ecf6')


    tax.left_axis_label(c['a'], fontsize=size_dict['label_size'],
                        offset=size_dict['left_label_offset'])
    tax.right_axis_label(c['b'], fontsize=size_dict['label_size'],
                         offset=size_dict['right_label_offset'])
    tax.bottom_axis_label(c['c'], fontsize=size_dict['label_size'],
                          offset=size_dict['bottom_label_offset'])

    figure.set_facecolor('white')

    # save figure
    if fname:
        tax.savefig(fname, dpi=500, bbox_inches='tight')

    return temp

def scatter_dorito(counts,
                 c,
                 figure,
                 tax,
                 density,
                 size_dict,
                 order_marker_sizes=True,
                 hue=None,
                 cmap='magma',
                 marker_style=None,
                 mmap=None,
                 size=None,
                 log_size=False,
                 alpha=1,
                 legend=True,
                 **kwargs):
    """
    Parameters
      counts (pandas DataFrame): Subset of self.triplets being plotted
      c (dict of str): Dictionary of column names to plot as a, b, c
          indexed by 'a', 'b', 'c'
      figure (matplotlib figure): Figure to plot on
      tax (matplotlib ternary axes): Axes to plot on
      density (bool): Plot density
      size_dict (dict of floats): Sizes for different plotted features
      order_marker_sizes (bool): Order markers based on their sizes such
        that the smallest markers are on top
        hue (str): Column in self.triplets to color each point by
        cmap (str): Colormap to use for hue
        marker_style (str): Column in self.triplets to use to plot different
            shapes of markers
        mmap (dict): Dictionary mapping marker styles to different column values
            in self.triplets[marker_style]
        size (str): Column in self.triplets to use to control size of markers
        log_size (bool): Log marker sizes
        alpha (float): Alpha value for plotted markers
        legend (bool): Include legend
        **kwargs
    Returns:
        figure :
        tax :
    """

    def scale_col(points, counts, col,
                  min_size=10,
                  max_size=300,
                  log=False,
                  how='color'):
        if log:
            log_col = '{}_log'.format(col)
            counts[log_col] = np.log10(counts[col])
            col = log_col
        vals = counts[[col]]
        max_val = vals[col].max()
        min_val = vals[col].min()
        min_max_scaler = preprocessing.MinMaxScaler(feature_range=(min_size, max_size))
        vals = min_max_scaler.fit_transform(vals)
        max_scaled = max(vals)
        min_scaled = min(vals)

        # replace nans w/ big marker size
        # vals = [size_dict['big_marker'] if np.isnan(v) else v for v in vals]
        vals = [size_dict['big_source_marker'] if np.isnan(v) else v for v in vals]

        return vals, min_val, max_val, min_scaled, max_scaled

    # defaults
    points = [(x[0], x[1], x[2]) for x in zip_pts(counts, c)]
    labels = ['' for i in range(len(points))]
    hue_type = None
    figsize = (size_dict['width3'],size_dict['height'])
    colors = '#e78424'
    if len(points) < 60:
        sizes = [size_dict['big_marker'] for i in range(len(points))]
    else:
        sizes =  [size_dict['small_marker'] for i in range(len(points))]
    markers = 'o'
    vmin = 0
    vmax = 1
    plotted = False

    # get color
    if hue:

        # categorical
        if counts[hue].dtype.name == 'object':
            hue_type = 'cat'
            colors = counts[hue].map(cmap).tolist()
            if marker_style:
                counts.loc[counts[hue].isnull(), hue] = counts.loc[counts[hue].isnull(), marker_style]
                labels = counts[hue].tolist()

        # continuous
        else:
            hue_type = 'cont'
            colors, abs_min, abs_max, vmin, vmax = scale_col(points, counts, hue,
                                                             min_size=size_dict['marker_min'],
                                                             max_size=size_dict['marker_max'])

    # get sizes
    if size:
        sizes,_,_,_,_ = scale_col(points, counts, size, log=log_size,
                                                         min_size=size_dict['marker_min'],
                                                         max_size=size_dict['marker_max'])

    # get marker styles
    if marker_style:
        markers = counts[marker_style].map(mmap).fillna('o').tolist()
    else:
        if hue_type == 'cat':
            markers = ['o' for i in range(len(counts.index))]
        else:
            markers = 'o'

    if hue_type == 'cat' and density: figsize = (size_dict['width1'], size_dict['height'])
    elif hue_type == 'cat' and not density: figsize = (size_dict['width3'], size_dict['height'])
    elif hue_type == 'cont' and density: figsize = (size_dict['width2'], size_dict['height'])
    elif hue_type == 'cont' and not density: figsize = (size_dict['width1'], size_dict['height'])
    elif density: figsize = (size_dict['width1'], size_dict['height'])
    figure.set_size_inches(figsize[0], figsize[1])

    def sort_points(points, colors, sizes, labels, markers):
        # https://stackoverflow.com/questions/6618515/sorting-list-based-on-values-from-another-list
        # attr = [points, colors, labels, markers]
        # for att in attr:
        def sort_attr(attr, sizes):
            attr = [a for (a,size) in sorted(zip(attr, sizes),
                    key=lambda pair: pair[1],
                    reverse=True)]
            return attr

        points = sort_attr(points, sizes)
        colors = sort_attr(colors, sizes)
        labels = sort_attr(labels, sizes)
        markers = sort_attr(markers, sizes)
        sizes = sort_attr(sizes, sizes)
        return points, colors, sizes, labels, markers

    # actual scatter call
    if hue_type == 'cat':

        # sort points based on their sizes so that smallest will be visible
        # on top of the bigger ones
        if order_marker_sizes:
            points, colors, sizes, labels, markers = sort_points(points,
                                                                 colors,
                                                                 sizes,
                                                                 labels,
                                                                 markers)

        for point, color, size, label, marker in zip(points, colors, sizes, labels, markers):
            tax.scatter([point], vmin=vmin, vmax=vmax,
                    s=size, c=color,
                    marker=marker,label=label,
                    alpha=alpha, zorder=3,
                    linewidths=0,
                    edgecolors=None)
    else:
        tax.scatter(points, vmin=vmin, vmax=vmax,
                    s=sizes, c=colors, cmap=cmap, marker=markers,
                    alpha=alpha, zorder=3,
                    linewidths=0,
                    edgecolors=None)

    # legend handling
    if hue_type == 'cat' and legend:

        if density: x = 1.6
        else: x = 1.4
        tax.legend(bbox_to_anchor=(x, 1.05),
                loc='upper right', prop={'size': 14})

        # fix marker size
        ax = tax.get_axes()
        lgnd = ax.get_legend()
        for handle in lgnd.legendHandles:
            handle._sizes = [size_dict['big_marker']]

    # colorbar handling
    if hue_type == 'cont':
        ax = tax.get_axes()
        norm = plt.Normalize(vmin=abs_min, vmax=abs_max)
        sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
        sm._A = []
        cb = plt.colorbar(sm, ax=ax, pad=0.1)
        for t in cb.ax.get_yticklabels():
             t.set_fontsize(size_dict['cbar_size'])
        if hue == 'tss' or hue == 'tes':
            cb.set_label('# {}s'.format(hue.upper()), size=16)
        elif hue == 'intron_chain':
            cb.set_label('# {}s'.format(hue), size=16)

    return figure, tax

def density_dorito(counts,
                c,
                size_dict,
                density_scale=20,
                density_cmap='viridis',
                density_vmax=None,
                log_density=False,
                pad=0.15,
                density_cbar=False,
                **kwargs):
    """
    Plot the density of a dataset on a ternary plot
    From here: https://github.com/marcharper/python-ternary/issues/81
    Parameters:
        counts
        c
        scale
        cmap
    Returns:
        fig
        tax
        counts (pandas DataFrame): Counts, scaled by factor used
    """
    hm_dict = defaultdict(int)
    log = log_density
    scale = density_scale
    cmap = density_cmap
    for i in range(0, scale+1):
        for j in range(0, scale+1):
            for k in range(0, scale+1):
                if i+j+k == scale:
                    temp = counts.copy(deep=True)
                    if i != scale:
                        temp = temp.loc[(temp.tss_ratio*scale>=i)&(temp.tss_ratio*scale<i+1)]
                    else:
                        temp = temp.loc[(temp.tss_ratio*scale>=i)&(temp.tss_ratio*scale<=i+1)]
                    if j != scale:
                        temp = temp.loc[(temp.spl_ratio*scale>=j)&(temp.spl_ratio*scale<j+1)]
                    else:
                        temp = temp.loc[(temp.spl_ratio*scale>=j)&(temp.spl_ratio*scale<=j+1)]
                    n = len(temp.index)
                    hm_dict[i,j] += n

    # log values if necessary
    if log:
        for key, item in hm_dict.items():
            hm_dict[key] = np.log2(item+1)
        if density_vmax:
            density_vmax = np.log2(density_vmax+1)

    # double checking stuff
    df = pd.DataFrame.from_dict(hm_dict, orient='index')
    df['i'] = [b[0] for b in df.index.tolist()]
    df['j'] = [b[1] for b in df.index.tolist()]
    df.rename({0:'val'}, axis=1, inplace=True)

    figure, tax = ternary.figure(scale=1, permutation='210')
    tax.heatmap(hm_dict, colorbar=False, style='t',
                adj_vlims=True, cmap=cmap, vmax=density_vmax)

    # scale according to chosen resolution
    for key in c.keys():
        counts[c[key]] = counts[c[key]]

    # colorbar - hacked together by broken ternary code
    if density_cbar:
        ax = tax.get_axes()
        flat = []
        for key, item in hm_dict.items():
            flat.append(item)
        min_val = min(flat)
        max_val = max(flat)

        if density_vmax:
            max_val = density_vmax

        print(min_val)
        print(max_val)
        norm = plt.Normalize(vmin=min_val, vmax=max_val)
        sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
        sm._A = []

        def exp_format(x,pos):
            x = int(x)
            return r'$2^{{{}}}$'.format(x)

        if not log:
            cb = plt.colorbar(sm, ax=ax, pad=pad)
        else:
            cb = plt.colorbar(sm, ax=ax, pad=pad,
                format=tck.FuncFormatter(exp_format))

        for t in cb.ax.get_yticklabels():
            t.set_fontsize(size_dict['cbar_tick_size'])
        if not log:
            cb.ax.set_yticklabels([])
            cb.ax.set_yticks([])

        cb.set_label('Density', size=size_dict['cbar_size'])

    return figure, tax, counts

def jitter_dorito(counts, c, scale, size_dict):
    """
        Parameters:
            counts
            c
            scale
        Returns
            counts
            c
    """

    # figure out how much to jitter by
    sigma = size_dict['sigma']
    for d in c.keys():
        d_jitter = '{}_jitter'.format(d)
        counts[d_jitter] = counts[c[d]].apply(lambda x: np.random.normal(x, sigma))
        c[d] = d_jitter

    return counts, c

def line_dorito(figure,
            tax,
            scale,
            size_dict,
            sect_alpha=0.5,
            sect_beta=0.5,
            sect_gamma=0.5,
            **kwargs):

    # scale
    alpha = sect_alpha*scale
    beta = sect_beta*scale
    gamma = sect_gamma*scale

    linewidth = size_dict['linewidth']

    # splicing line
    tax.horizontal_line(beta, linewidth=linewidth,
                     color='k',
                     linestyle='--')

    # tss
    tax.right_parallel_line(alpha, linewidth=linewidth,
                        color='k',
                        linestyle='--')

    # tes
    tax.left_parallel_line(gamma, linewidth=linewidth,
                        color='k',
                        linestyle='--')
def zip_pts(df, c):
    return zip(df[c['a']], df[c['b']], df[c['c']])

def max_pts(df, c):
    return max(df[c['a']].max(), df[c['b']].max(), df[c['c']].max())