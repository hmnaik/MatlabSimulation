function trueMatch = successCheck(matchingPair)

%% Unit test data

% matchingPair = [1 2 ; 1 1 ; 2 2 ; 2 3 ; 2 4 ; 2 5 ; 3 3 ; 3 4 ; 3 6 ; 4 3] ;

%%

trueMatch = 0;
loopSize = size(matchingPair,1);
for i = 1: loopSize
    
    element1 = matchingPair(i,1);
    element2 = matchingPair(i,2);
    if( element1 == element2 )
        trueMatch = trueMatch+1;
    end
    
    
end
end