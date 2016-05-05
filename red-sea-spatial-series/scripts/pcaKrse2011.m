% browseKrse2011.m


clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fileName = 'krse2011_v3_illumina.csv';

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

% NORMALIZE DATA (DIVIDE BY MAX)
% initialize
nTemperature  = zeros(45,1);
nSalinity     = zeros(45,1);
nOxygen       = zeros(45,1);
nFluorescence = zeros(45,1);
nTurbidity    = zeros(45,1);
nNitrate      = zeros(45,1);
nPhosphate    = zeros(45,1);
nSilicate     = zeros(45,1);
% calculate min
minTemperature  = min(temperature);
minSalinity     = min(salinity);
minOxygen       = min(oxygen);
minFluorescence = min(fluorescence);
minTurbidity    = min(turbidity);
minNitrate      = min(nitrate);
minPhosphate    = min(phosphate);
minSilicate     = min(silicate);
% calculate span
spanTemperature  = max(temperature) - min(temperature);
spanSalinity     = max(salinity) - min(salinity);
spanOxygen       = max(oxygen) - min(oxygen);
spanFluorescence = max(fluorescence) - min(fluorescence);
spanTurbidity    = max(turbidity) - min(turbidity);
spanNitrate      = max(nitrate) - min(nitrate);
spanPhosphate    = max(phosphate) - min(phosphate);
spanSilicate     = max(silicate) - min(silicate);
% normalize
for i = 1:45
    nTemperature(i) = (temperature(i)-minTemperature)/spanTemperature;
    nSalinity(i) = (salinity(i)-minSalinity)/spanSalinity;
    nOxygen(i) = (oxygen(i)-minOxygen)/spanOxygen;
    nFluorescence(i) = (fluorescence(i)-minFluorescence)/spanFluorescence;
    nTurbidity(i) = (turbidity(i)-minTurbidity)/spanTurbidity;
    nNitrate(i) = (nitrate(i)-minNitrate)/spanNitrate;
    nPhosphate(i) = (phosphate(i)-minPhosphate)/spanPhosphate;
    nSilicate(i) = (silicate(i)-minSilicate)/spanSilicate;
end

% COMBINE AS MATRIX
nEnviro = [nTemperature nSalinity nOxygen nFluorescence nTurbidity nNitrate nPhosphate nSilicate];

% PCA ANALYSIS - http://www.mathworks.com/help/stats/pca.html
[coeff,score,latent,tsquared,explained,mu] = pca(nEnviro);

%#ok<*NOPTS>
coeff     % Principal component coefficients, returned as a p-by-p matrix. Each column of coeff contains coefficients for one principal component. The columns are in the order of descending component variance, latent.
score     % Principal component scores, returned as a matrix. Rows of score correspond to observations, and columns to components.
latent    % Principal component variances, that is the eigenvalues of the covariance matrix of X, returned as a column vector.
tsquared  % Hotelling's T-Squared Statistic, which is the sum of squares of the standardized scores for each observation, returned as a column vector.
explained % Percentage of the total variance explained by each principal component, returned as a column vector.
mu        % Estimated means of the variables in X, returned as a row vector. When 'algorithm' is 'als', this is estimated by ALS algorithm. When 'algorithm' is not 'als', mu is equal to the sample mean of X.
cumulative = cumsum(latent)./sum(latent)

% coeff 1: -Temp -Ox +Nit +Phos +Silic (=Depth)
% coeff 2: +Salinity -Temp -Fluor -Turb -Phos (=Salinity)
% coeff 3: +Temp (=Temp)

% Multiple original data by first three column of coeff (dot product)
% this gives data to use for

% Repeat analysis for each depth




