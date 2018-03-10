% plotNutrientsWhoi.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load nut2011copy.mat;
root = 'nutrients_whoi';

dimData = size(station);
numData = dimData(1);

a = 1;  % 10 meters index
b = 1;  % 25 meters index
c = 1;  % 50 meters index
d = 1;  % 100 meters index
e = 1;  % 200 meters index
f = 1;  % 500 meters index

for i = 1:numData
    if (press(i) >= 5) && (press(i) <= 15)  % 10 meters
        depth10(a)   = press(i);
        phosphate10(a) = phosp(i);
        silicate10(a)  = silicate(i);
        nitrate10(a)   = no3no2(i);
        ammonium10(a)  = nh4(i);
        a = a + 1;
    end
    if (press(i) >= 20) && (press(i) <= 30)  % 25 meters
        depth25(b)   = press(i);
        phosphate25(b) = phosp(i);
        silicate25(b)  = silicate(i);
        nitrate25(b)   = no3no2(i);
        ammonium25(b)  = nh4(i);
        b = b + 1;
    end
    if (press(i) >= 45) && (press(i) <= 55)  % 50 meters
        depth50(c)   = press(i);
        phosphate50(c) = phosp(i);
        silicate50(c)  = silicate(i);
        nitrate50(c)   = no3no2(i);
        ammonium50(c)  = nh4(i);
        c = c + 1;
    end
    if (press(i) >= 95) && (press(i) <= 105)  % 100 meters
        depth100(d)   = press(i);
        phosphate100(d) = phosp(i);
        silicate100(d)  = silicate(i);
        nitrate100(d)   = no3no2(i);
        ammonium100(d)  = nh4(i);
        d = d + 1;
    end
    if (press(i) >= 195) && (press(i) <= 205)  % 200 meters
        depth200(e)   = press(i);
        phosphate200(e) = phosp(i);
        silicate200(e)  = silicate(i);
        nitrate200(e)   = no3no2(i);
        ammonium200(e)  = nh4(i);
        e = e + 1;
    end
    if (press(i) >= 495) && (press(i) <= 505)  % 500 meters
        depth500(f)   = press(i);
        phosphate500(f) = phosp(i);
        silicate500(f)  = silicate(i);
        nitrate500(f)   = no3no2(i);
        ammonium500(f)  = nh4(i);
        f = f + 1;
    end
end

fprintf('\nPhosphate: median mean std\n');
fprintf(' 10m: %f %f %f\n',nanmedian(phosphate10),nanmean(phosphate10),nanstd(phosphate10));
fprintf(' 25m: %f %f %f\n',nanmedian(phosphate25),nanmean(phosphate25),nanstd(phosphate25));
fprintf(' 50m: %f %f %f\n',nanmedian(phosphate50),nanmean(phosphate50),nanstd(phosphate50));
fprintf('100m: %f %f %f\n',nanmedian(phosphate100),nanmean(phosphate100),nanstd(phosphate100));
fprintf('200m: %f %f %f\n',nanmedian(phosphate200),nanmean(phosphate200),nanstd(phosphate200));
fprintf('500m: %f %f %f\n',nanmedian(phosphate500),nanmean(phosphate500),nanstd(phosphate500));

fprintf('\nSilicate: median mean std\n');
fprintf(' 10m: %f %f %f\n',nanmedian(silicate10),nanmean(silicate10),nanstd(silicate10));
fprintf(' 25m: %f %f %f\n',nanmedian(silicate25),nanmean(silicate25),nanstd(silicate25));
fprintf(' 50m: %f %f %f\n',nanmedian(silicate50),nanmean(silicate50),nanstd(silicate50));
fprintf('100m: %f %f %f\n',nanmedian(silicate100),nanmean(silicate100),nanstd(silicate100));
fprintf('200m: %f %f %f\n',nanmedian(silicate200),nanmean(silicate200),nanstd(silicate200));
fprintf('500m: %f %f %f\n',nanmedian(silicate500),nanmean(silicate500),nanstd(silicate500));

fprintf('\nNitrate+Nitrite: median mean std\n');
fprintf(' 10m: %f %f %f\n',nanmedian(nitrate10),nanmean(nitrate10),nanstd(nitrate10));
fprintf(' 25m: %f %f %f\n',nanmedian(nitrate25),nanmean(nitrate25),nanstd(nitrate25));
fprintf(' 50m: %f %f %f\n',nanmedian(nitrate50),nanmean(nitrate50),nanstd(nitrate50));
fprintf('100m: %f %f %f\n',nanmedian(nitrate100),nanmean(nitrate100),nanstd(nitrate100));
fprintf('200m: %f %f %f\n',nanmedian(nitrate200),nanmean(nitrate200),nanstd(nitrate200));
fprintf('500m: %f %f %f\n',nanmedian(nitrate500),nanmean(nitrate500),nanstd(nitrate500));

fprintf('\nAmmonium: median mean std\n');
fprintf(' 10m: %f %f %f\n',nanmedian(ammonium10),nanmean(ammonium10),nanstd(ammonium10));
fprintf(' 25m: %f %f %f\n',nanmedian(ammonium25),nanmean(ammonium25),nanstd(ammonium25));
fprintf(' 50m: %f %f %f\n',nanmedian(ammonium50),nanmean(ammonium50),nanstd(ammonium50));
fprintf('100m: %f %f %f\n',nanmedian(ammonium100),nanmean(ammonium100),nanstd(ammonium100));
fprintf('200m: %f %f %f\n',nanmedian(ammonium200),nanmean(ammonium200),nanstd(ammonium200));
fprintf('500m: %f %f %f\n',nanmedian(ammonium500),nanmean(ammonium500),nanstd(ammonium500));

ph = plot(press,phosp,'ko');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Phosphate (uM)');
set(py,'FontSize',14,'Interpreter','none');
thetitle = [root,'_phosphate'];
pt = title(thetitle);
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
axis([0 500 0 3.5]);
saveas(gca,thetitle,'epsc');

figure;
ph = plot(press,silicate,'ko');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Silicate (uM)');
set(py,'FontSize',14,'Interpreter','none');
thetitle = [root,'_silicate'];
pt = title(thetitle);
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
axis([0 500 0 30]);
saveas(gca,thetitle,'epsc');

figure;
ph = plot(press,no3no2,'ko');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nitrate+Nitrite (uM)');
set(py,'FontSize',14,'Interpreter','none');
thetitle = [root,'_nitrate'];
pt = title(thetitle);
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
axis([0 500 0 20]);
saveas(gca,thetitle,'epsc');

figure;
ph = plot(press,nh4,'ko');
px = xlabel('Depth (m)');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Ammonium (uM)');
set(py,'FontSize',14,'Interpreter','none');
thetitle = [root,'_ammonium'];
pt = title(thetitle);
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
axis([0 500 0 14]);
saveas(gca,thetitle,'epsc');

tilefigs([2 3],5);

