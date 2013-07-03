function matchedPair = findMatch(worldFv, imageFv, gain , maxMatchingThreshold, maxVote,nbrPoints)

%% Unit Test Matrix Input: 
% %%
% 
% imageFv = [ 
%     33
%     47.076337 
%     52.157628
%     90.257818
%     110.793726
%     191.726510
%     212.420945 ];
% imageFv = imageFv' ; 
% worldFv = [
%     37
%     53.454327
%     56.519567
%     94.576676
%     105.734315
%     176.929878
%     187.075594 ] ;
% worldFv = worldFv' ;
% maxVote = size(worldFv,2)-2; 
% gain = 100 ; 
% maxMatchingThreshold = gain * 0.05; 
% maxVote = 


%% Input Check
%%
if nargin ~=6
    disp('findMatch: Function call error');
end

% To check if each feature vector has same elements 
if( size(worldFv,2) ~= size(imageFv,2 ) )
    disp('Feature Vector Calculation has screwed up');
    matchedPair = zeros(1);
end
%%

%% The Real Job
%%
nWorldPoints = size(worldFv,1);
nFvSize = size(worldFv,2) - 1;
nImagePoints = size(imageFv,1);
pairStart = 1;
% Default no match found assignment 
matchedPair(pairStart,:) = [ 666 666 666]; 

if(gain > 1) 
    
    imageFv = [imageFv(:,1) imageFv(:,2:end) .* gain ]; 
    worldFv = [worldFv(:,1) worldFv(:,2:end) .* gain ]; 
end



for i = 1:nImagePoints
    
    % Image point i to consider
    imagePoint = imageFv(i,:);
    
    % Save id of the point 
    imagePointID = imagePoint(1,1);
    % Save vectore from the point 
    imagePointFv = imagePoint(1,2:end);
    for j = 1:nWorldPoints
        % World point j to consider for this iteration
        worldPoint = worldFv(j,:);
        % Save ID and Vector 
        worldPointID = worldPoint(1,1);
        worldPointFv = worldPoint(1,2:end);
        
        %%Stopped sorting 
        %imagePointFv = sort(imagePointFv);
        %worldPointFv = sort(worldPointFv);
        
        % Feature matching of point Image(i) vs World(j)
        if( imagePointID == worldPointID )
         test = 1; 
        end
        voteCount = voting2(imagePointFv,worldPointFv,nFvSize,maxMatchingThreshold);
        % voteCount = voting2(imagePointFv,worldPointFv,nFvSize,maxMatchingThreshold,nbrPoints);
        
        %Test
        % voteCount = nFvSize-1; 
        if(voteCount >= maxVote)
            matchedPair(pairStart,:) = [worldPointID imagePointID voteCount];
            pairStart = pairStart +1 ; 
        end
    end
    
    
end





end