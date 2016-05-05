% scatter_dbRDA.m -- MUST RUN ON R2013b (DELL) TO GET MARKERS TO LOOK OK

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

% COLORS BY STATION
colorA = cbSetOne9(1,:);
colorB = cbSetOne9(5,:);
colorC = cbSetOne9(6,:);
colorD = cbSetOne9(3,:);
colorE = cbSetOne9(2,:);
colorF = cbSetOne9(4,:);
colorG = cbSetOne9(8,:);
colorH = cbSetOne9(7,:);

% STATIONS
stationA = 1:3;
stationB = 4:9;
stationC = 10:15;
stationD = 16:21;
stationE = 22:27;
stationF = 28:33;
stationG = 34:39;
stationH = 40:45;

files = {
    'dbRDA2_taxaPresAbs'
    'dbRDA2_taxaRelAbund'
    'dbRDA2_genes'
    'dbRDA_pathwayCoverage'
    'dbRDA2_pathwayRelAbund'
    'dbRDA2_metabolites'
    'dbRDA_taxaRelAbund_pro'
    'dbRDA_genes_pro'
    'dbRDA_taxaRelAbund_sar'
    'dbRDA_genes_sar'
    'dbRDA2_clarkSpecies'
    'dbRDA2_clarkGenera'
    };

multiplier = 5; % 5 for last two, 10 for others

for i = 11:12 % 1:size(files,1)
    
    root = files{i};
    
    filename = [root, '_coordinates.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    sample    = data{1};
    coord1    = data{2};
    coord2    = data{3};
    coord3    = data{4};
    
    filename = [root, '_predictors.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    predictor  = data{1};
    pcoord1    = data{2};
    pcoord2    = data{3};
    pcoord3    = data{4};
    
    filename = [root, '_explained.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    axis  = data{1};
    fittedIndiv   = data{2};
    fittedCumul   = data{3};
    totalIndiv    = data{4};
    totalCumul    = data{5};
    
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
    
    % plot samples by station
    % plot(coord1(stationA),coord2(stationA),'ko','MarkerSize',6,'Color',colorA,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationB),coord2(stationB),'ko','MarkerSize',6,'Color',colorB,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationC),coord2(stationC),'ko','MarkerSize',6,'Color',colorC,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationD),coord2(stationD),'ko','MarkerSize',6,'Color',colorD,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationE),coord2(stationE),'ko','MarkerSize',6,'Color',colorE,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationF),coord2(stationF),'ko','MarkerSize',6,'Color',colorF,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationG),coord2(stationG),'ko','MarkerSize',6,'Color',colorG,'MarkerFaceColor','none','LineWidth',1.5);
    % plot(coord1(stationH),coord2(stationH),'ko','MarkerSize',6,'Color',colorH,'MarkerFaceColor','none','LineWidth',1.5);

    % plot predictors before points
    for j = 1:size(predictor,1)
        ph = plot([0 pcoord1(j)*multiplier], [0 pcoord2(j)*multiplier], '-r.', 'Color', cbSetOne9(9,:), 'Marker', 'none', 'LineWidth', 1);
        if (i == 1) || (i == 2)
            text(pcoord1(1)*10.3, pcoord2(1)*12, predictor(1), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 7);
            text(pcoord1(2)*20, pcoord2(2)*15, predictor(2), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 7);
            text(pcoord1(3)*40, pcoord2(3)*45, predictor(3), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 7);
        else
            if (pcoord2(j) < 0)
                text(pcoord1(j)*multiplier, pcoord2(j)*multiplier, predictor(j), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7);
            else
                text(pcoord1(j)*multiplier, pcoord2(j)*multiplier, predictor(j), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 7);
            end
        end
    end
    
    % add circle
    %t = linspace(0,2*pi);
    %ph = plot(cos(t)*10,sin(t)*10);
    
    % resize axes for special case (taxaPresAbs)
    if (i == 1)
        set(gca, 'XLim', [-30 30]);
    end
    % resize axes for special case (genes)
    if (i == 3)
        set(gca, 'XLim', [-22 15]);
        set(gca, 'YLim', [-11 8]);
    end
    
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %box off;
    %set(gca,'Visible','off');

    % label1 = ['dbRDA1 (', num2str(round(totalIndiv(1),1)), '%)'];
    % label2 = ['dbRDA2 (', num2str(round(totalIndiv(2),1)), '%)'];
    % xlabel(label1); % depth
    % ylabel(label2); % chlorophyll
    
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[.5 .5 2.1 2]);
    
    outfile = [root, '_small.eps'];
    saveas(gca,outfile,'epsc');
    
end

