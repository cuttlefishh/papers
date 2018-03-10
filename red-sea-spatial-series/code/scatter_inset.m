% scatter_CAP_genes.m -- MUST RUN ON R2013b (DELL) TO GET MARKERS TO LOOK OK

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

% COLORS BY DEPTH
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

% SAMPLE COORDINATES
root = 'CAP_coordinates_genes';
filename = [root, '.tsv'];
fid = fopen(filename);
data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
fclose(fid);
sample    = data{1};
coord1    = data{2};
coord2    = data{3};
coord3    = data{4};

% ITERATE OVER DIFFERENT LISTS OF GENE LOADINGS
files = {
    'CAP_loadings_genes_goi'
    'CAP_loadings_genes_sort_CAP1'
    'CAP_loadings_genes_sort_CAP2'
    };

for j = 1:size(files,1)
    
    root = files{j};
    filename = [root, '.tsv'];
    fid = fopen(filename);   % 100 on next line will only scan first 100 lines
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 100, 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    gene     = data{1};
    load1    = data{2};
    load2    = data{3};
    
    figure;
    hold on;
    
    % PLOT SAMPLES (SCALE BY 2 USING 2*coord...)
    ph1 = plot(coord2(depth10),coord1(depth10),'ko','Marker',marker10,'MarkerSize',6,'Color',color10,'MarkerFaceColor','none','LineWidth',1.5);
    ph2 = plot(coord2(depth25),coord1(depth25),'ko','Marker',marker25,'MarkerSize',6,'Color',color25,'MarkerFaceColor','none','LineWidth',1.5);
    ph3 = plot(coord2(depth50),coord1(depth50),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','none','LineWidth',1.5);
    ph4 = plot(coord2(depth50gaiw),coord1(depth50gaiw),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','k','LineWidth',1.5);
    ph5 = plot(coord2(depth100),coord1(depth100),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','none','LineWidth',1.5);
    ph6 = plot(coord2(depth100gaiw),coord1(depth100gaiw),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','k','LineWidth',1.5);
    ph7 = plot(coord2(depth200),coord1(depth200),'ko','Marker',marker200,'MarkerSize',6,'Color',color200,'MarkerFaceColor','none','LineWidth',1.5);
    ph8 = plot(coord2(depth258),coord1(depth258),'ko','Marker',marker258,'MarkerSize',6,'Color',color258,'MarkerFaceColor','none','LineWidth',1.5);
    ph9 = plot(coord2(depth500),coord1(depth500),'ko','Marker',marker500,'MarkerSize',6,'Color',color500,'MarkerFaceColor','none','LineWidth',1.5);
    
    for i = 1:size(gene,1)
        phB = plot([0 load2(i)], [0 load1(i)], '-b.');
    end
    for i = 1:size(gene,1)
        text(load2(i)*1.15, load1(i)*1.07, gene(i), 'HorizontalAlignment', 'center', 'FontSize', 8);
    end
    
    uistack(ph1,'top');
    uistack(ph2,'top');
    uistack(ph3,'top');
    uistack(ph4,'top');
    uistack(ph5,'top');
    uistack(ph6,'top');
    uistack(ph7,'top');
    uistack(ph8,'top');
    uistack(ph9,'top');
    
    % NOTE I AM REVERSING BOTH AXES!
    set(gca,'Xdir','reverse');
    set(gca,'Ydir','reverse');
    set(gca, 'XTickLabel', {'1.0'; '0.8'; '0.6'; '0.4'; '0.2'; '0'; '-0.2'; '-0.4'; '-0.6'; '-0.8'; '-1.0'});
    set(gca, 'YTickLabel', {'1.0'; '0.8'; '0.6'; '0.4'; '0.2'; '0'; '-0.2'; '-0.4'; '-0.6'; '-0.8'; '-1.0'});
    
    xlabel('low/no chlorophyll   <<<   CAP2 [0.85]   >>>   high chlorophyll');
    ylabel('deep/mesopelagic   <<<   CAP1 [0.93]   >>>   shallow/epipelagic');
    % set(gca,'XTick',[]);
    % set(gca,'YTick',[]);
    axis([-1 1 -1 1]);
    %title('Vector loadings of genes hypothesized to covary with environmental predictors', 'Interpreter', 'none');
    lh = legend([ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9], {'10 m'; '25 m'; '50 m'; '50 m/GAIW'; '100 m'; '100 m/GAIW'; '200 m'; '258 m'; '500 m'}, 'Location', 'SouthWest');
    set(lh,'LineWidth',0.1);
    % legend('boxoff');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6.5 8]);
    
    % INSET INDICATOR BOX
    rectangle('Position',[-0.42 -0.22 0.73 0.50], 'LineStyle',':')
    
    % INSET: PLOT-IN-PLOT
    axes('Position',[.12 .6 .24 .2]);
    box off;
    set(gca,'Visible','off')
    rectangle('Position',[-0.45 -0.22 0.8 0.5],'LineStyle','-')
    
    hold on;
    
    % PLOT INSET (NOT SCALED BY 2)
    ph11 = plot(coord2(depth10),coord1(depth10),'ko','Marker',marker10,'MarkerSize',6,'Color',color10,'MarkerFaceColor','none','LineWidth',1.5);
    ph12 = plot(coord2(depth25),coord1(depth25),'ko','Marker',marker25,'MarkerSize',6,'Color',color25,'MarkerFaceColor','none','LineWidth',1.5);
    ph13 = plot(coord2(depth50),coord1(depth50),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','none','LineWidth',1.5);
    ph14 = plot(coord2(depth50gaiw),coord1(depth50gaiw),'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','k','LineWidth',1.5);
    ph15 = plot(coord2(depth100),coord1(depth100),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','none','LineWidth',1.5);
    ph16 = plot(coord2(depth100gaiw),coord1(depth100gaiw),'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','k','LineWidth',1.5);
    ph17 = plot(coord2(depth200),coord1(depth200),'ko','Marker',marker200,'MarkerSize',6,'Color',color200,'MarkerFaceColor','none','LineWidth',1.5);
    ph18 = plot(coord2(depth258),coord1(depth258),'ko','Marker',marker258,'MarkerSize',6,'Color',color258,'MarkerFaceColor','none','LineWidth',1.5);
    ph19 = plot(coord2(depth500),coord1(depth500),'ko','Marker',marker500,'MarkerSize',6,'Color',color500,'MarkerFaceColor','none','LineWidth',1.5);
    
    set(gca,'Xdir','reverse');
    set(gca,'Ydir','reverse');
    
    outfile = [root, '.eps'];
    saveas(gca,outfile,'epsc');
    
end

