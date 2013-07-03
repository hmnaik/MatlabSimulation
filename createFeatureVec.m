function [featureVec indexMapping] = createFeatureVec(points,nbrPoints)


%% Test input 
% points = [ 78.439667 75.640632 63.768562 38.681027 ;
% 32.834875 27.699448 26.576570 25.527643 ;
% 19.378413 127.486519 96.431609 81.296319 ;
% 49.313095 41.860039 35.313061 2.334]; 
% % points = points'; 
% 
% nbrPoints = 4 ; 

%%

m = size(points,1);
n = size(points,2);

% e.g. if we have 5 points = 1 fv point + 4 neighbour points 
% So from 5 points we have 4 distances and 12 ratios ( 4 * (4-1) )
% Total size of feature vector = 1 (Point Id) + No of Ratios = 13 
fvecPoints = zeros(m,(nbrPoints*(nbrPoints-1)+1));
distanceIndexUsed = zeros ( m , nbrPoints+1 ); 
selectedDistances = zeros ( m , nbrPoints+1 );

for i = 1:m
    fv = distances( points , i );
    [fv Ind] = sort( fv );
    
    selectedPoints = zeros(1,nbrPoints);
    selectedPointIndices = zeros(1,nbrPoints);
    for j = 1:nbrPoints
        %Start selections from second value as first is always 0
        selectedPoints(1,j) = fv(1,j+1);
        selectedPointIndices(1,j) = Ind(1,j+1);
    end
    
    % Sending distances of closest neighbours
    fvec = calculateFeatureVec(selectedPoints);
    fvecPoints(i,:) = [points(i,1) fvec];
    distanceIndexUsed(i,1) = points(i,1);
    selectedDistances(i,1) = points(i,1);
    for l = 1:size(selectedPointIndices,2)
        distanceIndexUsed(i,l+1) = points(selectedPointIndices(1,l),1);
        selectedDistances(i,l+1) = selectedPoints(1,l);
    end
    
end

featureVec = fvecPoints; 
indexMapping(:,:,1) = distanceIndexUsed; 
indexMapping(:,:,2) = selectedDistances; 

end