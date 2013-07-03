%% Testing stability of Invariants

%% 2 Conic Test

%%
%close all;
clear all;
%clc;
%% Test setup Initialisation

%% Camera Roatation matrix
alphaCam = 0 ; betaCam = 0 ; gammaCam = 0;
xTransCam = 0 ; yTransCam = 00 ; zTransCam = 1000;
%%

%% Rotation and Translation angles for coordinate axis
xTransWorldPlane = 0.0 ; yTransWorldPlane = 0.0 ; zTransWorldPlane = 0.0;
alphaPlane = 0 ; betaPlane = 0; gammaPlane = 0;
%%

%% Debug Oarameters
drawImages = 0;  % To draw images of not
noiseFactor = 0.5;
%%

%% Camera and Image Parameters
K = [1473 0 1200 ; 0 1474 800; 0 0 1];
imageWidth = K(1,3)*2 ;
imageHeight = K(2,3)*2 ;
%%

%% World data for Object circles
worldOrigin = [ 0 0 0 1]';
markerRadius =  6 ; % in Meters : Rad is in mm e.g. 10mm is 0.010
%%

%% Create Points
baseConicPoints = createConic(worldOrigin,markerRadius,100);
conicWorldMatrix = [1/markerRadius^2 0 0 ; 0 1/markerRadius^2 0 ; 0 0 -1] ;
%%

noOfIterations = 10000; 

for iterator = 1 : noOfIterations
    %% getCircleAt : [alpha beta gamma],[Tx Ty Tz],conicPoints , Origin
    [circlePoints(:,:,1) center(:,:,1) surfaceNormal(:,:,1)] = getCircleAt([10 0 0],[50 0 0],baseConicPoints,worldOrigin);
    [circlePoints(:,:,2) center(:,:,2) surfaceNormal(:,:,2)] = getCircleAt([0 20 0],[0 0 10],baseConicPoints,worldOrigin);
    
    
    
    %% Invariants : Distance Between Centers And Angle Between Surface
    distCenters = calculateDistance(center(:,:,1) , center(:,:,2)) ;
    gtSurfaceAngle = calculateAngle(surfaceNormal(:,:,1),surfaceNormal(:,:,2));
    %%
    
    %% Visualisation
    if(drawImages)
        figure(1);
        hold on;
        for i = 1:size(circlePoints,3)
            quiver3(center(1,:,i),center(2,:,i),center(3,:,i),surfaceNormal(1,:,i),surfaceNormal(2,:,i),surfaceNormal(3,:,i),3,'r');
            plot3(circlePoints(1,:,i),circlePoints(2,:,i),circlePoints(3,:,i));
            grid on ;
            axis equal;
        end
        hold off;
    end
    %%
    %% Random Test Data Generator 
    camAngles(:,iterator) = randi([-65 65], 3 , 1 );
    alphaCam = camAngles(1,iterator); 
    betaCam = camAngles(2,iterator); 
    gammaCam = camAngles(3,iterator); 
    
    camTrans(1,iterator) = randi([-100 100], 1 , 1 ); 
    xTransCam = camTrans(1,iterator); 
    camTrans(2,iterator) = randi([-100 100], 1 , 1 ); 
    yTransCam = camTrans(2,iterator);
    camTrans(3,iterator) = randi([500 1800], 1 , 1 ); 
    zTransCam = camTrans(3,iterator);
    
%   alphaCam = 50 ; betaCam = 23; gammaCam = 11 ; 
%   xTransCam = 58; yTransCam=53; zTransCam = 958; 
    
%   alphaCam = 61 ; betaCam = 69; gammaCam = 32 ; 
%   xTransCam = 58; yTransCam=53; zTransCam = 958; 
    %% 
    
    %% Camera Projection Matrix
    [Rx Ry Rz] = getRotationMatrix(alphaCam, betaCam, gammaCam);
    T = [ xTransCam yTransCam zTransCam]';
    cameraRotationMatrix = Rx * Ry * Rz;
    
    projSN1 = cameraRotationMatrix * surfaceNormal(:,:,1);
    projSN2 = cameraRotationMatrix * surfaceNormal(:,:,2);
    
    cameraTranslationMatrix = [ xTransCam yTransCam zTransCam]';
    P = createProjectionMatrix(K, cameraRotationMatrix , cameraTranslationMatrix );
    
    projectedCenter1 = [cameraRotationMatrix cameraTranslationMatrix] * center(:,:,1);
    projectedCenter2 = [cameraRotationMatrix cameraTranslationMatrix] * center(:,:,2);
    
    %% Project Image Points
    for i = 1:size(circlePoints,3)
        
        imagePoints = createImagePoints(P, circlePoints(:,:,i), imageWidth, imageHeight , drawImages);
        
        %% Add Noise
        n = size(imagePoints,2);
        noise = randn(1,n)*noiseFactor;
        imagePoints(1,:) = imagePoints(1,:) + noise ;
        imagePoints(2,:) = imagePoints(2,:) + noise ;
        
        
        %% Fit Ellipse and Get Conic Matrix
        [Ci fitParam] = createConicMatrix(imagePoints, drawImages );
        val2 = checkConicMatrix(Ci, imagePoints);
        
        
        %% Calculate the parameters Normals and center of backprojected circle
        [n1 n2 center1 center2 measuredRadius] = calculateNormals(Ci,markerRadius,K);
        
        %% Saving all data
        circlePointsImage(:,:,i) = imagePoints; % With Noise
        ellipseParam(:,:,i) = fitParam;
        conicMatrixImage(:,:,i) = Ci;
        detectedNormals(:,1,i) = n1 ;detectedNormals(:,2,i) = n2 ;
        detectedCenters(:,1,i) = center1 ; detectedCenters(:,2,i) = center2 ;
        calculatedRadius(:,:,i) = measuredRadius;
        
    end
    
    %% Invariants
    
    %% Invariant 1 : Angle between surface ( For 2 conic we get 4 angles : 2 are likely to be almost equal)
    surfaceAngles = getSurfaceAngles(detectedNormals(:,:,1),detectedNormals(:,:,2));
    
    %% Invariant 2 : Distance to Radius ratio (For 2 conic we get 4 distances )
    [centerVecSet distSet] = getDistance(detectedCenters(:,:,1),detectedCenters(:,:,2));
    
    % Print Data
    distCenters;
    distSet ;
    stdDivDistances(iterator) = sqrt ( sum( (distSet - distCenters).^2 ) ./ 4 );
    
    gtSurfaceAngle ; 
    surfaceAngles ;
    angle1(iterator) = calculateAngle(detectedNormals(:,1,1),detectedNormals(:,2,1) );
    angle2(iterator) = calculateAngle(detectedNormals(:,1,2),detectedNormals(:,2,2) );
    
    [ n1Key n2Key ] = solveNormalAmbiguity(gtSurfaceAngle,surfaceAngles);
    
    
    
    estimatedNormal1 = detectedNormals(:,n1Key,1);
    estimatedNormal2 = detectedNormals(:,n2Key,2);
    
    estimatedCenter1 = detectedCenters(:,n1Key,1);
    estimatedCenter2 = detectedCenters(:,n2Key,2);
    
    normalSuccess(iterator) = validateNormalEstimation(projSN1,projSN2,estimatedNormal1,estimatedNormal2);
    centerSuccess(iterator) = validateCenterEstimation(projectedCenter1,projectedCenter2,estimatedCenter1,estimatedCenter2);
    
%     dd1(iterator) = calculateDistance(projectedCenter1,detectedCenters(:,1,1));
%     dd2(iterator) = calculateDistance(projectedCenter1,detectedCenters(:,2,1));
%     dd3(iterator) = calculateDistance(projectedCenter2,detectedCenters(:,1,2));
%     dd4(iterator) = calculateDistance(projectedCenter2,detectedCenters(:,2,2));
    
    
end


% angle1mean = mean(angle1);
% stdDivangle1 = sqrt ( ( sum ( (angle1 - angle1mean).^2 ) ) ./ 1000 ) ;
% 
% 
% angle2mean = mean(angle2);
% stdDivangle2 = sqrt ( ( sum ( (angle2 - angle2mean).^2 ) ) ./ 1000 ) ;

% dd1mean = mean(dd1)
% stdDivdd1 = sqrt ( ( sum ( (dd1 - dd1mean).^2 ) ) ./ 1000 ) 
% dd2mean = mean(dd2)
% stdDivdd2 = sqrt ( ( sum ( (dd2 - dd2mean).^2 ) )./ 1000 ) 

positiveN = sum(normalSuccess)
positiveC = sum(centerSuccess)
combineResult = normalSuccess & centerSuccess; 
combineSuccess = sum(combineResult) 

maxDiv = max(stdDivDistances)
minDiv = min(stdDivDistances)


if( exist('InvarianStabilityTest.txt','file') )
    fileID = fopen('InvarianStabilityTest.txt','A');
    fprintf(fileID,'\n New Data : \r\n');
else
    fileID = fopen('InvarianStabilityTest.txt','w');

end

fprintf(fileID,'\n No of Experiments : %4f \r\n',noOfIterations);
fprintf(fileID,'\n Marker Radius : %4f \r\n',markerRadius);
fprintf(fileID,'\n Noise Factor : %4f \r\n',noiseFactor);
fprintf(fileID,'\n Angle Range : %4f to %4f \r\n', -65.0 , +65.0 );
fprintf(fileID,'\n Translation Range x - y : %4f to %4f \r\n',-100, +100);
fprintf(fileID,'\n Translation Range z : %4f to %4f \r\n',500,1800);

fprintf(fileID,'\n Positive Normal Results \r\n');
fprintf(fileID,'Normal Success : %4f \r\n',positiveN);


fprintf(fileID,'\n Positive Center Results \r\n');
fprintf(fileID,'Center Success : %4f \r\n',positiveC);

fprintf(fileID,'\n Positive Combined Results \r\n');
fprintf(fileID,'Both Success : %4f \r\n',combineSuccess);


fclose(fileID); 



