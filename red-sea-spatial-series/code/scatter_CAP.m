% scatter_CAP.m -- MUST RUN ON R2013b (DELL) TO GET MARKERS TO LOOK OK

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

% COLORS BY DEPTH
addpath ~/Dropbox/MATLAB;
load_colormaps;
color10 = cbSetOne9(1,:);
color25 = cbSetOne9(5,:);
color50 = cbSetOne9(6,:);
color100 = cbSetOne9(3,:);
color200 = cbSetOne9(2,:);
color500 = cbSetOne9(4,:);
color258 = cbSetOne9(8,:);

% MARKERS BY DEPTH
marker10 = '^';
marker25 = 'v';
marker50 = 's';
marker100 = 'd';
marker200 = 'o';
marker500 = '+';
marker258 = 'x';

% DEPTH LAYERS
depth10  =     [1 4 10 16 22 28 34 40];
depth25  =     [2 5 11 17 23 29 35 41];
depth50  =     [  6    18 24 30 36 42];
depth50gaiw  = [3   12               ];
depth100 =     [  7    19 25 31 37 43];
depth100gaiw = [    13               ];
depth200 =     [  8 14 20 26 32 38 44];
depth258 =     [    15               ];
depth500 =     [  9    21 27 33 39 45];

files = {
    'CAP_taxaPresAbs'
    'CAP_taxaRelAbund'
    'CAP_genes'
    'CAP_pathwayCoverage'
    'CAP_pathwayRelAbund'
    'CAP_metabolites'
    'CAP_clarkSpecies'
    'CAP_clarkGenera'
    };

for i = 1:size(files,1)
    
    root = files{i};
    
    filename = [root, '_coordinates.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    sample    = data{1};
    coord1    = data{2} * -1; % reverse CAP1 to match dbRDA
    coord2    = data{3};
    coord3    = data{4};
    
    filename = [root, '_correlation.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    axis  = data{1};
    correlation   = data{2};
    corrsquared   = data{3};
    
    figure;
    hold on;
    
    % plot samples by depth
    ph1 = plot(coord1(depth10),coord2(depth10),'ko','Marker',marker10,'MarkerSize',6,'Color',color10,'MarkerFaceColor','none','LineWidth',1.5);
    ph2 = plot(coord1(depth25),coord2(depth25),'ko','Marker',marker25,'MarkerSize',6,'Color',color25,'MarkerFaceColor','none','LineWidth',1.5);
    ph3 = plot(coord1(depth50),coord2(depth50),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','none','LineWidth',1.5);
    ph4 = plot(coord1(depth50gaiw),coord2(depth50gaiw),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','k','LineWidth',1.5);
    ph5 = plot(coord1(depth100),coord2(depth100),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','none','LineWidth',1.5);
    ph6 = plot(coord1(depth100gaiw),coord2(depth100gaiw),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','k','LineWidth',1.5);
    ph7 = plot(coord1(depth200),coord2(depth200),'ko','Marker',marker200,'MarkerSize',6,'Color',color200,'MarkerFaceColor','none','LineWidth',1.5);
    ph8 = plot(coord1(depth258),coord2(depth258),'ko','Marker',marker258,'MarkerSize',6,'Color',color258,'MarkerFaceColor','none','LineWidth',1.5);
    ph9 = plot(coord1(depth500),coord2(depth500),'ko','Marker',marker500,'MarkerSize',6,'Color',color500,'MarkerFaceColor','none','LineWidth',1.5);
    
    % resize axes for special case (taxaPresAbs)
    if (i == 1)
        set(gca, 'YLim', [-0.3 0.3]);
        set(gca, 'YTick', [-0.3:0.1:0.3]);
    end
    
    label1 = ['CAP1 (', num2str(corrsquared(1)), ')'];
    label2 = ['CAP2 (', num2str(corrsquared(2)), ')'];
    xlabel(label1); % depth
    ylabel(label2); % chlorophyll
    
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[1 1 4.2 4]);
    
    outfile = [root, '.eps'];
    saveas(gca,outfile,'epsc');
    
end

