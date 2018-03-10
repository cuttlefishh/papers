% plotNutrientsBATS.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

headers = {'id';'yymmddin';'yymmddout';'decy';'decd';'timein';'timeout';'latNin';'latNout';'lonWin';'lonWout';'qc';'depth';'press';'temp';'ctdSal';'tempPot';'sal';'sigmaTheta';'oxygen';'oxFixTemp';'oxAnom';'co2';'alk';'no3no2';'no2';'po4';'sil';'poc';'pon';'toc';'ton';'bact';'p1';'p2';'p3';'p4';'p5';'p6';'p7';'p8';'p9';'p10';'p11';'p12';'p13';'p14';'p15';'chlA';'phae';'p18';'p19';'p20';'p21';'pop';'tdp';'srp';'bSi';'lSi';'pro';'syn';'picoeuk';'nanoeuk'};
	
fprintf('Quality flags:\n\t-9.99 = No data\n\t    0 = Less than detection limit\nData quality flags:\n\t-9.99 = No data\n\t    0 = Less than detection limit\nBottle quality flags:\n\t    1 = Normal bottle fire\n\t    2 = Bottle misfire\n\t    3 = Suspect bottle\nAll positions are in decimal degrees.\nAll times are GMT.\n\n');

index = [1 2 8 10 12 13 14 17 18 25 26 27];

fprintf('Analyzing the following parameters:\n');
for i = index
    if i < 10
        fprintf('     ');
    else
        fprintf('    ');
    end
    fprintf(1,'%d %s\n',i,headers{i});
end
fprintf('\n');
fprintf('Data points with depth <= 50 and non-negative values for no3no2, no2, or po4:\n\n');

root = {'bats10001';'bats10013';'bats10025';'bats10037';'bats10049';'bats10061';'bats10073';'bats10085';'bats10097';'bats10109';'bats10121';'bats10133';'bats10145';'bats10157';'bats10169';'bats10181';'bats10193';'bats10205';'bats10216';'bats10228';'bats10240';'bats10251';'bats10263'};
dimRoot = size(root);
numRoot = dimRoot(1);

for j = 1:numRoot
    
    fileMat = [root{j},'.mat'];
    load(fileMat,'-mat');
    dimData = size(data);
    numData = dimData(1);
    
    id = data(:,1);
    yymmddin = data(:,2);
    latNin = data(:,8);
    lonWin = data(:,10);
    qc = data(:,12);
    depth = data(:,13);
    press = data(:,14);
    tempPot = data(:,17);
    sal = data(:,18);
    no3no2 = data(:,25);
    no2 = data(:,26);
    po4 = data(:,27);
    
    for k = 1:numData
        if (depth(k) <= 50)
            if ((no3no2(k) > 0) || (no2(k) > 0) || (po4(k) > 0))
                fprintf(1,'id: %d\ndepth: %f\ntempPot: %f\nsal: %f\nno3no2: %f\nno2: %f\npo4: %f\n\n',id(k),depth(k),tempPot(k),sal(k),no3no2(k),no2(k),po4(k));
            end
        end
    end
end




% 
% 
% station    = data{1};
% cast       = data{2};
% depth      = data{3};
% sampleid   = data{4};
% phosphate  = data{5};
% silicate   = data{6};
% nitrite    = data{7};
% no2plusno3 = data{8};
% nitrate    = data{8} - data{7};
% ammonium   = data{9};
% 
% dimData = size(station);
% numData = dimData(1);
% 
% a = 1;  % 10 meters index
% b = 1;  % 25 meters index
% c = 1;  % 50 meters index
% d = 1;  % 100 meters index
% e = 1;  % 200 meters index
% f = 1;  % 500 meters index
% 
% for i = 1:numData
%     if (depth(i) >= 5) && (depth(i) <= 15)  % 10 meters
%         depth10(a)   = depth(i);
%         phosphate10(a) = phosphate(i);
%         silicate10(a)  = silicate(i);
%         nitrite10(a)   = nitrite(i);
%         nitrate10(a)   = nitrate(i);
%         ammonium10(a)  = ammonium(i);
%         a = a + 1;
%     end
%     if (depth(i) >= 20) && (depth(i) <= 30)  % 25 meters
%         depth25(b)   = depth(i);
%         phosphate25(b) = phosphate(i);
%         silicate25(b)  = silicate(i);
%         nitrite25(b)   = nitrite(i);
%         nitrate25(b)   = nitrate(i);
%         ammonium25(b)  = ammonium(i);
%         b = b + 1;
%     end
%     if (depth(i) >= 45) && (depth(i) <= 55)  % 50 meters
%         depth50(c)   = depth(i);
%         phosphate50(c) = phosphate(i);
%         silicate50(c)  = silicate(i);
%         nitrite50(c)   = nitrite(i);
%         nitrate50(c)   = nitrate(i);
%         ammonium50(c)  = ammonium(i);
%         c = c + 1;
%     end
%     if (depth(i) >= 95) && (depth(i) <= 105)  % 100 meters
%         depth100(d)   = depth(i);
%         phosphate100(d) = phosphate(i);
%         silicate100(d)  = silicate(i);
%         nitrite100(d)   = nitrite(i);
%         nitrate100(d)   = nitrate(i);
%         ammonium100(d)  = ammonium(i);
%         d = d + 1;
%     end
%     if (depth(i) >= 195) && (depth(i) <= 205)  % 200 meters
%         depth200(e)   = depth(i);
%         phosphate200(e) = phosphate(i);
%         silicate200(e)  = silicate(i);
%         nitrite200(e)   = nitrite(i);
%         nitrate200(e)   = nitrate(i);
%         ammonium200(e)  = ammonium(i);
%         e = e + 1;
%     end
%     if (depth(i) >= 495) && (depth(i) <= 505)  % 500 meters
%         depth500(f)   = depth(i);
%         phosphate500(f) = phosphate(i);
%         silicate500(f)  = silicate(i);
%         nitrite500(f)   = nitrite(i);
%         nitrate500(f)   = nitrate(i);
%         ammonium500(f)  = ammonium(i);
%         f = f + 1;
%     end
% end
% 
% fprintf('\nPhosphate: median mean std\n');
% fprintf(' 10m: %f %f %f\n',nanmedian(phosphate10),nanmean(phosphate10),nanstd(phosphate10));
% fprintf(' 25m: %f %f %f\n',nanmedian(phosphate25),nanmean(phosphate25),nanstd(phosphate25));
% fprintf(' 50m: %f %f %f\n',nanmedian(phosphate50),nanmean(phosphate50),nanstd(phosphate50));
% fprintf('100m: %f %f %f\n',nanmedian(phosphate100),nanmean(phosphate100),nanstd(phosphate100));
% fprintf('200m: %f %f %f\n',nanmedian(phosphate200),nanmean(phosphate200),nanstd(phosphate200));
% fprintf('500m: %f %f %f\n',nanmedian(phosphate500),nanmean(phosphate500),nanstd(phosphate500));
% 
% fprintf('\nSilicate: median mean std\n');
% fprintf(' 10m: %f %f %f\n',nanmedian(silicate10),nanmean(silicate10),nanstd(silicate10));
% fprintf(' 25m: %f %f %f\n',nanmedian(silicate25),nanmean(silicate25),nanstd(silicate25));
% fprintf(' 50m: %f %f %f\n',nanmedian(silicate50),nanmean(silicate50),nanstd(silicate50));
% fprintf('100m: %f %f %f\n',nanmedian(silicate100),nanmean(silicate100),nanstd(silicate100));
% fprintf('200m: %f %f %f\n',nanmedian(silicate200),nanmean(silicate200),nanstd(silicate200));
% fprintf('500m: %f %f %f\n',nanmedian(silicate500),nanmean(silicate500),nanstd(silicate500));
% 
% fprintf('\nNitrite: median mean std\n');
% fprintf(' 10m: %f %f %f\n',nanmedian(nitrite10),nanmean(nitrite10),nanstd(nitrite10));
% fprintf(' 25m: %f %f %f\n',nanmedian(nitrite25),nanmean(nitrite25),nanstd(nitrite25));
% fprintf(' 50m: %f %f %f\n',nanmedian(nitrite50),nanmean(nitrite50),nanstd(nitrite50));
% fprintf('100m: %f %f %f\n',nanmedian(nitrite100),nanmean(nitrite100),nanstd(nitrite100));
% fprintf('200m: %f %f %f\n',nanmedian(nitrite200),nanmean(nitrite200),nanstd(nitrite200));
% fprintf('500m: %f %f %f\n',nanmedian(nitrite500),nanmean(nitrite500),nanstd(nitrite500));
% 
% fprintf('\nNitrate: median mean std\n');
% fprintf(' 10m: %f %f %f\n',nanmedian(nitrate10),nanmean(nitrate10),nanstd(nitrate10));
% fprintf(' 25m: %f %f %f\n',nanmedian(nitrate25),nanmean(nitrate25),nanstd(nitrate25));
% fprintf(' 50m: %f %f %f\n',nanmedian(nitrate50),nanmean(nitrate50),nanstd(nitrate50));
% fprintf('100m: %f %f %f\n',nanmedian(nitrate100),nanmean(nitrate100),nanstd(nitrate100));
% fprintf('200m: %f %f %f\n',nanmedian(nitrate200),nanmean(nitrate200),nanstd(nitrate200));
% fprintf('500m: %f %f %f\n',nanmedian(nitrate500),nanmean(nitrate500),nanstd(nitrate500));
% 
% fprintf('\nAmmonium: median mean std\n');
% fprintf(' 10m: %f %f %f\n',nanmedian(ammonium10),nanmean(ammonium10),nanstd(ammonium10));
% fprintf(' 25m: %f %f %f\n',nanmedian(ammonium25),nanmean(ammonium25),nanstd(ammonium25));
% fprintf(' 50m: %f %f %f\n',nanmedian(ammonium50),nanmean(ammonium50),nanstd(ammonium50));
% fprintf('100m: %f %f %f\n',nanmedian(ammonium100),nanmean(ammonium100),nanstd(ammonium100));
% fprintf('200m: %f %f %f\n',nanmedian(ammonium200),nanmean(ammonium200),nanstd(ammonium200));
% fprintf('500m: %f %f %f\n',nanmedian(ammonium500),nanmean(ammonium500),nanstd(ammonium500));
% 
% ph = plot(depth,phosphate,'ko');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Phosphate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% thetitle = [root,'_phosphate'];
% pt = title(thetitle);
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% saveas(gca,thetitle,'epsc');
% 
% ph = plot(depth,silicate,'ko');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Silicate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% thetitle = [root,'_silicate'];
% pt = title(thetitle);
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% saveas(gca,thetitle,'epsc');
% 
% ph = plot(depth,nitrite,'ko');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrite (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% thetitle = [root,'_nitrite'];
% pt = title(thetitle);
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% saveas(gca,thetitle,'epsc');
% 
% ph = plot(depth,nitrate,'ko');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Nitrate (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% thetitle = [root,'_nitrate'];
% pt = title(thetitle);
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% saveas(gca,thetitle,'epsc');
% 
% ph = plot(depth,ammonium,'ko');
% px = xlabel('Depth (m)');
% set(px,'FontSize',14,'Interpreter','none');
% py = ylabel('Ammonium (uM)');
% set(py,'FontSize',14,'Interpreter','none');
% thetitle = [root,'_ammonium'];
% pt = title(thetitle);
% set(pt,'FontSize',14,'Interpreter','none');
% set(gca,'FontSize',12);
% saveas(gca,thetitle,'epsc');
% 
% 
% % set(gcf,'PaperPositionMode','manual');
% % set(gcf,'PaperUnits','inches');
% % set(gcf,'PaperPosition',[2 1 8 3]);
% 
