% scatter_CCA_annotated.m -- MUST RUN ON R2013b (DELL) TO GET MARKERS TO LOOK OK

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

% SCALE CCA VALUES
scale_samples = 1.5;
scale_predictors = 5.2;
scale_loadings = 1;

% INPUT FILE INFO:
% - DIRECTORY (from s2*.sh, s3*.sh)
% - PATHWAY-SPECIFIC CCA GENE LOADINGS (from s6*.sh, s7*.sh, s8*.sh, s9*.sh)
% - RESPONSE VARIABLE

dir = 'cca-by-pathway-filt3-goi';

files = {
'Oxidative_phosphorylation'
'ABC_transporters'
'Pyrimidine_metabolism'
'Carbon_fixation_pathways_in_prokaryotes'
'Glycine_serine_and_threonine_metabolism'
'Ribosome'
'Porphyrin_and_chlorophyll_metabolism'
'Amino_Acid_Metabolism'
'Carbohydrate_Metabolism'
'Energy_Metabolism'
'Metabolism_of_Cofactors_and_Vitamins'
'Metabolism_of_Terpenoids_and_Polyketides'
'Folding_Sorting_and_Degradation'
'Translation'
'Other'
};

% COLORS BY DEPTH
addpath ~/Dropbox/MATLAB;
load_colormaps;
color10 = 'k'; %cbSetOne9(1,:);
color25 = 'k'; %cbSetOne9(5,:);
color50 = 'k'; %cbSetOne9(6,:);
color100 = 'k'; %cbSetOne9(3,:);
color200 = 'k'; %cbSetOne9(2,:);
color500 = 'k'; %cbSetOne9(4,:);
color258 = 'k'; %cbSetOne9(8,:);

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

% COLORBREWER BY PATHWAY
ltgray = [0.9 0.9 0.9];
mdgray = [0.6 0.6 0.6];
dkgray = [0.3 0.3 0.3];
cb = [cb12classPaired(2,:); cb12classPaired(1,:); cb12classPaired(4,:); cb12classPaired(3,:); cb12classPaired(6,:); cb12classPaired(5,:); cb12classPaired(8,:); cb12classPaired(7,:); cb12classPaired(10,:); cb12classPaired(9,:); cb12classPaired(12,:); cb12classPaired(11,:); dkgray; mdgray; ltgray; cbSetOne9; cb8classPastel1];


% OPEN FILES

filename = 'CCA_genes_filt3_samples.tsv';
fid = fopen(filename);
data = textscan(fid, ['%s' repmat('%f', 1, 9)], 'Delimiter', '\t', 'Headerlines', 1);
fclose(fid);
sample    = data{1};
coord1    = data{2};
coord2    = data{3};
coord3    = data{4};

filename = 'CCA_genes_filt3_predictors.tsv';
fid = fopen(filename);
data = textscan(fid, ['%s' repmat('%f', 1, 9)], 'Delimiter', '\t', 'Headerlines', 1);
fclose(fid);
predictor  = data{1};
pcoord1    = data{2};
pcoord2    = data{3};
pcoord3    = data{4};

filename = 'CCA_genes_filt3_loadings.tsv';
fid = fopen(filename);
data = textscan(fid, ['%s' repmat('%f', 1, 9)], 'Delimiter', '\t', 'Headerlines', 1);
fclose(fid);
geneAll     = data{1};
loadAll1    = data{2};
loadAll2    = data{3};
loadAll3    = data{4};

figure;
hold on;


% PLOT GENE LOADINGS: ALL
% phA = plot(loadAll1*scale_loadings, loadAll2*scale_loadings, 'ko', 'MarkerEdgeColor', gray, 'MarkerFaceColor', 'none', 'MarkerSize', 4);

% LABELS
% for i = 1:size(geneMy,1)
%     text(loadAll1(i)*scale_loadings, loadAll2(i)*scale_loadings, geneAll(i), 'HorizontalAlignment', 'center', 'FontSize', 8);
% end

% ARROWS
% for i = 1:size(geneAll,1)
%     phA = plot([loadAll1(i)*scale_loadings loadAll1(i)*scale_loadings*3], [loadAll2(i)*scale_loadings loadAll2(i)*scale_loadings*3], '-m.', 'Marker', 'none');
% end


% PLOT GENE LOADINGS BY PATHWAY
num_genes = 0;
handle_num = zeros(size(files,1),1);
for i = 1:size(files,1)
    
    filename = [dir, '/cca_genes_loadings_', files{i}, '.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 9)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    geneMy     = data{1};
    num_genes = num_genes + size(geneMy,1);
    handle_num(i) = num_genes;
    
end
H = gobjects(num_genes);

gene_counter = 0;
for i = 1:size(files,1)
    
    gene_counter = gene_counter + 1;
    
    % POINTS
    filename = [dir, '/cca_genes_loadings_', files{i}, '.tsv'];
    fid = fopen(filename);
    data = textscan(fid, ['%s' repmat('%f', 1, 9)], 'Delimiter', '\t', 'Headerlines', 1);
    fclose(fid);
    geneMy     = data{1};
    loadMy1    = data{2};
    loadMy2    = data{3};
    loadMy3    = data{4};
    
    H(gene_counter) = plot(loadMy1,loadMy2,'kx');
    set(H(gene_counter),'Color',cb(i,:),'MarkerFaceColor','none','MarkerSize',7,'LineWidth',1.5);
    
    % LABELS (NO ARROWS)
    for j = 1:size(geneMy,1)
    %    arrow_counter = arrow_counter + 1;
    %    o = [0 0];
    %    a = [loadMy1(j) loadMy2(j)];
    %    H(arrow_counter) = arrow(o,a,'Length',5);
    %    set(H(arrow_counter),'EdgeColor',cb(i,:),'FaceColor','none');
        %text(loadMy1(j)*1.05, loadMy2(j)*1.05, geneMy(j), 'HorizontalAlignment', 'center', 'FontSize', 4, 'Color', 'k');
    end

end

% RANDOMLY REORDER LOADINGS (FOR ARROWS)
%ix = randperm(size(H,1));
%Hshuffled = H(ix);
%for i = 1:size(Hshuffled,1)
%    uistack(Hshuffled(i),'top');
%end

% ...BUT PUT OTHER ON BOTTOM
%for i = size(H,1)-size(geneMy)+1:1:size(H,1)
%    uistack(H(i),'bottom');
%end

% PLOT PREDICTORS AS ARROWS
o = [0 0];
for k = 1:size(pcoord1,1)
    a = [pcoord1(k)*scale_predictors pcoord2(k)*scale_predictors];
    ph = arrow(o,a,'Length',5);
    set(ph,'EdgeColor',cbBlues64(48,:),'FaceColor','none','edgealpha',1.0);
end 
%ph = plot(pcoord1*scale_predictors, pcoord2*scale_predictors, 'ko');
% text(pcoord1(1)*scale_predictors, pcoord2(1)*scale_predictors-0.04, predictor(1), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'depth'
% text(pcoord1(2)*scale_predictors+0.7, pcoord2(2)*scale_predictors-0.06, predictor(2), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'temperature'
% text(pcoord1(3)*scale_predictors+0.2, pcoord2(3)*scale_predictors+0.08, predictor(3), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'salinity'
% text(pcoord1(4)*scale_predictors+0.3,pcoord2(4)*scale_predictors+0.06,predictor(4), 'HorizontalAlignment','center', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'oxygen'
% text(pcoord1(5)*scale_predictors, pcoord2(5)*scale_predictors+0.06, 'chlorophyll','HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'fluorescence'
% text(pcoord1(6)*scale_predictors+0.2, pcoord2(6)*scale_predictors+0.06, predictor(6), 'HorizontalAlignment', 'center', 'VerticalAlignment','bottom','FontSize', 12, 'Color', cbBlues64(48,:)); % 'turbidity'
% PO4, SiO4, NO3
% text(pcoord1(8)*scale_predictors, pcoord2(8)*scale_predictors+0.26, predictor(8), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'phosphate'
% text(pcoord1(9)*scale_predictors+0.1, pcoord2(9)*scale_predictors+0.09, predictor(9), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:)); % 'silicate'
% text(pcoord1(7)*scale_predictors, pcoord2(7)*scale_predictors-0.02, predictor(7), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top',    'FontSize', 12, 'Color', cbBlues64(48,:)); % 'nitrate'
%text(pcoord1(8)*scale_predictors, pcoord2(8)*scale_predictors+0.08, 'phosphate, silicate, nitrate', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', cbBlues64(48,:));

% PLOT SAMPLES (BY DEPTH)
for i = 1:size(depth10,2)
    text(coord1(depth10(i))*scale_samples,coord2(depth10(i))*scale_samples,'10','FontSize',8);
end
for i = 1:size(depth25,2)
    text(coord1(depth25(i))*scale_samples,coord2(depth25(i))*scale_samples,'25','FontSize',8);
end
for i = 1:size(depth50,2)
    text(coord1(depth50(i))*scale_samples,coord2(depth50(i))*scale_samples,'50','FontSize',8);
end
for i = 1:size(depth50gaiw,2)
    text(coord1(depth50gaiw(i))*scale_samples,coord2(depth50gaiw(i))*scale_samples,'*50','FontSize',8);
end
for i = 1:size(depth100,2)
    text(coord1(depth100(i))*scale_samples,coord2(depth100(i))*scale_samples,'100','FontSize',8);
end
for i = 1:size(depth100gaiw,2)
    text(coord1(depth100gaiw(i))*scale_samples,coord2(depth100gaiw(i))*scale_samples,'*100','FontSize',8);
end
for i = 1:size(depth200,2)
    text(coord1(depth200(i))*scale_samples,coord2(depth200(i))*scale_samples,'200','FontSize',8);
end
for i = 1:size(depth258,2)
    text(coord1(depth258(i))*scale_samples,coord2(depth258(i))*scale_samples,'200','FontSize',8);
end
for i = 1:size(depth500,2)
    text(coord1(depth500(i))*scale_samples,coord2(depth500(i))*scale_samples,'500','FontSize',8);
end

% ph1 = plot(coord1(depth10)*scale_samples,coord2(depth10)*scale_samples,'ko','Marker',marker10,'MarkerSize',6,'Color',color10,'MarkerFaceColor','none','LineWidth',1.5);
% ph2 = plot(coord1(depth25)*scale_samples,coord2(depth25)*scale_samples,'ko','Marker',marker25,'MarkerSize',6,'Color',color25,'MarkerFaceColor','none','LineWidth',1.5);
% ph3 = plot(coord1(depth50)*scale_samples,coord2(depth50)*scale_samples,'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','none','LineWidth',1.5);
% ph4 = plot(coord1(depth50gaiw)*scale_samples,coord2(depth50gaiw)*scale_samples,'ko','Marker',marker50,'MarkerSize',7,'Color',color50,'MarkerFaceColor','k','LineWidth',1.5);
% ph5 = plot(coord1(depth100)*scale_samples,coord2(depth100)*scale_samples,'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','none','LineWidth',1.5);
% ph6 = plot(coord1(depth100gaiw)*scale_samples,coord2(depth100gaiw)*scale_samples,'ko','Marker',marker100,'MarkerSize',6,'Color',color100,'MarkerFaceColor','k','LineWidth',1.5);
% ph7 = plot(coord1(depth200)*scale_samples,coord2(depth200)*scale_samples,'ko','Marker',marker200,'MarkerSize',6,'Color',color200,'MarkerFaceColor','none','LineWidth',1.5);
% ph8 = plot(coord1(depth258)*scale_samples,coord2(depth258)*scale_samples,'ko','Marker',marker258,'MarkerSize',6,'Color',color258,'MarkerFaceColor','none','LineWidth',1.5);
% ph9 = plot(coord1(depth500)*scale_samples,coord2(depth500)*scale_samples,'ko','Marker',marker500,'MarkerSize',6,'Color',color500,'MarkerFaceColor','none','LineWidth',1.5);
% H2 = [ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9];

% PLOT SAMPLES (BY STATION)
% plot(coord1(stationA),coord2(stationA),'ko','MarkerSize',6,'Color',colorA,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationB),coord2(stationB),'ko','MarkerSize',6,'Color',colorB,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationC),coord2(stationC),'ko','MarkerSize',6,'Color',colorC,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationD),coord2(stationD),'ko','MarkerSize',6,'Color',colorD,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationE),coord2(stationE),'ko','MarkerSize',6,'Color',colorE,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationF),coord2(stationF),'ko','MarkerSize',6,'Color',colorF,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationG),coord2(stationG),'ko','MarkerSize',6,'Color',colorG,'MarkerFaceColor','none','LineWidth',1.5);
% plot(coord1(stationH),coord2(stationH),'ko','MarkerSize',6,'Color',colorH,'MarkerFaceColor','none','LineWidth',1.5);

% LEGEND FOR PATHWAYS
% legend_handle = H(handle_num);
% mylegtext = lower(regexprep(files,'_',' '));
% mylegtext = regexprep(mylegtext,'abc','ABC');
% mylegtext = regexprep(mylegtext,'glycine','glycine,');
% mylegtext = regexprep(mylegtext,'folding','folding,');
% leg = legend(mylegtext,'Interpreter','none','Location','SouthEast','FontSize',10,'Position',[.50 .095 .4 .3]); %[left bottom width height]
% legend boxoff;

%leg.Position = [0,5,5,2];

% PUT OTHER ON BOTTOM, BUT HAVE TO DO AFTER MAKING LEGEND
uistack(H(15),'bottom');

set(gca,'Color','none');

% SWITCH LEGEND AXES
ah = axes('position',get(gca,'position'),'visible','off');

% LEGEND FOR SAMPLES
% legend(ah,H2,{'10 m';'25 m'; '50 m';'50 m/GAIW';'100 m';'100 m/GAIW';'200 m';'258 m';'500 m'},'Location','SouthWest','FontSize',10);
% legend boxoff;
%text(0.02,0.06,['10,20,50,100,200,500 ' char(8211) ' samples by depth (m)']);
%text(0.02,0.03,['*50,*100 ' char(8211) ' GAIW samples by depth (m)']);

%axis([-5 5 -7 4]);

label1 = ['CCA1']; % (', num2str(round(totalIndiv(1),1)), '%)'];
label2 = ['CCA2']; % (', num2str(round(totalIndiv(2),1)), '%)'];
xlabel(label1); % depth
ylabel(label2); % chlorophyll

% set(gca,'FontSize',10);
set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperPosition',[2 2 8 8]);

set(gca,'Color','none');
set(gcf,'Color','none');
set(gcf, 'InvertHardCopy', 'off');

outdir = regexprep(dir,'-','_');
outfile = ['CCA_genes', '_', outdir, '.eps'];
saveas(gca,outfile,'epsc');


