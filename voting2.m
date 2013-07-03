function voteCount = voting2(imagePointFv,worldPointFv,nFvSize,maxMatchingThreshold)


%%Unit Test Input Values 
%%

% imagePointFv = [   101.275782 98.740289 116.715536 85.678396 195.266239 51.212130 115.245258 86.771466 192.806449 51.865485 167.300983 59.772512 ];
% 
% worldPointFv = [   105.397093 94.879277 123.118189 81.222767 238.287538 41.966106 116.813648 85.606436 226.085494 44.231055 193.543733 51.667909  ];
% 
% nFvSize = size(imagePointFv,2);
% 
% maxMatchingThreshold = 0.15*100;
%%


voteCount = zeros(1,nFvSize/2);
voteIndice = zeros(1,nFvSize/2);
imagePointHitCount = zeros(1,nFvSize/2) ; 
worldPointHitCount = zeros(1,nFvSize/2) ; 
voteDiff = zeros(1,nFvSize/2);

imagePointFv = reshape(imagePointFv,2,nFvSize/2)';
worldPointFv = reshape(worldPointFv,2,nFvSize/2)';

for k = 1:nFvSize/2 % For each element of image point
    
    % Initial guess values for prev difference
    prevDiff = 100;
    matchIndice = 0;
    
%     imagePtDistmax = repmat(imagePointFv(k,:),size(worldPointFv,1),1); 
%     differenceMatrix = sqrt( sum ( (imagePtDistmax - worldPointFv).^2 ,2 ) ) ;
%     
%     [minDiff Indices] = sort(differenceMatrix');
%     
%     mindDiff = (minDiff < 25);
%     
%     comp = mindDiff .* Indices; 
    % For each element of world point
    for l = 1:nFvSize/2
        
        % Find difference in absolute value
        subVec1 = sort(imagePointFv(k,:) )  ;
        subVec2 = sort(worldPointFv (l,:) ) ;
        diff = sqrt( sum ((subVec1 - subVec2).^2 ) )  ;
        % Compare difee with previous distance and
        % primary threshold
        
        
        
        if( diff < maxMatchingThreshold && diff < prevDiff )
            prevDiff = diff;
            matchIndice = l;
            imagePointHitCount(1,k) = imagePointHitCount(1,k)+ 1 ;
        end
        
    end
    % Save the indice that looks like a match
    voteIndice(1,k) = matchIndice;
    voteDiff(1,k) = prevDiff;
end

% % For 5 points run from 1 to 4 eg. [1 2 3 2 4]
% % Test

% voteIndice = [1 2 3 2 5 1];
% voteDiff = [0.3 0.2 0.1 0.25 0.3 0.1];
% nFvSize = 12; 
for k = 1:(nFvSize/2)
    % Run from next point to k till end of vector
    if(voteIndice(1,k) ~= 0 )
        
        for l = 1:nFvSize/2
      
            % Indice same or non zero
            if( (voteIndice(1,k) ==  voteIndice(1,l)) )
                
            
                    worldPointHitCount(1,k)= worldPointHitCount(1,k) + 1;
              
                
            end
        end
    end
end

for k = 1:(nFvSize/2)

    if(voteIndice(1,k) ~= 0 && imagePointHitCount(1,k)<3)
    %if(voteIndice(1,k) ~= 0 )
        voteCount(1,k) = 1;
    end

end




voteCount = sum(voteCount);

end