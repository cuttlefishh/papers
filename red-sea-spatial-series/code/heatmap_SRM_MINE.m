% heatmap_mine.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows
close all hidden;  % yes, close heatmaps too

import bioma.data.*  % bioinformatics toolbox

load_colormaps;      % yellowbluecmap from ~/Dropbox/MATLAB/load_colormaps.m

filenames = {
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b0_signif.tsv'
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b1depth_signif.tsv'
    %'/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b2temp_signif.tsv'
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b3salinity_signif.tsv'
    %'/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b4oxygen_signif.tsv'
    %'/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b5fluor_signif.tsv'
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b6turbidity_signif.tsv'
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b7nitrate_signif.tsv'
    '/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b8phosphate_signif.tsv'
    %'/Users/luke/krse2011/results/june30_pathwayRelAbund_p05_sort_b9silicate_signif.tsv'
    };

for i = 1:6
    
    fid = fopen(filenames{i});
    data = textscan(fid,'%s %f %s','delimiter','\t','headerlines',1);
    fclose(fid);
    
    koNo      = data{1};
    beta      = data{2};
    koDescr   = data{3};
    
    thesize = size(koNo,1);
    
    betaNames = {''};
    pathways = koDescr;
    
    % UNCOMMENT TO GRAY-OUT INSIGNIFICANT TIMEPOINTS
    % for i = 1:size(genesCtr,1)
    %     for j = 1:size(timesDkLt,1)
    %         if probDkLt(i,j) < 0.95
    %             log2fcDkLt(i,j) = NaN;
    %         end
    %     end
    % end
    
    % NOTE HEATMAP IS A CLUSTERGRAM OBJECT
    
    dmo1 = DataMatrix(beta, pathways, betaNames);
    dmo1 = set(dmo1, 'Name', 'pathwayRelAbund');
    hmo1 = HeatMap(dmo1, 'Colormap', yellowcyancmap);
    plot(hmo1);
    set(hmo1,'ColumnLabelsLocation','top');
    set(hmo1,'ColumnLabelsRotate',45);
    set(hmo1,'RowLabelsLocation','right');
    
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [2 1 10 thesize/10+2]);
    
    outfile = ['heatmapSRM',num2str(i),'.eps'];
    saveas(gca,outfile,'epsc');
    
end
