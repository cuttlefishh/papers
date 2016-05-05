% plotIlluminaHist.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fid = fopen('illumina_libraries_krse2011.csv');
headers = textscan(fid,'%s %s %s',1,'delimiter',',');
data = textscan(fid,'%f %f %f','delimiter',',');
fclose(fid);

insert   = data{1};
reads    = data{2};
bp       = data{3};

edges1 = [0:150:1500];
[n1, bin1] = hist(insert,edges1);
ph1 = bar(edges1,n1,'FaceColor','r','EdgeColor','k');
px = xlabel('Average insert size');
set(px,'FontSize',14);
py = ylabel('Number of metagenomes');
set(py,'FontSize',14);
pt = title('Insert size of Illumina metagenomes');
set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([0 1650 0 20]);

figure;
edges2 = [0:2e6:2e7];
[n2, bin2] = hist(reads,edges2);
ph2 = bar(edges2,n2,'FaceColor','r','EdgeColor','k');
px = xlabel('Total number of paired reads (untrimmed)');
set(px,'FontSize',14);
py = ylabel('Number of metagenomes');
set(py,'FontSize',14);
pt = title('Paired reads of Illumina metagenomes');
set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([0 2.2e7 0 20]);

figure;
edges3 = [0:3e8:3e9];
[n3, bin3] = hist(bp,edges3);
ph3 = bar(edges3,n3,'FaceColor','r','EdgeColor','k');
px = xlabel('Total bp (untrimmed)');
set(px,'FontSize',14);
py = ylabel('Number of metagenomes');
set(py,'FontSize',14);
pt = title('Total bp of Illumina metagenomes');
set(pt,'FontSize',14);
set(gca,'FontSize',14);
axis([0 3.3e9 0 20]);

saveas(ph1,'hist_insert','epsc');
saveas(ph2,'hist_reads','epsc');
saveas(ph3,'hist_bp','epsc');



