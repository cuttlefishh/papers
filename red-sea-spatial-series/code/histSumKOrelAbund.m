% histSumKOrelAbund.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fid = fopen('KO_SumRead1.tsv');
data = textscan(fid,'%s %f %d %s','delimiter','\t','headerlines',1);
fclose(fid);

KO           = data{1};
relAbund     = data{2};
CPM          = data{3};
Description  = data{4};

figure;
edges = [0:5000:170000];
[n1, bin1] = hist(CPM,edges);
ph1 = bar(edges,n1,'FaceColor','none','EdgeColor','k','LineWidth',1);
px = xlabel('Total counts per million across 45 samples');
set(px,'FontSize',14);
py = ylabel('Number of KOs in bin');
set(py,'FontSize',14);
% set(gca,'YScale','log');
% pt = title('MIC (strength)');
% set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([-10000 180000 0 4000]);

saveas(ph1,'hist_SumRead1CPM_KOrelAbund','epsc');

figure;
edges = [0:5000:170000];
[n1, bin1] = hist(CPM,edges);
ph1 = bar(edges,n1,'FaceColor','none','EdgeColor','k','LineWidth',1);
px = xlabel('Total counts per million across 45 samples');
set(px,'FontSize',14);
py = ylabel('Number of KOs in bin');
set(py,'FontSize',14);
% set(gca,'YScale','log');
% pt = title('MIC (strength)');
% set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([-10000 180000 0 800]);

saveas(ph1,'hist_SumRead1CPM_KOrelAbund_zoom','epsc');

figure;
edges = [0:5000:170000];
[n1, bin1] = hist(CPM,edges);
ph1 = bar(edges,n1,'FaceColor','none','EdgeColor','k','LineWidth',1);
px = xlabel('Total counts per million across 45 samples');
set(px,'FontSize',14);
py = ylabel('Number of KOs in bin');
set(py,'FontSize',14);
% set(gca,'YScale','log');
% pt = title('MIC (strength)');
% set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([-10000 180000 0 200]);

saveas(ph1,'hist_SumRead1CPM_KOrelAbund_zoom2','epsc');
