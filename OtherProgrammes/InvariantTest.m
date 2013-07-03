

% Concept for

clear all;
%% 94, 102, 90, 2, 37, 86, 18, 13 , 99 
worldPoints = [818.44 -827.883 -283.548;
    590.426 -840.464 -323.705;
    437.926 -841.663 -329.072;
    523.651 -836.929 -230.627;
    1062.017 -898.091 -41.517;
    1142.266  -928.151    59.169;
    488.928  -909.912   203.292;
    561.077  -916.815    42.778;
    224.112  -727.022   118.069];

%% 94, 102, 90, 2, 37, 86, 18, 13, 99  : img1
imagePoints1 = [1497.4780 2228.3221;
    892.3866 2307.6093;
    492.7675 2305.4482;
    756.0236 2061.0209;
    2136.1668 1603.1905;
    2339.4383  1349.4862;
    786.7989  1001.2055;
    897.6987  1346.4561;
    294.9422  1337.2312];
%% 94, 102, 90, 2, 37, 86, 18 , 13 , 99 : img2
imagePoints2 = [1684.1091 2234.1743 ;
    994.5058 2302.7469;
    539.1742 2296.5774;
    856.6375 2052.7367;
    2370.7135 1569.5414;
    2567.9662  1320.8953;
    963.0740  1038.1984;
    1061.7353  1322.0305;
    411.9256  1449.5294];
%% 94, 102, 90, 2, 37, 86, 18, 13,99  : img3
imagePoints3 = [1803.8206  1963.8260 ;
    987.9191  2055.1169;
    440.3741  2070.6791;
    821.7118  1817.6350;
    2523.8388  1251.7407;
    2708.4770  1008.0012;
    938.2894   849.5158;
    1053.0140  1072.6417;
    319.2856  1362.0257];
%% 94, 102, 90, 2, 37, 86, 18 , 13,99    : img8
imagePoints4 = [2971.6472  1682.6667  ;
    2909.9959  2090.7567;
    2794.6897  2404.6946;
    2627.2131  2100.0415;
    2705.5192  1032.1004;
    2594.4080   818.1838;
    1627.5179  1493.4602;
    2082.8310  1563.4787;
    1380.3015  2359.4973];


m = size(worldPoints,1);
n = size(worldPoints,1);

worldDistances = zeros(m,m);
imageDistances1 = zeros(m,m);
imageDistances2 = zeros(m,m);
imageDistances3 = zeros(m,m);
imageDistances4 = zeros(m,m);

for i = 1:m
    for j = 1:n
        worldDistances(i,j) = sqrt( sum( (worldPoints(i,:) - worldPoints(j,:)).^2 ) ) ;
        imageDistances1(i,j) = sqrt( sum( (imagePoints1(i,:) - imagePoints1(j,:)).^2 ) );
        imageDistances2(i,j) = sqrt( sum( (imagePoints2(i,:) - imagePoints2(j,:)).^2 ) );
        imageDistances3(i,j) = sqrt( sum( (imagePoints3(i,:) - imagePoints3(j,:)).^2 ) );
        imageDistances4(i,j) = sqrt( sum( (imagePoints4(i,:) - imagePoints4(j,:)).^2 ) );
    end
    
end

disp('Distance matrix of world points');
worldDistances
% worldDistances = sort(worldDistances,2);
disp('Distance matrix of 1st image points');
imageDistances1

disp('Distance matrix of 2nd image points');
imageDistances2

disp('Distance matrix of 3rd image points');
imageDistances3

disp('Distance matrix of 4th image points');
imageDistances4


% Two invariant for each point
% For point 1 in world
% Inv1 = Dst(1,2)/Dst(1,3)
% Inv2 = Dst(1,3)/Dst(1,4)

for i = 1:m
    for j = 1:2

        
        if(i < round(m/2))
            worldPtFv(i,j) = worldDistances(i,i+j)/worldDistances(i,i+j+1);
            img1PtFv(i,j)  = imageDistances1(i,i+j)/imageDistances1(i,i+j+1);
            img2PtFv(i,j)  = imageDistances2(i,i+j)/imageDistances2(i,i+j+1);
            img3PtFv(i,j)  = imageDistances3(i,i+j)/imageDistances3(i,i+j+1);
            img4PtFv(i,j)  = imageDistances4(i,i+j)/imageDistances4(i,i+j+1);
        elseif ( i >= round(m/2))
            worldPtFv(i,j) = worldDistances(i,i-j)/worldDistances(i,i-j-1);
            img1PtFv(i,j)  = imageDistances1(i,i-j)/imageDistances1(i,i-j-1);
            img2PtFv(i,j)  = imageDistances2(i,i-j)/imageDistances2(i,i-j-1);
            img3PtFv(i,j)  = imageDistances3(i,i-j)/imageDistances3(i,i-j-1);
            img4PtFv(i,j)  = imageDistances4(i,i-j)/imageDistances4(i,i-j-1);
        end
    end
end


disp('Feature vector for 4 points world');
worldPtFv
disp('Feature vector for 4 points img1 ');
img1PtFv
disp('Feature vector for 4 points img2 ');
img2PtFv
disp('Feature vector for 4 points img3 ');
img3PtFv
disp('Feature vector for 4 points img4 ');
img4PtFv


diff1 = worldPtFv - img1PtFv;
diff2 = worldPtFv - img2PtFv;
diff3 = worldPtFv - img3PtFv;
diff4 = worldPtFv - img4PtFv;





