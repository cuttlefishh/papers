% saveNutrientsWhoi.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load nut2011.mat;

nitrite = NaN(375,1);

press = round(press);

matrix = [station cast press nut_id phosp silicate nitrite no3no2 nh4];

%csvwrite('nutrients_whoi.csv',matrix);

plot(press,phosp,'k.');
title('Phosphate');
figure;
plot(press,silicate,'k.');
title('Silicate');
figure;
plot(press,no3no2,'k.');
title('Nitrate');
figure;
plot(press,nh4,'k.');
title('Ammonium');
