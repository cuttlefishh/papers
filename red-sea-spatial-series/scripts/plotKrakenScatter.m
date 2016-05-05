% plotHumannScatter.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = colormap(jet);
color500 = x(1,:);
color200 = x(14,:);
color100 = x(27,:);
color50  = x(40,:);
color25  = x(50,:);
color10  = x(64,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Depth layers (have to convert from 90 to 45)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

depth10  = unique(ceil([1 2  7  8 19 20       31 32 43 44 55 56 67 68 79 80]/2));
depth25  = unique(ceil([3 4  9 10 21 22       33 34 45 46 57 58 69 70 81 82]/2));
depth50  = unique(ceil([5 6 11 12 23 24       35 36 47 48 59 60 71 72 83 84]/2));
depth100 = unique(ceil([    13 14 25 26       37 38 49 50 61 62 73 74 85 86]/2));
depth200 = unique(ceil([    15 16 27 28 29 30 39 40 51 52 63 64 75 76 87 88]/2));
depth500 = unique(ceil([    17 18             41 42 53 54 65 66 77 78 89 90]/2));

% legend({'10 meters'; '25 meters'; '50 meters'; '100 meters'; '200 meters'; '500 meters'}, 'Location', 'Southeast');
% legend('boxoff');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environmental & kraken_genera data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KOs are listed here: ~/krse2011/db/list.KOrelAbund.tsv

fid = fopen('/Users/luke/krse2011/db/krse2011_v3_kraken_genera_short.csv');
nCols = 833; % wc -l ~/krse2011/db/list.kraken_genera 
% or head -n 1 krse2011_v3_kraken_genera.csv | perl -alne '@F = split /,/; $n=@F; print $n'
hformat = repmat('%s', [1 nCols]);
header = textscan(fid, hformat, 1, 'delimiter', ',');
format = repmat('%f', [1 nCols]);
data = textscan(fid, format, 'delimiter', ',');
fclose(fid);

station      = data{1};
latitude     = data{2};
longitude    = data{3};
xcoord       = data{4};
ycoord       = data{5};
depth        = data{6};
temperature  = data{7};
salinity     = data{8};
oxygen       = data{9};
chlorophyll  = data{10};
turbidity    = data{11};
nitrate      = data{12};
phosphate    = data{13};
silicate     = data{14};

NPratio = zeros(45);
for j = 1:45
    NPratio(j) = nitrate(j)/phosphate(j);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bugs of interest in list.kraken_genera

% 15 d__Bacteria|p__Proteobacteria|c__Alphaproteobacteria|g__Pelagibacter
% 16 d__Viruses|o__Caudovirales|f__Myoviridae|g__Pelagibacter_Myoviridae
% 17 d__Viruses|o__Caudovirales|f__Podoviridae|g__Pelagibacter_Podoviridae
% 18 d__Viruses|o__Caudovirales|f__Myoviridae|g__Prochlorococcus_Myoviridae
% 19 d__Viruses|o__Caudovirales|f__Podoviridae|g__Prochlorococcus_Podoviridae
% 20 d__Viruses|o__Caudovirales|f__Siphoviridae|g__Prochlorococcus_Siphoviridae
% 21 d__Viruses|o__Caudovirales|f__Myoviridae|g__Synechococcus_Myoviridae
% 22 d__Viruses|o__Caudovirales|f__Podoviridae|g__Synechococcus_Podoviridae
% 23 d__Viruses|o__Caudovirales|f__Siphoviridae|g__Synechococcus_Siphoviridae
% 281 d__Bacteria|p__Cyanobacteria|o__Chroococcales|g__Synechococcus
% 282 d__Bacteria|p__Cyanobacteria|o__Chroococcales|g__Synechocystis
% 297 d__Bacteria|p__Cyanobacteria|o__Oscillatoriales|g__Trichodesmium
% 301 d__Bacteria|p__Cyanobacteria|o__Prochlorales|f__Prochlorococcaceae|g__Prochlorococcus


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Latitude

xstring = 'Latitude';
xvar = latitude;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (°N)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Longitude

xstring = 'Longitude';
xvar = longitude;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (°E)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Depth
% Luke: 15 281 301

xstring = 'Depth';
xvar = depth;
for i = [15 281 301]
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (m)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Temperature
% Luke: 1538 1535 921
% Francy: 638 1030 3324

xstring = 'Temperature';
xvar = temperature;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (°C)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Salinity
% Luke: 4264 5376 1402 1401 1404 2232 704 705 3669 3663 3664 5253 3975
% Jenan (sqhC/K06045): 2507

xstring = 'Salinity';
xvar = salinity;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (psu)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Oxygen
% Steffi: 1198 2282 2753 3203 3971 3977
% Zhenfeng: 4023 4024
% Jenan (sqhC/K06045): 2507

xstring = 'Oxygen';
xvar = oxygen;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (mL/L)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Chlorophyll

xstring = 'Chlorophyll';
xvar = chlorophyll;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (mg/m^3)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Turbidity
% Steffi: 1198 2282 2753 3203 3971 3977

xstring = 'Turbidity';
xvar = turbidity;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (turbidity volts)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Nitrate
% Paul: 2219 3067 5077 5305 5788 5789
% Nathan: 2177

xstring = 'Nitrate';
xvar = nitrate;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Phosphate
% Luke: 110 1729 1853 3064 4404 5073 5514 5763
% Luke (neg control): 1538 1535
% Ulrike: 337 5613

xstring = 'Phosphate';
xvar = phosphate;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs N:P ratio
% Luke (P): 110 1729 1853 3064 4404 5073 5514 5763
% Luke (neg control): 1538 1535
% Paul (N): 2219 3067 5077 5305 5788 5789
% Nathan (N): 2177
% Ulrike (P): 337 5613

xvar = NPratio;
for i = [];
    xstring = 'N:P ratio';
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ''];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    xstring = 'NPratio';
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genera vs Silicate

xstring = 'Silicate';
xvar = silicate;
for i = []
    ystring = header{i};
    yvar = data{i};
    figure;
    hold on;
    plot(xvar(depth10),yvar(depth10),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
    plot(xvar(depth25),yvar(depth25),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
    plot(xvar(depth50),yvar(depth50),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
    plot(xvar(depth100),yvar(depth100),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
    plot(xvar(depth200),yvar(depth200),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
    plot(xvar(depth500),yvar(depth500),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = [ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end


