% plotHumannSmooth.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load_colormaps;
mycolormap = colorcube; % FYI parula does not require load_colormaps


% NOTE: Removing GAIW samples because they skew the trends significantly:
%     Sample  3   47m  Lines  5- 6 of 90
%     Sample 12   50m  Lines 23-24 of 90
%     Sample 13  100m  Lines 25-26 of 90

minusGAIW = [1:4 7:22 27:90];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environmental & original "humannAll" data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen('/Users/luke/krse2011/db/krse2011_v3_humann_KOrelAbund.csv');
nCols = 5794; % wc -l list.KOrelAbund.tsv
hformat = repmat('%s', [1 nCols]);
header = textscan(fid, hformat, 1, 'delimiter', ',');
format = repmat('%f', [1 nCols]);
data = textscan(fid, format, 'delimiter', ',');
fclose(fid);

station      = data{1}(minusGAIW);
latitude     = data{2}(minusGAIW);
longitude    = data{3}(minusGAIW);
xcoord       = data{4}(minusGAIW);
ycoord       = data{5}(minusGAIW);
depth        = data{6}(minusGAIW);
temperature  = data{7}(minusGAIW);
salinity     = data{8}(minusGAIW);
oxygen       = data{9}(minusGAIW);
chlorophyll  = data{10}(minusGAIW);
turbidity    = data{11}(minusGAIW);
nitrate      = data{12}(minusGAIW);
phosphate    = data{13}(minusGAIW);
silicate     = data{14}(minusGAIW);
read         = data{15}(minusGAIW);

% 1030	K00114
% 3975	K00123
% 5253	K00285
% 704	K00301
% 705	K00302
% 3669	K00303
% 3663	K00304
% 3664	K00305
% 4264	K00315
% 5788	K00366
% 5789	K00367
% 3977	K00437
% 3971	K00438
% 3203	K00532
% 5376	K00544
% 2753	K00577
% 2282	K00925
% 1853	K01077
% 2177	K01428
% 1402	K02000
% 1401	K02001
% 1404	K02002
% 4404	K02036
% 1729	K02040
% 5305	K02575
% 337	K02588
% 5077	K03320
% 5073	K03325
% 5613	K03839
% 4767	K04044
% 1535	K04078
% 3064	K06217
% 110	K07175
% 5763	K07636
% 5514	K07657
% 2232	K08688
% 4023	K08928
% 4024	K08929
% 2138	K10944
% 2137	K10946
% 2219	K11959
% 3324	K14028
% 638	K14029
% 1198	K14083


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Latitude

xstring = 'Latitude';
xvar = latitude;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (°N)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Longitude

xstring = 'Longitude';
xvar = longitude;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (°E)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Depth

xstring = 'Depth';
xvar = depth;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (m)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Temperature

xstring = 'Temperature';
xvar = temperature;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (°C)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Salinity
% 4264 5376 1402 1401 1404 2232 704 705 3669 3663 3664 5253 3975

figure;
hold on;
xstring = 'Salinity';
xvar = salinity;
j = 0;
for i = [4264 5376 1402 1401 1404 2232 704 705 3669 3663 3664 5253 3975]
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.5,'rloess');
    [xvar2,ind] = sort(xvar);
    plot(xvar2,yvar2(ind),'-ko','Marker','none','Color',mycolormap(j*5+1,:),'LineWidth',1.5);
    j = j+1;
    xunits = [xstring, ' (psu)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
end
axis([get(gca,'XLim') 0 2.5e-3]);
ylabel('KO relative abundance (rloess, 0.5)', 'Interpreter', 'none');
title('Salinity dependence of 13 osmolyte genes', 'Interpreter', 'none');
outfile = ['smooth.','osmolytes', '.vs.', xstring, '.eps'];
saveas(gca,outfile,'epsc');

figure;
hold on;
xstring = 'Salinity';
xvar = salinity;
j = 0;
for i = [4264 5376 1402 1401 1404 2232 704 705 3669 3663 3664 5253 3975]
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    %yvar2 = smooth(xvar,yvar,0.5,'rloess');
    [xvar2,ind] = sort(xvar);
    plot(xvar2,yvar(ind),'-ko','Marker','o','Color',mycolormap(j*5+1,:),'LineWidth',0.5);
    j = j+1;
    xunits = [xstring, ' (psu)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
end
ylabel('KO relative abundance', 'Interpreter', 'none');
title('Salinity dependence of 13 osmolyte genes', 'Interpreter', 'none');
outfile = ['points.','osmolytes', '.vs.', xstring, '.eps'];
saveas(gca,outfile,'epsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Oxygen

xstring = 'Oxygen';
xvar = oxygen;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (mL/L)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Chlorophyll

xstring = 'Chlorophyll';
xvar = chlorophyll;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (mg/m^3)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Turbidity

xstring = 'Turbidity';
xvar = turbidity;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (turbidity volts)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Nitrate

xstring = 'Nitrate';
xvar = nitrate;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole community (KOrelAbund) vs Phosphate

xstring = 'Phosphate';
xvar = phosphate;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ecotypes (KOrelAbund_ECO) vs Silicate

xstring = 'Silicate';
xvar = silicate;
for i = []
    ystring = header{i};
    yvar = data{i}(minusGAIW);
    yvar2 = smooth(xvar,yvar,0.1,'rloess');
    figure;
    hold on;
    plot(xvar,yvar2,'-ko','Marker','none','Color','k','LineWidth',0.5);
    xunits = [xstring, ' (µM)'];
    xlabel(xunits);
    ylabel(ystring{1}, 'Interpreter', 'none');
    titlestring = [ystring{1}, ' vs. ', xstring];
    title(titlestring, 'Interpreter', 'none');
    set(gca,'FontSize',10);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 6 4]);
    outfile = ['smooth.',ystring{1}, '.vs.', xstring, '.eps'];
    saveas(gca,outfile,'epsc');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tilefigs([]);


