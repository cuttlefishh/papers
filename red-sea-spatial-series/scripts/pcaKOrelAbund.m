% pcaKOrelAbund.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

% COLORS BY DEPTH
x = colormap;
color500 = x(1,:);
color200 = x(14,:);
color100 = x(27,:);
color50  = x(40,:);
color25  = x(50,:);
color10  = x(64,:);

% DEPTH LAYERS
depth10  = [1 2  7  8 19 20       31 32 43 44 55 56 67 68 79 80];
depth25  = [3 4  9 10 21 22       33 34 45 46 57 58 69 70 81 82];
depth50  = [5 6 11 12 23 24       35 36 47 48 59 60 71 72 83 84];
depth100 = [    13 14 25 26       37 38 49 50 61 62 73 74 85 86];
depth200 = [    15 16 27 28 29 30 39 40 51 52 63 64 75 76 87 88];
depth500 = [    17 18             41 42 53 54 65 66 77 78 89 90];

% COLORS BY STATION
x = colormap;
colorS1 = x(1,:);
colorS2 = x(10,:);
colorS3 = x(20,:);
colorS4 = x(30,:);
colorS5 = x(37,:);
colorS6 = x(46,:);
colorS7 = x(55,:);
colorS8 = x(64,:);

% STATIONS
S1 = 1:6;
S2 = 7:18;
S3 = 19:30;
S4 = 31:42;
S5 = 43:54;
S6 = 55:66;
S7 = 67:78;
S8 = 79:90;

fileName = 'KOrelAbund_R.csv';

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
read         = data(:,15);

% NORMALIZE KO DATA

% initialize
numKOs = size(data,2) - 15;
dataKOs = data(:,16:size(data,2));
ndataKOs = zeros(90,numKOs);
minKOs = zeros(numKOs);
spanKOs = zeros(numKOs);
meanKOs = zeros(numKOs);
stdKOs = zeros(numKOs);

% % calculate min & span; normalized = (value - min) / span
% for j = 1:numKOs
%     minKOs(j) = min(dataKOs(:,j));
%     spanKOs(j) = max(dataKOs(:,j)) - min(dataKOs(:,j));
%     for i = 1:90
%         ndataKOs(i,j) = (dataKOs(i,j)-minKOs(j))/spanKOs(j);
%     end
% end

% calculate meand & sd; normalized = (value - mean) / sd
for j = 1:numKOs
    meanKOs(j) = mean(dataKOs(:,j));
    stdKOs(j) = std(dataKOs(:,j));
    for i = 1:90
        ndataKOs(i,j) = (dataKOs(i,j)-meanKOs(j))/stdKOs(j);
    end
end

% PCA ANALYSIS - http://www.mathworks.com/help/stats/pca.html
[coeff,score,latent,tsquared,explained,mu] = pca(ndataKOs);

% COLOR BY DEPTH - PLOT FIRST TWO PRINCIPAL COMPONENTS (PC1: 42.8%, PC2: 12.5%)
figure;
hold on;
plot(score(depth10,1),score(depth10,2),'ko','MarkerSize',6,'Color',color10,'LineWidth',1.5);
plot(score(depth25,1),score(depth25,2),'ko','MarkerSize',6,'Color',color25,'LineWidth',1.5);
plot(score(depth50,1),score(depth50,2),'ko','MarkerSize',6,'Color',color50,'LineWidth',1.5);
plot(score(depth100,1),score(depth100,2),'ko','MarkerSize',6,'Color',color100,'LineWidth',1.5);
plot(score(depth200,1),score(depth200,2),'ko','MarkerSize',6,'Color',color200,'LineWidth',1.5);
plot(score(depth500,1),score(depth500,2),'ko','MarkerSize',6,'Color',color500,'LineWidth',1.5);
xlabel('PC1 (42.8%)');
ylabel('PC2 (12.5%)');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
%title('title', 'Interpreter', 'none');
legend({'10 meters'; '25 meters'; '50 meters'; '100 meters'; '200 meters'; '500 meters'}, 'Location', 'NorthOutside');
%legend('boxoff');
set(gca,'FontSize',10);
set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperPosition',[2 2 6 6.59]);
outfile = ['pcaSampleKOrelAbund1', '.eps'];
saveas(gca,outfile,'epsc');

% COLOR BY STATION - PLOT FIRST TWO PRINCIPAL COMPONENTS (PC1: 42.8%, PC2: 12.5%)
figure;
hold on;
plot(score(S1,1),score(S1,2),'ko','MarkerSize',6,'Color',colorS1,'LineWidth',1.5);
plot(score(S2,1),score(S2,2),'ko','MarkerSize',6,'Color',colorS2,'LineWidth',1.5);
plot(score(S3,1),score(S3,2),'ko','MarkerSize',6,'Color',colorS3,'LineWidth',1.5);
plot(score(S4,1),score(S4,2),'ko','MarkerSize',6,'Color',colorS4,'LineWidth',1.5);
plot(score(S5,1),score(S5,2),'ko','MarkerSize',6,'Color',colorS5,'LineWidth',1.5);
plot(score(S6,1),score(S6,2),'ko','MarkerSize',6,'Color',colorS6,'LineWidth',1.5);
plot(score(S7,1),score(S7,2),'ko','MarkerSize',6,'Color',colorS7,'LineWidth',1.5);
plot(score(S8,1),score(S8,2),'ko','MarkerSize',6,'Color',colorS8,'LineWidth',1.5);
xlabel('PC1 (42.8%)');
ylabel('PC2 (12.5%)');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
%title('title', 'Interpreter', 'none');
legend({'Station 12'; 'Station 22'; 'Station 34'; 'Station 91'; 'Station 108'; 'Station 149'; 'Station 169'; 'Station 192'}, 'Location', 'NorthOutside');
%legend('boxoff');
set(gca,'FontSize',10);
set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperPosition',[2 2 6 7]);
outfile = ['pcaSampleKOrelAbund2', '.eps'];
saveas(gca,outfile,'epsc');


%#ok<*NOPTS>
% coeff     % Principal component coefficients, returned as a p-by-p matrix. Each column of coeff contains coefficients for one principal component. The columns are in the order of descending component variance, latent.
% score     % Principal component scores, returned as a matrix. Rows of score correspond to observations, and columns to components.
% latent    % Principal component variances, that is the eigenvalues of the covariance matrix of X, returned as a column vector.
% tsquared  % Hotelling's T-Squared Statistic, which is the sum of squares of the standardized scores for each observation, returned as a column vector.
% explained % Percentage of the total variance explained by each principal component, returned as a column vector.
% mu        % Estimated means of the variables in X, returned as a row vector. When 'algorithm' is 'als', this is estimated by ALS algorithm. When 'algorithm' is not 'als', mu is equal to the sample mean of X.
% cumulative = cumsum(latent)./sum(latent)

% coeff 1: -Temp -Ox +Nit +Phos +Silic (=Depth)
% coeff 2: +Salinity -Temp -Fluor -Turb -Phos (=Salinity)
% coeff 3: +Temp (=Temp)

% Multiple original data by first three column of coeff (dot product)
% this gives data to use for

% Repeat analysis for each depth




