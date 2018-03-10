% transformLatLon.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

files = {
    'krse2011_v2_illumina'
    'krse2011_v2_my'
    'krse2011_v2_deep'
    };

for i = 1%:3
    
    fileNo = files{i};
    fileName = [fileNo,'.csv'];
    fid = fopen(fileName);
    data = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',','HeaderLines',1);
    fclose(fid);
    
    y = data{2};         % y = lat
    x = data{3};         % x = lon

    coords = [y x];      % input lat/long as 2-column matrix
    coords = coords';    % transpose matrix for matrix multiplication
    
    figure;
    hold on;
    
    plot(x,y,'kx');
    
    theta = 0.49;        % ~pi/6 seems to work
    R0 = [
        cos(theta) -sin(theta)
        sin(theta) cos(theta)
        ];
    
    newcoords = R0 * coords;
    
    newy = newcoords(1,:)+4.6;
    newx = newcoords(2,:)-43.2;
    
    outcoords = [newx' newy'];       % make new matrix with x-y translated data
    outfile = [fileNo,'_xy.csv'];
    csvwrite(outfile,outcoords);
    
    plot(newx,newy,'ro');
    
    axis([-5 45 -5 30]);
    
    grid on;
    
end

tilefigs([2 3]);
