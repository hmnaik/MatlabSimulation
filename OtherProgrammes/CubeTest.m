

% Concept for 

clear all;
%% 14,86,37
%%  3, 14,27, 37, 86
worldPoints = [ 183.628 10.146 0.096;
                148.028 15.316 0.110; 
                168.538 35.714 0.094;
                195.323 34.536 -51.096;
                195.335 110.698 -41.336
               ];
           
%% 3(9), 14,27,37, 86 : img1 - 18  r = 13 avg  
imagePoints1 = [ 
                1061 425;
                1117 436;
                1074 477;   
                964 438;
                944 591
                ];
% %% 3, 14,27, 37, 86 : img3 - 20 r = 15 avg 
imagePoints2 = [
                994 409;
                1061 425;
                1012 464;
                920 423;
                898 573
                ]; 
% %% 3, 14,27, 37, 86 : img4  -21     r = 15 avg
% imagePoints3 = [
%                 2453.2294  1767.8586; 
%                 2123.7590  1019.7928;
%                 2045.9641  1784.7801;
%                 1473.6471  1331.0248;
%                 1708.8833  1009.7081 
%                 ]; 
% %% 3, 14, 27, 37, 86 : img5   - 22     avg  r  = 17 
% imagePoints4 = [
%                 2652.4737  1743.0485;
%                 2515.3603  1037.8342;
%                 2302.4462  1779.4269;
%                 1847.2753  1339.9405;
%                 2129.9691  1012.4346
%                 
%                 ]; 
% %%  3, 14, 27, 37, 86 : img12  -29   avg r = 9 
% imagePoints5 = [
%                 2818.8525  2295.9468;
%                 2892.3453  1955.2670;
%                 2626.7296  2343.2555;
%                 2479.7806  2159.8418;
%                 2690.4867  1965.5803 
%                 ]; 

        
m = size(worldPoints,1);
n = size(worldPoints,1);

for i = 1:m
    for j = 1:n 
    
        
        worldDistances(i,j) = sqrt( sum( (worldPoints(i,:) - worldPoints(j,:)).^2 ) ) ;
        imageDistances1(i,j) = sqrt( sum( (imagePoints1(i,:) - imagePoints1(j,:)).^2 ) );
        imageDistances2(i,j) = sqrt( sum( (imagePoints2(i,:) - imagePoints2(j,:)).^2 ) );
        %             imageDistances3(i,j) = sqrt( sum( (imagePoints3(i,:) - imagePoints3(j,:)).^2 ) );
        %             imageDistances4(i,j) = sqrt( sum( (imagePoints4(i,:) - imagePoints4(j,:)).^2 ) );
        %             imageDistances5(i,j) = sqrt( sum( (imagePoints5(i,:) - imagePoints5(j,:)).^2 ) );
        
    end
    
end

disp('Distance matrix of world points'); 
worldDistances

disp('Distance matrix of 1st image points');
imageDistances1

disp('Distance matrix of 2nd image points');
imageDistances2  

% disp('Distance matrix of 3rd image points');
% imageDistances3 
% 
% disp('Distance matrix of 4th image points');
% imageDistances4 
% 
% disp('Distance matrix of 5th image points');
% imageDistances5 


reatio1 = imageDistances1 ./ worldDistances
reatio2 = imageDistances2 ./ worldDistances
rediusscaling1 = 5.5/3 
rediusscaling2 = 6/3 ; 

disp('Feature vector for 5 points world');
worldPtFv = worldDistances ./ 3

disp('Feature vector for 5 points img1 ');
img1PtFv(1,:) = imageDistances1(1,:) ./ 11 ; 
img1PtFv(2,:) = imageDistances1(2,:) ./ 10 ; 
img1PtFv(3,:) = imageDistances1(3,:) ./ 10 ; 
img1PtFv(4,:) = imageDistances1(4,:) ./ 11 ;
img1PtFv(5,:) = imageDistances1(5,:) ./ 11 ;
img1PtFv = img1PtFv .* 2
img1PtFv = sort(img1PtFv,2);

disp('Feature vector for 5 points img2 ');
img2PtFv(1,:) = imageDistances2(1,:) ./ 12 ; 
img2PtFv(2,:) = imageDistances2(2,:) ./ 12 ; 
img2PtFv(3,:) = imageDistances2(3,:) ./ 11 ; 
img2PtFv(4,:) = imageDistances2(4,:) ./ 11 ; 
img2PtFv(5,:) = imageDistances2(5,:) ./ 11 ;
img2PtFv = img2PtFv .* 2
img2PtFv = sort(img2PtFv,2);
% disp('Feature vector for 5 points img3 ');
% img3PtFv(1,:) = imageDistances3(1,:) ./ 24 ; 
% img3PtFv(2,:) = imageDistances3(2,:) ./ 33 ; 
% img3PtFv(3,:) = imageDistances3(3,:) ./ 33 ; 
% img3PtFv(4,:) = imageDistances3(4,:) ./ 32 ; 
% img3PtFv(5,:) = imageDistances3(5,:) ./ 33 ;
% img3PtFv = img3PtFv .* 2
%  
% disp('Feature vector for 5 points img4 ');
% img4PtFv(1,:) = imageDistances4(1,:) ./ 28 ; 
% img4PtFv(2,:) = imageDistances4(2,:) ./ 33 ; 
% img4PtFv(3,:) = imageDistances4(3,:) ./ 32 ; 
% img4PtFv(4,:) = imageDistances4(4,:) ./ 34 ; 
% img4PtFv(5,:) = imageDistances4(5,:) ./ 32 ;
% img4PtFv = img4PtFv .* 2
%  
% disp('Feature vector for 5 points img4 ');
% img5PtFv(1,:) = imageDistances5(1,:) ./ 11 ; 
% img5PtFv(2,:) = imageDistances5(2,:) ./ 17 ; 
% img5PtFv(3,:) = imageDistances5(3,:) ./ 16 ; 
% img5PtFv(4,:) = imageDistances5(4,:) ./ 18 ; 
% img5PtFv(5,:) = imageDistances5(5,:) ./ 18 ;
% img5PtFv = img5PtFv .* 2
 
difference1 = (worldPtFv - img1PtFv); 
difference2 = (worldPtFv - img1PtFv); 





