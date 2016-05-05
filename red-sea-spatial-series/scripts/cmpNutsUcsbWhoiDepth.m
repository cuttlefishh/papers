% cmpNutsUcsbWhoiDepth.m

% DATA EDITS
% 1. UCSB silicate - remove all data because values are artificially high
% due to the use of glass vials.
%
% 2. UCSB samples where vials were cracked and broken upon receipt, stored
% and thawed in ziploc bag before anlaysis (marked with one asterisk in
% nutrients_20120228.xlsx): contam_broken_shipment.txt (16)
% 
% 3. UCSB samples where vials were cracked and transferred to new vials
% here at KAUST (those with destination UCSB in file
% Sampling_Log_InorgNuts_KRSE2011.xlsx): contam_broken_here.txt (36)
% 
% 4. Detection limit - these are UCSB limits but I have not change anything
% phosphate       0.10 uM
% silicate        n/a
% nitrite         0.10 uM
% nitrate+nitrite 0.20 uM
% ammonium        0.10 uM

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

load nut2011.mat;
press = round(press);

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

% contamList is the list of sample IDs that had vials cracked either upon
% arrival at UCSB or prior to shipping here at KAUST.
% To keep only those samples not on this list, I am using the boolean
% if (sum(nut_idU(i) == contamList) == 0), which checks if the sum of
% boolean comparisons is 0, indicating the sample ID is not in the list.
contamList = [131827 134122 135731 135750 135766 135767 136338 136344 136396 680568 680681 686316 688434 688437 688448 709009 131538 131561 131565 131569 131570 131577 131585 131603 131611 131631 134175 134182 134184 134194 134201 134205 134208 134209 134215 134221 134223 134237 134246 681617 688406 688411 688412 688427 688434 688448 688450 688453 688458 688460 688486 688575];

% get sizes of data sets
dimWhoi = size(station);
numWhoi = dimWhoi(1);
dimUcsb = size(stationU);
numUcsb = dimUcsb(1);

% make empty vectors for each institution and nutrient/station and depth class
stationWhoiA = nan(dimWhoi);
stationWhoiB = nan(dimWhoi);
stationWhoiC = nan(dimWhoi);
stationWhoiD = nan(dimWhoi);
stationWhoiE = nan(dimWhoi);
stationWhoiF = nan(dimWhoi);
stationWhoiG = nan(dimWhoi);
stationWhoiH = nan(dimWhoi);
phospWhoiA = nan(dimWhoi);
phospWhoiB = nan(dimWhoi);
phospWhoiC = nan(dimWhoi);
phospWhoiD = nan(dimWhoi);
phospWhoiE = nan(dimWhoi);
phospWhoiF = nan(dimWhoi);
phospWhoiG = nan(dimWhoi);
phospWhoiH = nan(dimWhoi);
silicateWhoiA = nan(dimWhoi);
silicateWhoiB = nan(dimWhoi);
silicateWhoiC = nan(dimWhoi);
silicateWhoiD = nan(dimWhoi);
silicateWhoiE = nan(dimWhoi);
silicateWhoiF = nan(dimWhoi);
silicateWhoiG = nan(dimWhoi);
silicateWhoiH = nan(dimWhoi);
no3no2WhoiA = nan(dimWhoi);
no3no2WhoiB = nan(dimWhoi);
no3no2WhoiC = nan(dimWhoi);
no3no2WhoiD = nan(dimWhoi);
no3no2WhoiE = nan(dimWhoi);
no3no2WhoiF = nan(dimWhoi);
no3no2WhoiG = nan(dimWhoi);
no3no2WhoiH = nan(dimWhoi);
nh4WhoiA = nan(dimWhoi);
nh4WhoiB = nan(dimWhoi);
nh4WhoiC = nan(dimWhoi);
nh4WhoiD = nan(dimWhoi);
nh4WhoiE = nan(dimWhoi);
nh4WhoiF = nan(dimWhoi);
nh4WhoiG = nan(dimWhoi);
nh4WhoiH = nan(dimWhoi);
stationUcsbA = nan(dimUcsb);
stationUcsbB = nan(dimUcsb);
stationUcsbC = nan(dimUcsb);
stationUcsbD = nan(dimUcsb);
stationUcsbE = nan(dimUcsb);
stationUcsbF = nan(dimUcsb);
stationUcsbG = nan(dimUcsb);
stationUcsbH = nan(dimUcsb);
phospUcsbA = nan(dimUcsb);
phospUcsbB = nan(dimUcsb);
phospUcsbC = nan(dimUcsb);
phospUcsbD = nan(dimUcsb);
phospUcsbE = nan(dimUcsb);
phospUcsbF = nan(dimUcsb);
phospUcsbG = nan(dimUcsb);
phospUcsbH = nan(dimUcsb);
silicateUcsbA = nan(dimUcsb);
silicateUcsbB = nan(dimUcsb);
silicateUcsbC = nan(dimUcsb);
silicateUcsbD = nan(dimUcsb);
silicateUcsbE = nan(dimUcsb);
silicateUcsbF = nan(dimUcsb);
silicateUcsbG = nan(dimUcsb);
silicateUcsbH = nan(dimUcsb);
no3no2UcsbA = nan(dimUcsb);
no3no2UcsbB = nan(dimUcsb);
no3no2UcsbC = nan(dimUcsb);
no3no2UcsbD = nan(dimUcsb);
no3no2UcsbE = nan(dimUcsb);
no3no2UcsbF = nan(dimUcsb);
no3no2UcsbG = nan(dimUcsb);
no3no2UcsbH = nan(dimUcsb);
nh4UcsbA = nan(dimUcsb);
nh4UcsbB = nan(dimUcsb);
nh4UcsbC = nan(dimUcsb);
nh4UcsbD = nan(dimUcsb);
nh4UcsbE = nan(dimUcsb);
nh4UcsbF = nan(dimUcsb);
nh4UcsbG = nan(dimUcsb);
nh4UcsbH = nan(dimUcsb);

% make empty vector for marking contaminated samples
% contamUcsbA = nan(dimUcsb);
% contamUcsbB = nan(dimUcsb);
% contamUcsbC = nan(dimUcsb);
% contamUcsbD = nan(dimUcsb);
% contamUcsbE = nan(dimUcsb);
% contamUcsbF = nan(dimUcsb);
% contamUcsbG = nan(dimUcsb);
% contamUcsbH = nan(dimUcsb);

% store data for each depth class
  % A = 1-11
  % B = 20-27
  % C = 50-77
  % D = 100-154
  % E = 186-204
  % F = 260-466
  % G = 497-537
  % H = 604-2030
for i = 1:numWhoi
    if (press(i) >= 1) && (press(i) <= 11)
        stationWhoiA(i) = station(i);
        phospWhoiA(i) = phosp(i);
        silicateWhoiA(i) = silicate(i);
        no3no2WhoiA(i) = no3no2(i);
        nh4WhoiA(i) = nh4(i);
    end
    if (press(i) >= 20) && (press(i) <= 27)
        stationWhoiB(i) = station(i);
        phospWhoiB(i) = phosp(i);
        silicateWhoiB(i) = silicate(i);
        no3no2WhoiB(i) = no3no2(i);
        nh4WhoiB(i) = nh4(i);
    end
    if (press(i) >= 50) && (press(i) <= 77)
        stationWhoiC(i) = station(i);
        phospWhoiC(i) = phosp(i);
        silicateWhoiC(i) = silicate(i);
        no3no2WhoiC(i) = no3no2(i);
        nh4WhoiC(i) = nh4(i);
    end
    if (press(i) >= 100) && (press(i) <= 154)
        stationWhoiD(i) = station(i);
        phospWhoiD(i) = phosp(i);
        silicateWhoiD(i) = silicate(i);
        no3no2WhoiD(i) = no3no2(i);
        nh4WhoiD(i) = nh4(i);
    end
    if (press(i) >= 186) && (press(i) <= 204)
        stationWhoiE(i) = station(i);
        phospWhoiE(i) = phosp(i);
        silicateWhoiE(i) = silicate(i);
        no3no2WhoiE(i) = no3no2(i);
        nh4WhoiE(i) = nh4(i);
    end
    if (press(i) >= 260) && (press(i) <= 466)
        stationWhoiF(i) = station(i);
        phospWhoiF(i) = phosp(i);
        silicateWhoiF(i) = silicate(i);
        no3no2WhoiF(i) = no3no2(i);
        nh4WhoiF(i) = nh4(i);
    end
    if (press(i) >= 497) && (press(i) <= 537)
        stationWhoiG(i) = station(i);
        phospWhoiG(i) = phosp(i);
        silicateWhoiG(i) = silicate(i);
        no3no2WhoiG(i) = no3no2(i);
        nh4WhoiG(i) = nh4(i);
    end
    if (press(i) >= 604) && (press(i) <= 2030)
        stationWhoiH(i) = station(i);
        phospWhoiH(i) = phosp(i);
        silicateWhoiH(i) = silicate(i);
        no3no2WhoiH(i) = no3no2(i);
        nh4WhoiH(i) = nh4(i);
    end
end
for i = 1:numUcsb
    if (pressU(i) >= 1) && (pressU(i) <= 11)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbA(i) = stationU(i);
            phospUcsbA(i) = phospU(i);
            silicateUcsbA(i) = silicateU(i);
            no3no2UcsbA(i) = no3no2U(i);
            nh4UcsbA(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 20) && (pressU(i) <= 27)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbB(i) = stationU(i);
            phospUcsbB(i) = phospU(i);
            silicateUcsbB(i) = silicateU(i);
            no3no2UcsbB(i) = no3no2U(i);
            nh4UcsbB(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 50) && (pressU(i) <= 77)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbC(i) = stationU(i);
            phospUcsbC(i) = phospU(i);
            silicateUcsbC(i) = silicateU(i);
            no3no2UcsbC(i) = no3no2U(i);
            nh4UcsbC(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 100) && (pressU(i) <= 154)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbD(i) = stationU(i);
            phospUcsbD(i) = phospU(i);
            silicateUcsbD(i) = silicateU(i);
            no3no2UcsbD(i) = no3no2U(i);
            nh4UcsbD(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 186) && (pressU(i) <= 204)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbE(i) = stationU(i);
            phospUcsbE(i) = phospU(i);
            silicateUcsbE(i) = silicateU(i);
            no3no2UcsbE(i) = no3no2U(i);
            nh4UcsbE(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 260) && (pressU(i) <= 466)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbF(i) = stationU(i);
            phospUcsbF(i) = phospU(i);
            silicateUcsbF(i) = silicateU(i);
            no3no2UcsbF(i) = no3no2U(i);
            nh4UcsbF(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 497) && (pressU(i) <= 537)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbG(i) = stationU(i);
            phospUcsbG(i) = phospU(i);
            silicateUcsbG(i) = silicateU(i);
            no3no2UcsbG(i) = no3no2U(i);
            nh4UcsbG(i) = nh4U(i);
        end
    end
    if (pressU(i) >= 604) && (pressU(i) <= 2030)
        if (sum(nut_idU(i) == contamList) == 0)
            stationUcsbH(i) = stationU(i);
            phospUcsbH(i) = phospU(i);
            silicateUcsbH(i) = silicateU(i);
            no3no2UcsbH(i) = no3no2U(i);
            nh4UcsbH(i) = nh4U(i);
        end
    end
end

figure;
hold on;
plot(stationWhoiA,phospWhoiA,'ks');
plot(stationWhoiA,silicateWhoiA,'bs');
plot(stationWhoiA,no3no2WhoiA,'rs');
plot(stationWhoiA,nh4WhoiA,'gs');
plot(stationUcsbA,phospUcsbA,'ko');
%plot(stationUcsbA,silicateUcsbA,'bo');
plot(stationUcsbA,no3no2UcsbA,'ro');
plot(stationUcsbA,nh4UcsbA,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 1-11 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthAcmp','epsc');

figure;
hold on;
plot(stationWhoiA,phospWhoiA,'ks');
plot(stationUcsbA,phospUcsbA,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 1-11 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthAcmpPho','epsc');

figure;
hold on;
plot(stationWhoiA,silicateWhoiA,'bs');
plot(stationUcsbA,silicateUcsbA,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 1-11 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthAcmpSil','epsc');

figure;
hold on;
plot(stationWhoiA,no3no2WhoiA,'rs');
plot(stationUcsbA,no3no2UcsbA,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 1-11 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthAcmpNit','epsc');

figure;
hold on;
plot(stationWhoiA,nh4WhoiA,'gs');
plot(stationUcsbA,nh4UcsbA,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 1-11 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthAcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiB,phospWhoiB,'ks');
plot(stationWhoiB,silicateWhoiB,'bs');
plot(stationWhoiB,no3no2WhoiB,'rs');
plot(stationWhoiB,nh4WhoiB,'gs');
plot(stationUcsbB,phospUcsbB,'ko');
%plot(stationUcsbB,silicateUcsbB,'bo');
plot(stationUcsbB,no3no2UcsbB,'ro');
plot(stationUcsbB,nh4UcsbB,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 20-27 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthBcmp','epsc');

figure;
hold on;
plot(stationWhoiB,phospWhoiB,'ks');
plot(stationUcsbB,phospUcsbB,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 20-27 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthBcmpPho','epsc');

figure;
hold on;
plot(stationWhoiB,silicateWhoiB,'bs');
plot(stationUcsbB,silicateUcsbB,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 20-27 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthBcmpSil','epsc');

figure;
hold on;
plot(stationWhoiB,no3no2WhoiB,'rs');
plot(stationUcsbB,no3no2UcsbB,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 20-27 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthBcmpNit','epsc');

figure;
hold on;
plot(stationWhoiB,nh4WhoiB,'gs');
plot(stationUcsbB,nh4UcsbB,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 20-27 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthBcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiC,phospWhoiC,'ks');
plot(stationWhoiC,silicateWhoiC,'bs');
plot(stationWhoiC,no3no2WhoiC,'rs');
plot(stationWhoiC,nh4WhoiC,'gs');
plot(stationUcsbC,phospUcsbC,'ko');
%plot(stationUcsbC,silicateUcsbC,'bo');
plot(stationUcsbC,no3no2UcsbC,'ro');
plot(stationUcsbC,nh4UcsbC,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 50-77 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthCcmp','epsc');

figure;
hold on;
plot(stationWhoiC,phospWhoiC,'ks');
plot(stationUcsbC,phospUcsbC,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 50-77 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthCcmpPho','epsc');

figure;
hold on;
plot(stationWhoiC,silicateWhoiC,'bs');
plot(stationUcsbC,silicateUcsbC,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 50-77 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthCcmpSil','epsc');

figure;
hold on;
plot(stationWhoiC,no3no2WhoiC,'rs');
plot(stationUcsbC,no3no2UcsbC,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 50-77 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthCcmpNit','epsc');

figure;
hold on;
plot(stationWhoiC,nh4WhoiC,'gs');
plot(stationUcsbC,nh4UcsbC,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 50-77 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthCcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiD,phospWhoiD,'ks');
plot(stationWhoiD,silicateWhoiD,'bs');
plot(stationWhoiD,no3no2WhoiD,'rs');
plot(stationWhoiD,nh4WhoiD,'gs');
plot(stationUcsbD,phospUcsbD,'ko');
%plot(stationUcsbD,silicateUcsbD,'bo');
plot(stationUcsbD,no3no2UcsbD,'ro');
plot(stationUcsbD,nh4UcsbD,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 100-154 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthDcmp','epsc');

figure;
hold on;
plot(stationWhoiD,phospWhoiD,'ks');
plot(stationUcsbD,phospUcsbD,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 100-154 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthDcmpPho','epsc');

figure;
hold on;
plot(stationWhoiD,silicateWhoiD,'bs');
plot(stationUcsbD,silicateUcsbD,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 100-154 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthDcmpSil','epsc');

figure;
hold on;
plot(stationWhoiD,no3no2WhoiD,'rs');
plot(stationUcsbD,no3no2UcsbD,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 100-154 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthDcmpNit','epsc');

figure;
hold on;
plot(stationWhoiD,nh4WhoiD,'gs');
plot(stationUcsbD,nh4UcsbD,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 100-154 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthDcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiE,phospWhoiE,'ks');
plot(stationWhoiE,silicateWhoiE,'bs');
plot(stationWhoiE,no3no2WhoiE,'rs');
plot(stationWhoiE,nh4WhoiE,'gs');
plot(stationUcsbE,phospUcsbE,'ko');
%plot(stationUcsbE,silicateUcsbE,'bo');
plot(stationUcsbE,no3no2UcsbE,'ro');
plot(stationUcsbE,nh4UcsbE,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 186-204 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthEcmp','epsc');

figure;
hold on;
plot(stationWhoiE,phospWhoiE,'ks');
plot(stationUcsbE,phospUcsbE,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 186-204 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthEcmpPho','epsc');

figure;
hold on;
plot(stationWhoiE,silicateWhoiE,'bs');
plot(stationUcsbE,silicateUcsbE,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 186-204 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthEcmpSil','epsc');

figure;
hold on;
plot(stationWhoiE,no3no2WhoiE,'rs');
plot(stationUcsbE,no3no2UcsbE,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 186-204 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthEcmpNit','epsc');

figure;
hold on;
plot(stationWhoiE,nh4WhoiE,'gs');
plot(stationUcsbE,nh4UcsbE,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 186-204 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthEcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiF,phospWhoiF,'ks');
plot(stationWhoiF,silicateWhoiF,'bs');
plot(stationWhoiF,no3no2WhoiF,'rs');
plot(stationWhoiF,nh4WhoiF,'gs');
plot(stationUcsbF,phospUcsbF,'ko');
%plot(stationUcsbF,silicateUcsbF,'bo');
plot(stationUcsbF,no3no2UcsbF,'ro');
plot(stationUcsbF,nh4UcsbF,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 260-466 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthFcmp','epsc');

figure;
hold on;
plot(stationWhoiF,phospWhoiF,'ks');
plot(stationUcsbF,phospUcsbF,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 260-466 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthFcmpPho','epsc');

figure;
hold on;
plot(stationWhoiF,silicateWhoiF,'bs');
plot(stationUcsbF,silicateUcsbF,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 260-466 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthFcmpSil','epsc');

figure;
hold on;
plot(stationWhoiF,no3no2WhoiF,'rs');
plot(stationUcsbF,no3no2UcsbF,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 260-466 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthFcmpNit','epsc');

figure;
hold on;
plot(stationWhoiF,nh4WhoiF,'gs');
plot(stationUcsbF,nh4UcsbF,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 260-466 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthFcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiG,phospWhoiG,'ks');
plot(stationWhoiG,silicateWhoiG,'bs');
plot(stationWhoiG,no3no2WhoiG,'rs');
plot(stationWhoiG,nh4WhoiG,'gs');
plot(stationUcsbG,phospUcsbG,'ko');
%plot(stationUcsbG,silicateUcsbG,'bo');
plot(stationUcsbG,no3no2UcsbG,'ro');
plot(stationUcsbG,nh4UcsbG,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 497-537 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthGcmp','epsc');

figure;
hold on;
plot(stationWhoiG,phospWhoiG,'ks');
plot(stationUcsbG,phospUcsbG,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 497-537 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthGcmpPho','epsc');

figure;
hold on;
plot(stationWhoiG,silicateWhoiG,'bs');
plot(stationUcsbG,silicateUcsbG,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 497-537 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthGcmpSil','epsc');

figure;
hold on;
plot(stationWhoiG,no3no2WhoiG,'rs');
plot(stationUcsbG,no3no2UcsbG,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 497-537 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthGcmpNit','epsc');

figure;
hold on;
plot(stationWhoiG,nh4WhoiG,'gs');
plot(stationUcsbG,nh4UcsbG,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 497-537 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthGcmpAmm','epsc');

figure;
hold on;
plot(stationWhoiH,phospWhoiH,'ks');
plot(stationWhoiH,silicateWhoiH,'bs');
plot(stationWhoiH,no3no2WhoiH,'rs');
plot(stationWhoiH,nh4WhoiH,'gs');
plot(stationUcsbH,phospUcsbH,'ko');
%plot(stationUcsbH,silicateUcsbH,'bo');
plot(stationUcsbH,no3no2UcsbH,'ro');
plot(stationUcsbH,nh4UcsbH,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 604-2030 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','WHOI Silicate','WHOI Nitrate+Nitrite','WHOI Ammonium','UCSB Phosphate','UCSB Nitrate+Nitrite','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthHcmp','epsc');

figure;
hold on;
plot(stationWhoiH,phospWhoiH,'ks');
plot(stationUcsbH,phospUcsbH,'ko');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 604-2030 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Phosphate','UCSB Phosphate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthHcmpPho','epsc');

figure;
hold on;
plot(stationWhoiH,silicateWhoiH,'bs');
plot(stationUcsbH,silicateUcsbH,'bo');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 604-2030 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Silicate','UCSB Silicate','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthHcmpSil','epsc');

figure;
hold on;
plot(stationWhoiH,no3no2WhoiH,'rs');
plot(stationUcsbH,no3no2UcsbH,'ro');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 604-2030 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Nitrate+Nitrite','UCSB Nitrate+Nitrite','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthHcmpNit','epsc');

figure;
hold on;
plot(stationWhoiH,nh4WhoiH,'gs');
plot(stationUcsbH,nh4UcsbH,'go');
px = xlabel('Station number');
set(px,'FontSize',14,'Interpreter','none');
py = ylabel('Nutrient conc. (uM)');
set(py,'FontSize',14,'Interpreter','none');
pt = title('Depth window 604-2030 m');
set(pt,'FontSize',14,'Interpreter','none');
set(gca,'FontSize',12);
legend('WHOI Ammonium','UCSB Ammonium','Location','EastOutside');
axis([0 210 get(gca,'YLim')]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [1 1 15 5]);
saveas(gca,'depthHcmpAmm','epsc');

close all;

%tilefigs([2 4],0);




