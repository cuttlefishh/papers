% aicc_stacked_bargraph.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load_colormaps;

% GENERAL

cb5classPastel1(6,:) = [1 1 1];
colormap(cb5classPastel1);

filename = 'aicc_for_bargraph.csv';
fid = fopen(filename);
data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', ',', 'Headerlines', 1);
fclose(fid);
envir   = data{1};
taxa    = data{2}; % clark genus
gene    = data{3}; % humann ko rel abund
pway    = data{4}; % humann kegg pathway rel abund
prmt    = data{5}; % prmt score

m = [taxa'; gene'; pway'; prmt'];

ph = bar(m,'stacked');

set(gca,'XTickLabel',{''});
ylabel('Variation explained (%)');

lh = legend(envir, 'Location', 'NorthWest');
legend boxoff;

set(gca, 'FontSize', 20);
set(lh, 'FontSize', 24);
axis([0.5 6.5 0 100]);

set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperPosition',[1 1 20 5]);
    
saveas(gca,'bargraph_aicc','epsc');

% PRO AND SAR11

% colormap(cb7classPastel1);
% 
% filename = 'aicc_for_bargraph_prosar.csv';
% fid = fopen(filename);
% data = textscan(fid, ['%s' repmat('%f', 1, 6)], 'Delimiter', ',', 'Headerlines', 1);
% fclose(fid);
% envir_prosar = data{1};
% taxa_pro     = data{2};
% gene_pro     = data{3};
% taxa_sar     = data{4};
% gene_sar     = data{5};
% 
% m = [taxa_pro'; gene_pro'; taxa_sar'; gene_sar'];
% 
% ph = bar(m,'stacked');
% 
% set(gca,'XTickLabel',{''});
% ylabel('Variation explained (%)');
% 
% lh = legend(envir_prosar, 'Location', 'NorthEast');
% legend boxoff;
% 
% set(gca, 'FontSize', 20);
% set(lh, 'FontSize', 24);
% axis([0.5 6.5 0 100]);
% 
% set(gcf,'PaperPositionMode','manual');
% set(gcf,'PaperUnits','inches');
% set(gcf,'PaperPosition',[1 1 20 5]);
%     
% saveas(gca,'bargraph_aicc_prosar','epsc');

