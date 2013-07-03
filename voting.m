function voteCount = voting(imagePointFv,worldPointFv,nFvSize,maxMatchingThreshold)


%%Unit Test Input Values 
%%

%  imagePointFv = [ 0.751822 0.812655 
%                   0.925143 1.080914 
%                   1.230534 1.330101 ];
% 
% worldPointFv = [  0.744933 0.796554 
%                   0.935194 1.069297 
%                   1.255407 1.342402 ];
% 
% nFvSize = size(imagePointFv,2);
% 
% maxMatchingThreshold = 0.03;
%%


voteCount = zeros(1,nFvSize);
voteIndice = zeros(1,nFvSize);
voteDiff = zeros(1,nFvSize);

for k = 1:nFvSize % For each element of image point
    
    % Initial guess values for prev difference
    prevDiff = 100;
    matchIndice = 0;
    % For each element of world point
    for l = 1:nFvSize
        
        % Find difference in absolute value
        diff = abs(( imagePointFv(1,k) - worldPointFv (1,l)));
        % Compare difee with previous distance and
        % primary threshold
        if( diff < maxMatchingThreshold && diff < prevDiff )
            
            prevDiff = diff;
            matchIndice = l;
            
        end
        
    end
    % Save the indice that looks like a match
    voteIndice(1,k) = matchIndice;
    voteDiff(1,k) = prevDiff;
end

% For 5 points run from 1 to 4 eg. [1 2 3 2 4]
% Test
%  voteIndice = [1 2 3 2 5 1];
%  voteDiff = [0.3 0.2 0.1 0.25 0.3 0.1];
for k = 1:(nFvSize)
    % Run from next point to k till end of vector
    if(voteIndice(1,k) ~= 0 )
        
        for l = k+1:nFvSize
            % Indice same or non zero
            if( (voteIndice(1,k) ==  voteIndice(1,l)) )
                if ( voteDiff(1,k) < voteDiff(1,l) )
                    voteIndice(1,l)= 0;
                else
                    voteIndice(1,k)= 0;
                end
            end
        end
        if (voteIndice(1,k) ~= 0)
            voteCount(1,k) = 1;
        end
    end
end

voteCount = sum(voteCount);

end