# vibrio_plot_scatter.py

# ### Function imports

import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rcParams
import seaborn as sns
from sys import argv
import ast

# ### Specify what to plot
# 
# * Pairwise comparison (xvar, yvar)
# * List of genes to highlight (gene_list)
# * Highlight color (gene_color)
# * Labels on or off (gene_labels)

xaxis = argv[1] # 'Vnt' #
yaxis = argv[2] # 'Plk' #
xlabel = argv[3] # 'Vented cells (counts per million)' #
ylabel = argv[4] # 'Planktonic cells (counts per million)' # 
axis_limits = [1e-2, 1e6, 1e-2, 1e6]

pathway_csv = argv[5] # 'Phosphate,Flagellar' #

gene_dict = {
    'Phosphate': ['VF_A1087', 'VF_A1090', 'VF_1611', 'VF_A1057', 'VF_1610', 'VF_1613', 'VF_1612', 'VF_A1089'],
    'Flagellar': ['VF_1851', 'VF_2079', 'VF_1842', 'VF_2317', 'VF_1843', 'VF_1863', 'VF_1841'],
    'LipidPerox': ['VF_1081', 'VF_1082', 'VF_1083', 'VF_A1049', 'VF_A1050'],
    'LuxOperon': ['VF_A0918', 'VF_A0919', 'VF_A0920', 'VF_A0924', 'VF_A0921', 'VF_A0922', 'VF_A0923', 'VF_A0924'],
    'LuxIregulated': ['VF_A0985', 'VF_1161', 'VF_1162', 'VF_1725', 'VF_A0090', 'VF_A0622', 'VF_A1058'],
    'GGDEFdomain': ['VF_A0879', 'VF_A0343', 'VF_A0342', 'VF_A0476'],

    'TMAOreductase': ['VF_A0188', 'VF_A0189'],
    'FatCatabolism': ['VF_0533'],
    'AminoAcid': ['VF_1585', 'VF_1586', 'VF_A0840'],
    'PTSsugars': ['VF_A0747', 'VF_A1189', 'VF_A0941', 'VF_A0942'],
    'NonPTSsugars': ['VF_A0799']
    }

# colors from http://xkcd.com/color/rgb/
# pathway colors
color_csv = argv[6] # 'bright lavender,windows blue' #
# xy line colors
unity_color = sns.xkcd_rgb['grey']
xy_color_dict = {'Plk': sns.xkcd_rgb['medium blue'],
                 'Swt': sns.xkcd_rgb['light red'],
                 'Vnt': sns.xkcd_rgb['medium green']} 

gene_labels = argv[7] # False #
gene_labels = ast.literal_eval(gene_labels)

# ### Import data

path =  argv[8] # 'results_plk_swt_vnt.csv' #

df = pd.read_csv(path, index_col=0)


# ### Plot formatting

# Seaborn style and context
sns.set_context("talk")
sns.set_style("white")
sns.set_style("ticks", {"xtick.major.size": 8, "ytick.major.size": 8})
# Helvetica font with Latex -- commented out because log labels come out in serif font
# rcParams['font.family'] = 'sans-serif'
# rcParams['font.sans-serif'] = ['Helvetica', 'Arial']
# rcParams['text.usetex'] = True


# ### Scatter plot

# specify column names
xvar = xaxis + '_rpkm_mean'
yvar = yaxis + '_rpkm_mean'

# specify reference lines
x = [1e-2, 1e-1, 1e0, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6]
x_pos3 = [a * 8.0 for a in x]
x_pos2 = [a * 4.0 for a in x]
x_pos1 = [a * 2.0 for a in x]
x_neg3 = [a * 0.125 for a in x]
x_neg2 = [a * 0.250 for a in x]
x_neg1 = [a * 0.500 for a in x]

# reference lines for log2fc = -3, -2, -1, 0, 1, 2, 3
# (identified DEGs as p-value < 0.001 and log2FoldChange > 3.0)
fig = plt.figure()
plt.plot(x, x, zorder=0, color=unity_color)
plt.plot(x, x_pos3, zorder=0, color=xy_color_dict[yaxis], linewidth=1)
plt.plot(x, x_pos2, zorder=0, color=xy_color_dict[yaxis], linewidth=1)
plt.plot(x, x_pos1, zorder=0, color=xy_color_dict[yaxis], linewidth=1)
plt.plot(x, x_neg3, zorder=0, color=xy_color_dict[xaxis], linewidth=1)
plt.plot(x, x_neg2, zorder=0, color=xy_color_dict[xaxis], linewidth=1)
plt.plot(x, x_neg1, zorder=0, color=xy_color_dict[xaxis], linewidth=1)
plt.text(1e3, 3e5, 'Enriched in %s' % yaxis, fontsize=14, horizontalalignment='left', color=xy_color_dict[yaxis])
plt.text(5e5*0.125, 5e5, '8x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[yaxis], backgroundcolor='white')
plt.text(5e5*0.250, 5e5, '4x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[yaxis], backgroundcolor='white')
plt.text(5e5*0.500, 5e5, '2x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[yaxis], backgroundcolor='white')
plt.text(3e4, 1e3, 'Enriched in %s' % xaxis, fontsize=14, horizontalalignment='left', color=xy_color_dict[xaxis])
plt.text(5e5, 5e5*0.125, '8x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[xaxis], backgroundcolor='white')
plt.text(5e5, 5e5*0.250, '4x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[xaxis], backgroundcolor='white')
plt.text(5e5, 5e5*0.500, '2x', fontsize=14, horizontalalignment='center', verticalalignment='center', color=xy_color_dict[xaxis], backgroundcolor='white')

# main plot
plt.scatter(df[xvar], df[yvar], s=80, edgecolor='black', facecolor='none')
plt.xscale('log')
plt.yscale('log')
plt.xlabel(xlabel)
plt.ylabel(ylabel)
plt.axis(axis_limits)

# highlight genes
pathway_list = pathway_csv.split(',')
pathway_color = color_csv.split(',')
for i in range(len(pathway_list)):
    # get VF list from pathway
    gene_list = gene_dict[pathway_list[i]]
    # gene colors
    gene_color = sns.xkcd_rgb[pathway_color[i]]

    plt.scatter(df[xvar][gene_list], df[yvar][gene_list], s=80, edgecolor='black', facecolor=gene_color)
    if gene_labels:
        labels_string = 'labels'
        for gene in gene_list:
            plt.text(df[xvar][gene], df[yvar][gene], gene)
    else:
        labels_string = 'nolabels'
    
# save pdf
gene_set = '_'.join(pathway_list)
plt.savefig('%s_%s_%s_%s.pdf' % (xaxis, yaxis, gene_set, labels_string))





