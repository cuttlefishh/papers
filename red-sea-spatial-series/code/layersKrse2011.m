% layersKrse2011.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fileName = 'krse2011_mixed.csv';
fid = fopen(fileName);
headersMixed = textscan(fid,'%s %s %s',1,'delimiter',',');
dataMixed = textscan(fid,'%f %f %f','delimiter',',');
fclose(fid);

fileName = 'krse2011_chlmax.csv';
fid = fopen(fileName);
headersChlmax = textscan(fid,'%s %s %s',1,'delimiter',',');
dataChlmax = textscan(fid,'%f %f %f','delimiter',',');
fclose(fid);

fileName = 'krse2011_oxmin.csv';
fid = fopen(fileName);
headersOxmin = textscan(fid,'%s %s %s',1,'delimiter',',');
dataOxmin = textscan(fid,'%f %f %f','delimiter',',');
fclose(fid);

fileName = 'krse2011_bottom.csv';
fid = fopen(fileName);
headersBottom = textscan(fid,'%s %s',1,'delimiter',',');
dataBottom = textscan(fid,'%f %f','delimiter',',');
fclose(fid);

station = dataMixed{1};
temp    = dataMixed{2};
mixed   = dataMixed{3};

station = dataChlmax{1};
chl     = dataChlmax{2};
chlmax  = dataChlmax{3};

station = dataOxmin{1};
ox      = dataOxmin{2};
oxmin   = dataOxmin{3};

station = dataBottom{1};
bottom  = dataBottom{2};

figure;
hist(mixed);
title('Mixed layer depth');

figure;
hist(chlmax);
title('Chlorophyll maximum');

figure;
hist(oxmin);
title('Oxygen minimum');

figure;
hist(bottom);
title('Bottom depth');

figure;
plot(station,mixed,'k.');
title('Mixed layer vs. Station no.');

