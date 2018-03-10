% cmpNutsUcsbWhoiBurt.m

% Burt wants to see nutrient concentrations as a function of temperature,
% oxygen, and density.  Here I do this for all samples, depth bins of
% samples, and stations where two datasets overlap.

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

fid = fopen('krse2011_v1_whoiOnly.csv');
headers = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter',',');
data = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',');
fclose(fid);

fid = fopen('krse2011_v1_ucsbOnly.csv');
headersU = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter',',');
dataU = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',');
fclose(fid);

station   = data{1};
lat       = data{2};
lon       = data{3};
press     = data{4};
temp      = data{5};
sal       = data{6};
ox        = data{7};
fluor     = data{8};
turb      = data{9};
phosp     = data{10};
silicate  = data{11};
no3no2    = data{12};
nh4       = data{13};

stationU   = dataU{1};
latU       = dataU{2};
lonU       = dataU{3};
pressU     = dataU{4};
tempU      = dataU{5};
salU       = dataU{6};
oxU        = dataU{7};
fluorU     = dataU{8};
turbU      = dataU{9};
phospU     = dataU{10};
silicateU  = dataU{11};
no3no2U    = dataU{12};
nh4U       = dataU{13};

% PLOT ALL
hold on;
ph1 = plot(temp,phosp,'kx');
ph2 = plot(tempU,phospU,'ko');
px = xlabel('Temperature (degC)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate vs. Temperature (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllPhospTemp','epsc');

figure;
hold on;
ph1 = plot(temp,silicate,'kx');
ph2 = plot(tempU,silicateU,'ko');
px = xlabel('Temperature (degC)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate vs. Temperature (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllSilicTemp','epsc');

figure;
hold on;
ph1 = plot(temp,no3no2,'kx');
ph2 = plot(tempU,no3no2U,'ko');
px = xlabel('Temperature (degC)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate vs. Temperature (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllNitraTemp','epsc');

figure;
hold on;
ph1 = plot(temp,nh4,'kx');
ph2 = plot(tempU,nh4U,'ko');
px = xlabel('Temperature (degC)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium vs. Temperature (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllAmmonTemp','epsc');

figure;
hold on;
ph1 = plot(ox,phosp,'kx');
ph2 = plot(oxU,phospU,'ko');
px = xlabel('Oxygen (mg/L)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate vs. Oxygen (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllPhospOxy','epsc');

figure;
hold on;
ph1 = plot(ox,silicate,'kx');
ph2 = plot(oxU,silicateU,'ko');
px = xlabel('Oxygen (mg/L)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate vs. Oxygen (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllSilicOxy','epsc');

figure;
hold on;
ph1 = plot(ox,no3no2,'kx');
ph2 = plot(oxU,no3no2U,'ko');
px = xlabel('Oxygen (mg/L)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate vs. Oxygen (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllNitraOxy','epsc');

figure;
hold on;
ph1 = plot(ox,nh4,'kx');
ph2 = plot(oxU,nh4U,'ko');
px = xlabel('Oxygen (mg/L)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium vs. Oxygen (all stations)');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','NorthEast');
saveas(gca,'burtAllAmmonOxy','epsc');




% % phosphate - stn 12
% hold on;
% ph1 = plot(press(22),phosp(22),'-ko');
% ph2 = plot(pressU(14:16),phospU(14:16),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Phosphate Stn-12');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn12phosp','epsc');
% 
% % phosphate - stn 34
% figure;
% hold on;
% ph1 = plot(press(47:53),phosp(47:53),'-ko');
% ph2 = plot(pressU(46:51),phospU(46:51),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Phosphate Stn-34');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn34phosp','epsc');
% 
% % phosphate - stn 149
% figure;
% hold on;
% ph1 = plot(press(229:242),phosp(229:242),'-ko');
% ph2 = plot(pressU(195:200),phospU(195:200),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Phosphate Stn-149');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn149phosp','epsc');
% 
% % phosphate - stn 169
% figure;
% hold on;
% ph1 = plot(press(285:286),phosp(285:286),'-ko');
% ph2 = plot(pressU(236:241),phospU(236:241),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Phosphate Stn-169');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn169phosp','epsc');
% 
% % phosphate - stn 192
% figure;
% hold on;
% ph1 = plot(press(338:350),phosp(338:350),'-ko');
% ph2 = plot(pressU(272:277),phospU(272:277),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Phosphate Stn-192');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn192phosp','epsc');
% 
% % silicate - stn 12
% hold on;
% ph1 = plot(press(22),silicate(22),'-ko');
% ph2 = plot(pressU(14:16),silicateU(14:16),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Silicate Stn-12');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn12silicate','epsc');
% 
% % silicate - stn 34
% figure;
% hold on;
% ph1 = plot(press(47:53),silicate(47:53),'-ko');
% ph2 = plot(pressU(46:51),silicateU(46:51),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Silicate Stn-34');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn34silicate','epsc');
% 
% % silicate - stn 149
% figure;
% hold on;
% ph1 = plot(press(229:242),silicate(229:242),'-ko');
% ph2 = plot(pressU(195:200),silicateU(195:200),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Silicate Stn-149');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn149silicate','epsc');
% 
% % silicate - stn 169
% figure;
% hold on;
% ph1 = plot(press(285:286),silicate(285:286),'-ko');
% ph2 = plot(pressU(236:241),silicateU(236:241),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Silicate Stn-169');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn169silicate','epsc');
% 
% % silicate - stn 192
% figure;
% hold on;
% ph1 = plot(press(338:350),silicate(338:350),'-ko');
% ph2 = plot(pressU(272:277),silicateU(272:277),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Silicate Stn-192');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn192silicate','epsc');
% 
% % no3no2 - stn 12
% hold on;
% ph1 = plot(press(22),no3no2(22),'-ko');
% ph2 = plot(pressU(14:16),no3no2U(14:16),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate+Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Nitrate+Nitrite Stn-12');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn12no3no2','epsc');
% 
% % no3no2 - stn 34
% figure;
% hold on;
% ph1 = plot(press(47:53),no3no2(47:53),'-ko');
% ph2 = plot(pressU(46:51),no3no2U(46:51),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate+Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Nitrate+Nitrite Stn-34');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn34no3no2','epsc');
% 
% % no3no2 - stn 149
% figure;
% hold on;
% ph1 = plot(press(229:242),no3no2(229:242),'-ko');
% ph2 = plot(pressU(195:200),no3no2U(195:200),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate+Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Nitrate+Nitrite Stn-149');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn149no3no2','epsc');
% 
% % no3no2 - stn 169
% figure;
% hold on;
% ph1 = plot(press(285:286),no3no2(285:286),'-ko');
% ph2 = plot(pressU(236:241),no3no2U(236:241),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate+Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Nitrate+Nitrite Stn-169');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn169no3no2','epsc');
% 
% % no3no2 - stn 192
% figure;
% hold on;
% ph1 = plot(press(338:350),no3no2(338:350),'-ko');
% ph2 = plot(pressU(272:277),no3no2U(272:277),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate+Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Nitrate+Nitrite Stn-192');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn192no3no2','epsc');
% 
% % ammonium - stn 12
% hold on;
% ph1 = plot(press(22),nh4(22),'-ko');
% ph2 = plot(pressU(14:16),nh4U(14:16),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Ammonium Stn-12');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn12nh4','epsc');
% 
% % ammonium - stn 34
% figure;
% hold on;
% ph1 = plot(press(47:53),nh4(47:53),'-ko');
% ph2 = plot(pressU(46:51),nh4U(46:51),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Ammonium Stn-34');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn34nh4','epsc');
% 
% % ammonium - stn 149
% figure;
% hold on;
% ph1 = plot(press(229:242),nh4(229:242),'-ko');
% ph2 = plot(pressU(195:200),nh4U(195:200),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Ammonium Stn-149');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn149nh4','epsc');
% 
% % ammonium - stn 169
% figure;
% hold on;
% ph1 = plot(press(285:286),nh4(285:286),'-ko');
% ph2 = plot(pressU(236:241),nh4U(236:241),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Ammonium Stn-169');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn169nh4','epsc');
% 
% % ammonium - stn 192
% figure;
% hold on;
% ph1 = plot(press(338:350),nh4(338:350),'-ko');
% ph2 = plot(pressU(272:277),nh4U(272:277),'--bo');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% pt = title('Ammonium Stn-192');
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% legend('WHOI','UCSB','Location','EastOutside');
% saveas(gca,'stn192nh4','epsc');
% 
% tilefigs([4 5],5);
% 
