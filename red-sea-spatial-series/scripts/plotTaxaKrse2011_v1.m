% plotTaxaKrse2011_v1.m

% v1 plots genomes individually, colored by type

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

% RGB Color Wheel
% red         = [ 1  0  0];
% orange      = [ 1 .5  0];
% yellow      = [ 1  1  0];
% springgreen = [.5  1  0];
% green       = [ 0  1  0];
% turquoise   = [ 0  1 .5];
% cyan        = [ 0  1  1];
% ocean       = [ 0 .5  1];
% blue        = [ 0  0  1];
% violet      = [.5  0  1];
% magenta     = [ 1  0  1];
% raspberry   = [ 1  0 .5];
% Other Colors
% gray        = [.5 .5 .5];
% darkgreen   = [ 0 .5  0];


fid = fopen('CombinedTaxaKrse2011fix.csv');
data = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',','headerlines',1);
fclose(fid);

genome  = data{1};
samp01f = data{2};
samp01r = data{3};
samp02f = data{4};
samp02r = data{5};
samp03f = data{6};
samp03r = data{7};
samp04f = data{8};
samp04r = data{9};
samp05f = data{10};
samp05r = data{11};
samp06f = data{12};
samp06r = data{13};
samp07f = data{14};
samp07r = data{15};
samp08f = data{16};
samp08r = data{17};
samp09f = data{18};
samp09r = data{19};
samp10f = data{20};
samp10r = data{21};
samp11f = data{22};
samp11r = data{23};
samp12f = data{24};
samp12r = data{25};
samp13f = data{26};
samp13r = data{27};
samp14f = data{28};
samp14r = data{29};
samp15f = data{30};
samp15r = data{31};
samp16f = data{32};
samp16r = data{33};
samp17f = data{34};
samp17r = data{35};
samp18f = data{36};
samp18r = data{37};
samp19f = data{38};
samp19r = data{39};
samp20f = data{40};
samp20r = data{41};
samp21f = data{42};
samp21r = data{43};
samp22f = data{44};
samp22r = data{45};
samp23f = data{46};
samp23r = data{47};
samp24f = data{48};
samp24r = data{49};
samp25f = data{50};
samp25r = data{51};
samp26f = data{52};
samp26r = data{53};
samp27f = data{54};
samp27r = data{55};
samp28f = data{56};
samp28r = data{57};
samp29f = data{58};
samp29r = data{59};
samp30f = data{60};
samp30r = data{61};
samp31f = data{62};
samp31r = data{63};
samp32f = data{64};
samp32r = data{65};
samp33f = data{66};
samp33r = data{67};
samp34f = data{68};
samp34r = data{69};
samp35f = data{70};
samp35r = data{71};
samp36f = data{72};
samp36r = data{73};
samp37f = data{74};
samp37r = data{75};
samp38f = data{76};
samp38r = data{77};
samp39f = data{78};
samp39r = data{79};
samp40f = data{80};
samp40r = data{81};
samp41f = data{82};
samp41r = data{83};
samp42f = data{84};
samp42r = data{85};
samp43f = data{86};
samp43r = data{87};
samp44f = data{88};
samp44r = data{89};
samp45f = data{90};
samp45r = data{91};

% Station 12
figure;
hold on;
pt = title('Station 12');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 47],[samp01f(i) samp02f(i) samp03f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 47],[samp01r(i) samp02r(i) samp03r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 47],[samp01f(i) samp02f(i) samp03f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 47],[samp01r(i) samp02r(i) samp03r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 47],[samp01f(i) samp02f(i) samp03f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 47],[samp01r(i) samp02r(i) samp03r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 47],[samp01f(i) samp02f(i) samp03f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 47],[samp01r(i) samp02r(i) samp03r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 22
figure;
hold on;
pt = title('Station 22');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp04f(i) samp05f(i) samp06f(i) samp07f(i) samp08f(i) samp09f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp04r(i) samp05r(i) samp06r(i) samp07r(i) samp08r(i) samp09r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp04f(i) samp05f(i) samp06f(i) samp07f(i) samp08f(i) samp09f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp04r(i) samp05r(i) samp06r(i) samp07r(i) samp08r(i) samp09r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp04f(i) samp05f(i) samp06f(i) samp07f(i) samp08f(i) samp09f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp04r(i) samp05r(i) samp06r(i) samp07r(i) samp08r(i) samp09r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp04f(i) samp05f(i) samp06f(i) samp07f(i) samp08f(i) samp09f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp04r(i) samp05r(i) samp06r(i) samp07r(i) samp08r(i) samp09r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 34
figure;
hold on;
pt = title('Station 34');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 258],[samp10f(i) samp11f(i) samp12f(i) samp13f(i) samp14f(i) samp15f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 258],[samp10r(i) samp11r(i) samp12r(i) samp13r(i) samp14r(i) samp15r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 258],[samp10f(i) samp11f(i) samp12f(i) samp13f(i) samp14f(i) samp15f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 258],[samp10r(i) samp11r(i) samp12r(i) samp13r(i) samp14r(i) samp15r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 258],[samp10f(i) samp11f(i) samp12f(i) samp13f(i) samp14f(i) samp15f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 258],[samp10r(i) samp11r(i) samp12r(i) samp13r(i) samp14r(i) samp15r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 258],[samp10f(i) samp11f(i) samp12f(i) samp13f(i) samp14f(i) samp15f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 258],[samp10r(i) samp11r(i) samp12r(i) samp13r(i) samp14r(i) samp15r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 91
figure;
hold on;
pt = title('Station 91');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp16f(i) samp17f(i) samp18f(i) samp19f(i) samp20f(i) samp21f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp16r(i) samp17r(i) samp18r(i) samp19r(i) samp20r(i) samp21r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp16f(i) samp17f(i) samp18f(i) samp19f(i) samp20f(i) samp21f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp16r(i) samp17r(i) samp18r(i) samp19r(i) samp20r(i) samp21r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp16f(i) samp17f(i) samp18f(i) samp19f(i) samp20f(i) samp21f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp16r(i) samp17r(i) samp18r(i) samp19r(i) samp20r(i) samp21r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp16f(i) samp17f(i) samp18f(i) samp19f(i) samp20f(i) samp21f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp16r(i) samp17r(i) samp18r(i) samp19r(i) samp20r(i) samp21r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 108
figure;
hold on;
pt = title('Station 108');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp22f(i) samp23f(i) samp24f(i) samp25f(i) samp26f(i) samp27f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp22r(i) samp23r(i) samp24r(i) samp25r(i) samp26r(i) samp27r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp22f(i) samp23f(i) samp24f(i) samp25f(i) samp26f(i) samp27f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp22r(i) samp23r(i) samp24r(i) samp25r(i) samp26r(i) samp27r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp22f(i) samp23f(i) samp24f(i) samp25f(i) samp26f(i) samp27f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp22r(i) samp23r(i) samp24r(i) samp25r(i) samp26r(i) samp27r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp22f(i) samp23f(i) samp24f(i) samp25f(i) samp26f(i) samp27f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp22r(i) samp23r(i) samp24r(i) samp25r(i) samp26r(i) samp27r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 149
figure;
hold on;
pt = title('Station 149');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp28f(i) samp29f(i) samp30f(i) samp31f(i) samp32f(i) samp33f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp28r(i) samp29r(i) samp30r(i) samp31r(i) samp32r(i) samp33r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp28f(i) samp29f(i) samp30f(i) samp31f(i) samp32f(i) samp33f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp28r(i) samp29r(i) samp30r(i) samp31r(i) samp32r(i) samp33r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp28f(i) samp29f(i) samp30f(i) samp31f(i) samp32f(i) samp33f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp28r(i) samp29r(i) samp30r(i) samp31r(i) samp32r(i) samp33r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp28f(i) samp29f(i) samp30f(i) samp31f(i) samp32f(i) samp33f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp28r(i) samp29r(i) samp30r(i) samp31r(i) samp32r(i) samp33r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 169
figure;
hold on;
pt = title('Station 169');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp34f(i) samp35f(i) samp36f(i) samp37f(i) samp38f(i) samp39f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp34r(i) samp35r(i) samp36r(i) samp37r(i) samp38r(i) samp39r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp34f(i) samp35f(i) samp36f(i) samp37f(i) samp38f(i) samp39f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp34r(i) samp35r(i) samp36r(i) samp37r(i) samp38r(i) samp39r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp34f(i) samp35f(i) samp36f(i) samp37f(i) samp38f(i) samp39f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp34r(i) samp35r(i) samp36r(i) samp37r(i) samp38r(i) samp39r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp34f(i) samp35f(i) samp36f(i) samp37f(i) samp38f(i) samp39f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp34r(i) samp35r(i) samp36r(i) samp37r(i) samp38r(i) samp39r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

% Station 192
figure;
hold on;
pt = title('Station 192');
set(pt,'FontSize',14,'Interpreter','none');
for i = [848 856] % HLI: pmc = 9515, pmm = MED4
    plot([10 25 50 100 200 500],[samp40f(i) samp41f(i) samp42f(i) samp43f(i) samp44f(i) samp45f(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp40r(i) samp41r(i) samp42r(i) samp43r(i) samp44r(i) samp45r(i)],'-ko','Marker','none','Color','g','LineWidth',0.5);
end
for i  = [847 851 852 853] % HLII: pmb = 9601, pmg = 9301, pmh = 9215, pmi = 9312
    plot([10 25 50 100 200 500],[samp40f(i) samp41f(i) samp42f(i) samp43f(i) samp44f(i) samp45f(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp40r(i) samp41r(i) samp42r(i) samp43r(i) samp44r(i) samp45r(i)],'-ko','Marker','none','Color','y','LineWidth',0.5);
end
for i  = [846 849 850 854 857 860] % LL: pma = SS120, pme = NATL1A, pmf = 9303, pmj = 9211, pmn = NATL2A, pmt = 9313
    plot([10 25 50 100 200 500],[samp40f(i) samp41f(i) samp42f(i) samp43f(i) samp44f(i) samp45f(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp40r(i) samp41r(i) samp42r(i) samp43r(i) samp44r(i) samp45r(i)],'-ko','Marker','none','Color','b','LineWidth',0.5);
end
for i  = [892] % SAR11: pub = HTCC1062
    plot([10 25 50 100 200 500],[samp40f(i) samp41f(i) samp42f(i) samp43f(i) samp44f(i) samp45f(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
    plot([10 25 50 100 200 500],[samp40r(i) samp41r(i) samp42r(i) samp43r(i) samp44r(i) samp45r(i)],'-ko','Marker','none','Color','r','LineWidth',0.5);
end

tilefigs([2 4], 0);


% FORMAT AND SAVE PLOTS

for j = 1:8
    figure(j);
%     set(gca,'XTick',[0.5 1.5 2.5 4.5 6.5 8.5 10.5]);
%     set(gca,'XTickLabel',{'0.5','1.5','2.5','4.5','6.5','8.5','10.5'});
    px = xlabel('Depth (m)');
    set(px,'FontSize',14,'Interpreter','none');
%     py = ylabel('Fold change, log2(inf/uninf)');
% 	  set(py,'FontSize',14,'Interpreter','none');
    
    set(gca,'FontSize',12);
    
    axis([0 500 50 1e6]);
    set(gca,'YScale','log');
    
    set(gca,'position',[.15 .1 .55 .5]);
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[2 2 4.5 5]);
    
    num = num2str(j);
    outfile = ['taxaKrse2011-',num,'.eps'];
    saveas(gca,outfile,'epsc');
end

