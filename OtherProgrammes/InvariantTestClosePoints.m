

% Concept for 

clear all;
%% 94, 102, 90, 2, 37, 86, 18 
worldPoints = [818.44 -827.883 -283.548;
               590.426 -840.464 -323.705; 
               437.926 -841.663 -329.072;
               523.651 -836.929 -230.627;
               1062.017 -898.091 -41.517;
               1142.266  -928.151    59.169; 
               488.928  -909.912   203.292];
           
%% 94, 102, 90, 2, 37, 86, 18          
imagePoints1 = [1497.4780 2228.3221; 
                892.3866 2307.6093;
                492.7675 2305.4482;
                756.0236 2061.0209;
                2136.1668 1603.1905;
                2339.4383  1349.4862;
                786.7989  1001.2055];
%% 94, 102, 90, 2, 37, 86, 18 
imagePoints2 = [1684.1091 2234.1743 ;
                994.5058 2302.7469;
                539.1742 2296.5774;
                856.6375 2052.7367;
                2370.7135 1569.5414;
                2567.9662  1320.8953;
                963.0740  1038.1984]; 
%% 94, 102, 90, 2, 37, 86, 18       
imagePoints3 = [1803.8206  1963.8260 ;
                987.9191  2055.1169;
                440.3741  2070.6791;
                821.7118  1817.6350;
                2523.8388  1251.7407;
                2708.4770  1008.0012; 
                938.2894   849.5158]; 

m = size(worldPoints,1);
n = size(worldPoints,1);

worldDistances = zeros(m,m);
imageDistances1 = zeros(m,m); 
imageDistances2 = zeros(m,m); 
imageDistances3 = zeros(m,m); 

for i = 1:m
    for j = 1:n 
    worldDistances(i,j) = sqrt( sum( (worldPoints(i,:) - worldPoints(j,:)).^2 ) ) ;
    imageDistances1(i,j) = sqrt( sum( (imagePoints1(i,:) - imagePoints1(j,:)).^2 ) ); 
    imageDistances2(i,j) = sqrt( sum( (imagePoints2(i,:) - imagePoints2(j,:)).^2 ) ); 
    imageDistances3(i,j) = sqrt( sum( (imagePoints3(i,:) - imagePoints3(j,:)).^2 ) ); 
    end
    
end

disp('Distance matrix of world points'); 
worldDistances ; 

disp('Distance matrix of 1st image points');
imageDistances1 ;  

disp('Distance matrix of 2nd image points');
imageDistances2 ;  

disp('Distance matrix of 3rd image points');
imageDistances3 ; 

%% Create a scaling factor 
disp('Scaling factor =  world distances/image 1 distances ');
ratio_world_img1 =  worldDistances ./ imageDistances1 ; 
ratio_img1_world =   imageDistances1 ./ worldDistances ; 
u1 = triu(ratio_img1_world, 1);

disp('Scaling factor =  world distances/image 2 distances ');
ratio_world_img2 =  worldDistances ./ imageDistances2 ; 
ratio_img2_world =   imageDistances2 ./ worldDistances  ; 
u2 = triu(ratio_img2_world, 1);

disp('Scaling factor =  world distances/image 3 distances ');
ratio_world_img3 =  worldDistances ./ imageDistances3 ; 
ratio_img3_world =   imageDistances3 ./ worldDistances  ; 
u3 = triu(ratio_img3_world, 1);

%% Average the scaling factor 

Avg = ( u1 + u2 + u3 ) ./ 3; 
validElements = ( size(worldDistances,1)*size(worldDistances,2)-size(worldDistances,1) )/ 2; 
Scale = sum ( sum ( Avg) ) / validElements; 

disp(' Average scaling factor ');
Scale 
disp(' Actual scaling matrix by elements ');
ratio_img3_world =   imageDistances3 ./ worldDistances

disp(' Calculated distance matrix for matching with world ');
image3Matching = imageDistances3 ./ Scale

disp(' Calculated distance matrix for matching with world (img1) ');
image1Matching = imageDistances1 ./ Scale

disp(' Calculated distance matrix for matching with world (img2) ');
image2Matching = imageDistances2 ./ Scale



disp(' World distance matrix ');
worldDistances

Point1FVworld =  worldDistances(1,:) ./ worldDistances


%% Conclusion : 
% Scaling might not work if we avrage over multiple images because the
% distance of the camera from the markers can be different and hence it
% will put high impace on the common scaling factor
% Hence we would need individual scaling for all images. 







