% cmpNutsUcsbWhoiStn.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load nut2011copy.mat;

nitrite = NaN(375,1);  % make empty nitrite data for whoi

fid = fopen('nutrients_ucsb.csv');
headers = textscan(fid,'%s %s %s %s %s %s %s %s %s',1,'delimiter',',');
data = textscan(fid,'%f %f %f %f %f %f %f %f %f','delimiter',',');
fclose(fid);

stationU    = data{1};
castU       = data{2};
pressU      = data{3};
nut_idU     = data{4};
phospU      = data{5};
silicateU   = data{6};
nitriteU    = data{7};
no3no2U     = data{8};
nh4U        = data{9};

% phosphate - stn 12
hold on;
ph1 = plot(press(22),phosp(22),'-ko');
ph2 = plot(pressU(14:16),phospU(14:16),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate Stn-12');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn12phosp','epsc');

% phosphate - stn 34
figure;
hold on;
ph1 = plot(press(47:53),phosp(47:53),'-ko');
ph2 = plot(pressU(46:51),phospU(46:51),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate Stn-34');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn34phosp','epsc');

% phosphate - stn 149
figure;
hold on;
ph1 = plot(press(229:242),phosp(229:242),'-ko');
ph2 = plot(pressU(195:200),phospU(195:200),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate Stn-149');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn149phosp','epsc');

% phosphate - stn 169
figure;
hold on;
ph1 = plot(press(285:286),phosp(285:286),'-ko');
ph2 = plot(pressU(236:241),phospU(236:241),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate Stn-169');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn169phosp','epsc');

% phosphate - stn 192
figure;
hold on;
ph1 = plot(press(338:350),phosp(338:350),'-ko');
ph2 = plot(pressU(272:277),phospU(272:277),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Phosphate Stn-192');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn192phosp','epsc');

% silicate - stn 12
hold on;
ph1 = plot(press(22),silicate(22),'-ko');
ph2 = plot(pressU(14:16),silicateU(14:16),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate Stn-12');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn12silicate','epsc');

% silicate - stn 34
figure;
hold on;
ph1 = plot(press(47:53),silicate(47:53),'-ko');
ph2 = plot(pressU(46:51),silicateU(46:51),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate Stn-34');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn34silicate','epsc');

% silicate - stn 149
figure;
hold on;
ph1 = plot(press(229:242),silicate(229:242),'-ko');
ph2 = plot(pressU(195:200),silicateU(195:200),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate Stn-149');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn149silicate','epsc');

% silicate - stn 169
figure;
hold on;
ph1 = plot(press(285:286),silicate(285:286),'-ko');
ph2 = plot(pressU(236:241),silicateU(236:241),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate Stn-169');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn169silicate','epsc');

% silicate - stn 192
figure;
hold on;
ph1 = plot(press(338:350),silicate(338:350),'-ko');
ph2 = plot(pressU(272:277),silicateU(272:277),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Silicate Stn-192');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn192silicate','epsc');

% no3no2 - stn 12
hold on;
ph1 = plot(press(22),no3no2(22),'-ko');
ph2 = plot(pressU(14:16),no3no2U(14:16),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate+Nitrite Stn-12');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn12no3no2','epsc');

% no3no2 - stn 34
figure;
hold on;
ph1 = plot(press(47:53),no3no2(47:53),'-ko');
ph2 = plot(pressU(46:51),no3no2U(46:51),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate+Nitrite Stn-34');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn34no3no2','epsc');

% no3no2 - stn 149
figure;
hold on;
ph1 = plot(press(229:242),no3no2(229:242),'-ko');
ph2 = plot(pressU(195:200),no3no2U(195:200),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate+Nitrite Stn-149');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn149no3no2','epsc');

% no3no2 - stn 169
figure;
hold on;
ph1 = plot(press(285:286),no3no2(285:286),'-ko');
ph2 = plot(pressU(236:241),no3no2U(236:241),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate+Nitrite Stn-169');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn169no3no2','epsc');

% no3no2 - stn 192
figure;
hold on;
ph1 = plot(press(338:350),no3no2(338:350),'-ko');
ph2 = plot(pressU(272:277),no3no2U(272:277),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Nitrate+Nitrite Stn-192');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn192no3no2','epsc');

% ammonium - stn 12
hold on;
ph1 = plot(press(22),nh4(22),'-ko');
ph2 = plot(pressU(14:16),nh4U(14:16),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium Stn-12');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn12nh4','epsc');

% ammonium - stn 34
figure;
hold on;
ph1 = plot(press(47:53),nh4(47:53),'-ko');
ph2 = plot(pressU(46:51),nh4U(46:51),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium Stn-34');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn34nh4','epsc');

% ammonium - stn 149
figure;
hold on;
ph1 = plot(press(229:242),nh4(229:242),'-ko');
ph2 = plot(pressU(195:200),nh4U(195:200),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium Stn-149');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn149nh4','epsc');

% ammonium - stn 169
figure;
hold on;
ph1 = plot(press(285:286),nh4(285:286),'-ko');
ph2 = plot(pressU(236:241),nh4U(236:241),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium Stn-169');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn169nh4','epsc');

% ammonium - stn 192
figure;
hold on;
ph1 = plot(press(338:350),nh4(338:350),'-ko');
ph2 = plot(pressU(272:277),nh4U(272:277),'--bo');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Ammonium Stn-192');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI','UCSB','Location','EastOutside');
saveas(gca,'stn192nh4','epsc');

tilefigs([4 5],5);

