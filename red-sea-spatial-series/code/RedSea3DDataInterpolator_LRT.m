function [  ] = RedSea3DDataInterpolator(  )
[filename, pathname] = uigetfile( ...
    {'*.csv;','Comma Seperated Values Files (*.csv)';
    }, 'Pick a file');

tic;

if isequal(filename,0)
    disp('User selected Cancel')
else
    disp(['User selected', fullfile(pathname, filename)])
    
    file = fullfile(pathname, filename);
    [date, time, samples, latitudes, longitudes, depths, temp, salinity, oxygen, fluorescence, turbidity] = textread(file, '%s %s %s %s %s %s %s %s %s %s %s','delimiter',',');
    
    columnSize = length(samples)
    
    fid = fopen('redseanewturbiditydata.dat', 'w');
    
    parameter = salinity;
    uniqueDepths = unique(depths);
    
    depthsSize = length(uniqueDepths);
    minLong = min(str2double(longitudes));
    maxLong = max(str2double(longitudes));
    minLat = min(str2double(latitudes));
    maxLat = max(str2double(latitudes));
    step = 0.03;
    lo = minLong:step:(maxLong+step);
    sizeX = length(lo);
    la = minLat:step:(maxLat+step);
    
    sizeY = length(la);
    
    
    uniqueDepths(depthsSize) = [];
    uniqueDepths(depthsSize-1) = [];
    depthsSize = length(uniqueDepths);
    
    uniqueDepths = str2double(uniqueDepths);
    uniqueDepths = sort(uniqueDepths);
    maxDepth = max(uniqueDepths);
    depthStep = 10;
    if (maxDepth < 500)  % IS THIS MAXDEPTH FOR WHOLE DATASET OR ONE STATION?
        dp = 10:depthStep:maxDepth;
    else
        dp = 10:depthStep:500;
    end
    sizeZ = length(dp);
    sizes = [sizeX sizeY sizeZ]
    
    x = [];
    y = [];
    z = [];
    v = [];
    for j=2 : columnSize
        if(strcmp('NaN', depths{j}) == 1 || strcmp('NaN', parameter{j}) == 1)
            continue;
        end
        x = [x str2double(longitudes{j})];
        y = [y str2double(latitudes{j})];
        z = [z str2double(depths{j})];
        v = [v str2double(parameter{j})];
    end
    result = 'done with xyzv'
    F = TriScatteredInterp(x(:),y(:),z(:),v(:));  % THIS IS BUILT-IN MATLAB FUNCTION THAT DOES HEAVY LIFTING; TAMU HAVE SOMETHING BETTER
    result = 'done with triscattered'
    [qx,qy,qz] = meshgrid(lo,la,dp);
    result = 'done with meshgrid'
    %save F;
    qv = F(qx,qy,qz)
    result = 'done with interpolation'
    
    maxV = max(max(max(qv)))
    minV = min(min(min(qv)))
    
    data = uint8(((qv - (minV-0.2))./ (maxV - minV+0.2))*255);  % THIS MIGHT BE PROBLEM STEP FOR EMPTY OXYGEN
    coordinates = [minLong maxLong minLat, maxLat, step, maxDepth, depthStep, minV, maxV];
    fwrite(fid, sizes, 'uint16');
    fwrite(fid, coordinates, 'float32');
    %fwrite(fid, uniqueDepths, 'float32');
    fwrite(fid, data, 'uint8');
    fclose(fid);
end

toc;


