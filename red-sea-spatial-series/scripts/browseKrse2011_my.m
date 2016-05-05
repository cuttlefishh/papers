% browseKrse2011.m


clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fileName = 'krse2011_v3_my.csv';

data = dlmread(fileName,',',1);

station      = data(:,1);
latitude     = data(:,2);
longitude    = data(:,3);
xcoord       = data(:,4);
ycoord       = data(:,5);
depth        = data(:,6);
temperature  = data(:,7);
salinity     = data(:,8);
oxygen       = data(:,9);
fluorescence = data(:,10);
turbidity    = data(:,11);
nitrate      = data(:,12);
phosphate    = data(:,13);
silicate     = data(:,14);

for i = 1:size(station,1)
    np_ratio(i) = nitrate(i)/phosphate(i);
end
    


% EXAMPLE PLOTS
% hist(temperature,100);
% plot(1:size(temperature,1),temperature,'k.')
% plot(phosphate,-pressure,'k.');



% N VS P LIMITATION
% Redfield ratio: C:N:P = 106:16:1
% But maybe Burt said N:P should be 15:1
plot(phosphate,nitrate,'ko');
hold on;
syms X;
ph = ezplot(15*X, [0 max(phosphate)*1.1]);
ph = ezplot(2*X, [0 max(phosphate)*1.1]);
%axis([0 max(phosphate)*1.1 0 max(nitrate)*1.1]);
axis([0 2 0 20]);
px = xlabel('Phosphate (uM)');
set(px,'FontSize',14);
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14);
pt = title('N vs P Limitation (50 "my"/16S stations)');
set(pt,'FontSize',14);
set(gca,'FontSize',14);
text(0.8, 6, 'Lines represent N:P ratios of 15 and 2', 'FontSize', 12);
saveas(gca,'NvsP_krse2011_my','epsc');

% N:P RATIO VS DEPTH
figure;
plot(np_ratio,depth,'ko');
vline(2,'r-');
vline(15,'b-');
px = xlabel('Nitrate:Phosphate Ratio');
set(px,'FontSize',14);
py = ylabel('Depth (m)');
set(py,'FontSize',14);
pt = title('N:P Ratio vs. Depth (50 "my"/16S stations)');
set(pt,'FontSize',14);
set(gca,'FontSize',14);
saveas(gca,'NPRatio_krse2011_my','epsc');

