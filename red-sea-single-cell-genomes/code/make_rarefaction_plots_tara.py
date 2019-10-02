#!/usr/bin/env python

import click
import numpy as np
import pandas as pd
import random
import math
import matplotlib.pyplot as plt 

# Function: Randomize columns order of pandas DataFrame
def randomize_df_column_order(df):
    cols = df.columns.tolist()
    np.random.shuffle(cols)
    df_copy = df[cols]
    return df_copy

# Function: Count cumulative true values in each row by column
def make_cumulative_frame(df):
    prev_count = pd.Series(data=0, index=df.index)
    cumulative_frame = pd.DataFrame(data=0, index=df.index, columns=df.columns)
    for sample in df.columns:
        cumulative_frame[sample] = prev_count + df[sample]
        prev_count = cumulative_frame[sample]
    return cumulative_frame

# Function: Find best (greatest) cumulative sum
def find_best_cumulative_frame(df):
    # initialize values
    prev_count = pd.Series(data=0, index=df.index)
    col_list = []
    dfb = pd.DataFrame(data=df.values, index=df.index, columns=df.columns)
    # go through selection for as many samples exist
    for sample in dfb.columns:
        # add prev_count to dfb
        dfc = dfb.add(prev_count.tolist(), axis=0)
        # find column with most values > 0
        dfd = dfc > 0
        num_gt_zero = dfd.sum()
        best = num_gt_zero.idxmax()
        best_value = num_gt_zero.max()
        # set best column as new prev_count and make it last column in new df
        prev_count = dfc[best]
        col_list.append(prev_count)
        # remove column from dfb
        dfb.pop(best)
    # make new df
    cumulative_frame = pd.concat(col_list, axis=1)
    return cumulative_frame

# Function: Find worst (least) cumulative sum
def find_worst_cumulative_frame(df):
    # initialize values
    prev_count = pd.Series(data=0, index=df.index)
    col_list = []
    dfb = pd.DataFrame(data=df.values, index=df.index, columns=df.columns)
    # go through selection for as many samples exist
    for sample in dfb.columns:
        # add prev_count to dfb
        dfc = dfb.add(prev_count.tolist(), axis=0)
        # find column with most values > 0
        dfd = dfc > 0
        num_gt_zero = dfd.sum()
        worst = num_gt_zero.idxmin()
        worst_value = num_gt_zero.min()
        # set best column as new prev_count and make it last column in new df
        prev_count = dfc[worst]
        col_list.append(prev_count)
        # remove column from dfb
        dfb.pop(worst)
    # make new df
    cumulative_frame = pd.concat(col_list, axis=1)
    return cumulative_frame

@click.command()
@click.option('--num_samples', required=True, type=click.INT, help='Number of samples, e.g. 139 for all prokaryotic samples')
@click.option('--species', required=True, type=click.STRING, help='species (pelag or proch) corresponding to cluster counts input files, e.g. pelag_004_SRF_0.22-1.6_1e-5')
@click.option('--evalue', required=True, type=click.STRING, help='e-value cutoff corresponding to cluster counts input files, e.g. pelag_004_SRF_0.22-1.6_1e-5')
@click.option('--clusters_set', required=True, type=click.STRING, help='Clusters set that is given by --clusters_path, e.g. RSonly or all')
@click.option('--clusters_path', required=True, type=click.Path(resolve_path=True, readable=True, exists=True), help='Clusters file to check for presence, e.g. ~/singlecell/clusters/orthomcl-sar4/groups.RSonly_sar.list')
@click.option('--permutations', required=True, type=int, help='Number of rarefaction curve permutations to draw')
@click.option('--plot_redsea', is_flag=True, help='Provide this flag if you want to superimpose rarafaction curve where Red Sea Tara samples are explored first')

# num_samples = 139
# species = 'proch'
# evalue = '1e-5'
# clusters_set = 'all'
# clusters_path = '~/singlecell/clusters/orthomcl-pro4/groups.all_pro.list'
# permutations = 100

# Main function
def rarefaction(num_samples, species, evalue, clusters_set, clusters_path, permutations, plot_redsea):

    """Make rarefaction curve for presence of gene clusters in Tara samples"""

    # Paths of input files, containing cluster counts
    paths = pd.Series.from_csv('~/singlecell/tara/paths_%s_%s.list' % (species, evalue), header=-1, sep='\t', index_col=None)

    # Data frame containing all samples cluster counts (NaN if missing)
    pieces = []
    for path in paths:
        fullpath = "~/singlecell/tara/PROK-139/%s" % path
        counts = pd.DataFrame.from_csv(fullpath, header=-1, sep='\t', index_col=0)
        pieces.append(counts)
    frame = pd.concat(pieces, axis=1)
    headings = paths.tolist()
    frame.columns = headings

    # Dataframe of clusters
    clusters = pd.Series.from_csv(clusters_path, header=-1, sep='\t', index_col=None)
    clusters_frame = frame.loc[clusters]

    # Check if counts are greater than zero (presence/absence)
    bool_frame = clusters_frame > 0

    # Plot best and worst curves
    cum_frame_best = find_best_cumulative_frame(bool_frame)
    cum_bool_best = cum_frame_best > 0
    cum_sum_best = cum_bool_best.sum()
    num_samples_plus_one = num_samples + 1
    plt.plot(range(1, num_samples_plus_one), cum_sum_best, color='b', label='Best-case scenario')
    cum_frame_worst = find_worst_cumulative_frame(bool_frame)
    cum_bool_worst = cum_frame_worst > 0
    cum_sum_worst = cum_bool_worst.sum()
    plt.plot(range(1, num_samples_plus_one), cum_sum_worst, color='b', label='Worst-case scenario')
    plt.fill_between(range(1, num_samples_plus_one), cum_sum_best, cum_sum_worst, facecolor='blue', alpha=0.3, label=None)

    # Save list of clusters not found
    final_result = cum_bool_best.iloc[0:,-1:]
    genes_not_found = final_result.loc[final_result.all(axis=1) == False].index.values
    np.savetxt('missing_%s_%s_%s.txt' % (species, clusters_set, evalue), genes_not_found, fmt="%s", delimiter=',')

    # Plot rarefaction curve of avg +/- std of N random sample orders
    cum_list = []
    for i in range(0, permutations):
        # Randomize sample columns (rarefaction step)
        bool_frame_copy = randomize_df_column_order(bool_frame)
        # Replace column names with sequential numbers (prevents inconsistent plotting)
        bool_frame_copy.columns = range(0, len(bool_frame_copy.columns))
        # Go thru randomized columns and count cumulative times clusters found
        cumulative_frame = make_cumulative_frame(bool_frame_copy)
        # Check if cumulative count is greater than zero (presence/absence)
        cumulative_bool = cumulative_frame > 0
        # Sum cumulative count
        cumulative_sum = cumulative_bool.sum()
        # Add cumulutive sum to list
        cum_list.append(cumulative_sum)
    # Make new df
    cum_frame = pd.concat(cum_list, axis=1)
    # Calc avg and std of df
    cum_mean = cum_frame.mean(axis=1)
    cum_std = cum_frame.std(axis=1)
    # Plot
    plt.plot(range(1, num_samples_plus_one), cum_mean, color='yellow', linestyle='--', label='Mean of cumulative gene counts')
    plt.plot(range(1, num_samples_plus_one), cum_mean + cum_std, color='yellow', label='     plus standard deviation')
    plt.plot(range(1, num_samples_plus_one), cum_mean - cum_std, color='yellow', label='     minus standard deviation')
    plt.fill_between(range(1, num_samples_plus_one), cum_mean + cum_std, cum_mean - cum_std, facecolor='yellow', alpha=0.5)

    # Plot rarefaction curve for RS samples
    if plot_redsea:
        redsea = ['031_SRF_0.22-1.6', '032_SRF_0.22-1.6', '032_DCM_0.22-1.6', '033_SRF_0.22-1.6', '034_SRF_0.22-1.6', '034_DCM_0.22-1.6']
        redsea = [species + '_' + s + '_' + evalue for s in redsea]
        cum_list = []
        for i in range(0, permutations):
            last_six_columns = []
            last_six_columns.append([str(w) for w in random.sample(redsea, len(redsea))])
            #last_six_columns = random.shuffle(redsea) <== doesn't work
            bool_frame_copy = randomize_df_column_order(bool_frame)
            old_columns = bool_frame_copy.columns
            nonrs_columns = old_columns.drop(last_six_columns[0])
            new_columns = nonrs_columns.tolist() + last_six_columns[0]
            new_frame = pd.DataFrame(data=bool_frame_copy, columns=new_columns)
            # Replace column names with sequential numbers (prevents inconsistent plotting)
            new_frame.columns = range(0, len(new_frame.columns))
            # Go thru randomized columns and count cumulative times clusters found
            cumulative_frame = make_cumulative_frame(new_frame)
            # Check if cumulative count is greater than zero (presence/absence)
            cumulative_bool = cumulative_frame > 0
            # Sum cumulative count
            cumulative_sum = cumulative_bool.sum()
            # Add cumulutive sum to list
            cum_list.append(cumulative_sum)
        # If we want to know how many clusters are added by last six samples...
        # print cum_list
        # Make new df
        cum_frame = pd.concat(cum_list, axis=1)
        # Calc avg and std of df
        cum_mean = cum_frame.mean(axis=1)
        cum_std = cum_frame.std(axis=1)
        # Plot
        plt.plot(range(1, num_samples_plus_one), cum_mean, color='red', linestyle='-', label='Mean, 6 Red Sea samples last')
        #plt.plot(range(1, num_samples_plus_one), cum_mean + cum_std, color='red', label='     plus standard deviation')
        #plt.plot(range(1, num_samples_plus_one), cum_mean - cum_std, color='red', label='     minus standard deviation')
        #plt.fill_between(range(1, num_samples_plus_one), cum_mean + cum_std, cum_mean - cum_std, facecolor='red', alpha=0.5)
        plt.annotate('Red Sea samples added', xy=(num_samples-6, cum_mean[num_samples-6]), xytext=(num_samples-20, cum_mean[num_samples-1]*1.05), horizontalalignment='right', arrowprops=dict(arrowstyle="->", connectionstyle="angle,angleA=0,angleB=90,rad=10"))

    # Plot number of clusters as horizontal line
    num_genes = len(clusters)
    plt.axhline(y=num_genes, color='k', linestyle='--', label='Total clusters (%s)' % num_genes)
    #plt.text(22, num_genes*0.95, 'Number %s clusters (%s)' % (clusters_set, num_genes))
    found_genes = cumulative_sum.max()
    #plt.text(22, found_genes*1.05, 'Found %s clusters (%s)' % (clusters_set, found_genes))
    plt.annotate('', xy=(num_samples, found_genes), xytext=(num_samples, num_genes), arrowprops={'arrowstyle': '<->'})
    diff_genes = num_genes - found_genes
    plt.text(5, (num_genes+found_genes)/2, 'Clusters found: %s' % (found_genes))
    plt.text(num_samples-3, (num_genes+found_genes)/2, 'Not found: %s' % (diff_genes), horizontalalignment='right')

    # Add the legend with some customizations
    legend = plt.legend(loc='lower right', shadow=True)
    # The frame is matplotlib.patches.Rectangle instance surrounding the legend.
    frame = legend.get_frame()
    frame.set_facecolor('0.90')
    # Set label fontsize
    for label in legend.get_texts():
        label.set_fontsize('medium')
    for label in legend.get_lines():
        label.set_linewidth(1.5)  # the legend line width

    # Format and save plot
    plt.xlabel('Number of Tara samples added')
    plt.ylabel('Number of %s clusters found (e-value: %s)' % (clusters_set, evalue))
    plt.title('Rarefaction curve: %s (e-value: %s)' % (species, evalue))
    #plt.grid(TRUE)
    ymax = num_genes - (num_genes % 100) + 100
    plt.axis([0, num_samples+10, 0, ymax])
    # if species == 'proch':
    #     plt.axis([0, num_samples+10, -20, ymax])
    #     plt.axhline(y=0, color='k')
    plt.savefig('cum_%s_%s_%s.pdf' % (species, clusters_set, evalue))

    # Save best and worst cumulative sum lists to csv
    cum_sum_best.to_csv('cum_sum_best_%s_%s_%s.csv' % (species, clusters_set, evalue))    
    cum_sum_worst.to_csv('cum_sum_worst_%s_%s_%s.csv' % (species, clusters_set, evalue))    

if __name__ == '__main__':
    rarefaction()
