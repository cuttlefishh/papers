% ctdToCsv.m

clear;      % clears workspace variables
clc;        % clears command window
close all;  % closes any figure windows

tic;

load CTD_cal.mat;

% Transform 1x262 variables into 655000x1 variables
dateCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        dateCol((i-1)*2500+j,1) = date(i);
    end
end

latCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        latCol((i-1)*2500+j,1) = lat(i);
    end
end

lonCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        lonCol((i-1)*2500+j,1) = lon(i);
    end
end

stationCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        stationCol((i-1)*2500+j,1) = station(i);
    end
end

timeCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        timeCol((i-1)*2500+j,1) = time(i);
    end
end

% Transform 2500x262 variables into 655000x1 variables
fluCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        fluCol((i-1)*2500+j,1) = flu(j,i);
    end
end
% "NaN" negative fluorescence values
for k = 1:655000
    if fluCol(k) < 0
        fluCol(k) = NaN;
    end
end

oxCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        oxCol((i-1)*2500+j,1) = ox(j,i);
    end
end

prsCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        prsCol((i-1)*2500+j,1) = prs(j,i);
    end
end

salCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        salCol((i-1)*2500+j,1) = sal(j,i);
    end
end


t90Col = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        t90Col((i-1)*2500+j,1) = t90(j,i);
    end
end


turCol = zeros(655000,1);
for i = 1:262
    for j = 1:2500
        turCol((i-1)*2500+j,1) = tur(j,i);
    end
end
% "NaN" negative turbidity values
for k = 1:655000
    if turCol(k) < 0
        turCol(k) = NaN;
    end
end
% "NaN" turbidity data from casts [1 231:234]
for k = [1:2500 575000:585000]
    turCol(k) = NaN;
end

% Combine columns into one large table 655000x11
matrixAll = zeros(655000,11);
matrixAll(:,1) = dateCol;
matrixAll(:,2) = timeCol;
matrixAll(:,3) = stationCol;
matrixAll(:,4) = latCol;
matrixAll(:,5) = lonCol;
matrixAll(:,6) = prsCol;
matrixAll(:,7) = t90Col;
matrixAll(:,8) = salCol;
matrixAll(:,9) = oxCol;
matrixAll(:,10) = fluCol;
matrixAll(:,11) = turCol;

% Calculate size of each of 262 cast data sets (most are less than 2500 lines)
matrixNotNaN = zeros(262,1);
for i = 1:262
    flag = 0;
    for j = 15:2500 % Start at 15 meters because often no data shallower than that
        if flag ~= 1
            if isnan(matrixAll((i-1)*2500+j,6))
                fprintf(1,'cast %d: depth %d\n',i,matrixAll((i-1)*2500+j-1,6));
                matrixNotNaN(i) = j-1;
                flag = 1;
            end
        end
    end
end
                
% Make sub-matrix for deepest cast at each station (checked casts in cruise
% report)
deepList = [1 2 3 6 8 9 10 11 12 13 14 15 16 17 18 19 20 22 23 24 25 27 29 30 31 32 33 34 36 37 38 39 40 41 43 45 46 47 48 50 51 52 53 54 56 57 58 59 60 61 62 63 64 65 66 67 68 69 71 72 73 74 75 76 77 79 81 82 83 84 85 86 87 88 89 90 92 94 95 96 97 98 99 100 101 103 104 105 107 108 109 111 112 113 114 115 116 117 119 121 122 123 124 125 126 127 128 130 132 133 134 135 136 137 139 140 141 142 143 146 147 148 149 150 152 153 155 156 157 160 162 163 164 165 166 167 168 170 171 172 173 174 177 178 179 180 182 183 184 185 188 189 190 191 192 194 195 196 198 199 200 201 203 204 206 207 209 210 211 212 214 215 216 218 220 221 222 223 224 225 227 229 230 231 232 233 235 236 237 238 239 240 241 243 244 245 246 247 248 250 251 252 253 254 255 256 258];
deepDim = size(deepList);
deepNum = deepDim(2);
matrixDeep = zeros(deepNum*2500,11); % Number of lines should really be sum(matrixNotNaN(deepList))
for i = 1:deepNum
    for j = 1:matrixNotNaN(deepList(i)) % Instead of j = 1:2500, so only lines with data
        matrixDeep((i-1)*2500+j,:) = matrixAll((deepList(i)-1)*2500+j,:);
    end
end

% Make sub-matrix for my casts (B stations in cruise report)
myList = [4 7 15 16 21 26 28 35 42 44 49 55 70 78 80 91 93 102 106 110 118 120 129 131 138 144 145 154 158 161 169 175 176 186 187 193 197 202 205 208 213 217 219 226 228 234 242 247 249 258];
myDim = size(myList);
myNum = myDim(2);
matrixMy = zeros(myNum*2500,11); % Number of lines should really be sum(matrixNotNaN(myList))
for i = 1:myNum
    for j = 1:matrixNotNaN(myList(i)) % Instead of j = 1:2500, so only lines with data
        matrixMy((i-1)*2500+j,:) = matrixAll((myList(i)-1)*2500+j,:);
    end
end

% Save as CSV file
csvwrite('CTD_cal_all.csv',matrixAll);
csvwrite('CTD_cal_deep.csv',matrixDeep);
csvwrite('CTD_cal_my.csv',matrixMy);

toc;


