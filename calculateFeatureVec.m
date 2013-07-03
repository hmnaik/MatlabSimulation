function featureVec = calculateFeatureVec(Data)


%% Test Data for function
 %Data = [ 268.776859 299.481218 363.352446 545.971611 567.043208];
 %Data = [ 312.656361 343.639346 419.505661 612.784628 708.644481];
method = 2;

%% Methods of creating the 

if( method == 1)
    m = size(Data,2);
    % We have : (A,B) (A,C) (A,D) (A,E) (A,F)
    % Let notation [ 1 2 3 4 5] = [(A,B) (A,C) (A,D) (A,E) (A,F)]
    % What we want is = 1/{2,3,4,5} , 2/{1,2,4,5}... so on for all 5 points
    % Final vector size = (No of distances)^2 - No of distances
    % here = 5^2 - 5 = 20
    %%Create Feature vec
    % We repeat the column to make even matrix  [ 1 2 3 4 5] repeated = 5x5
    dataMatrix = repmat(Data,m,1);
    
    for i = 1:size(dataMatrix,1)
        % Swap first element of each row so that
        % 1st Column = [A B C D E ]'
        temp = dataMatrix(i,1);
        dataMatrix(i,1) = dataMatrix(i,i);
        dataMatrix(i,i) = temp;
    end
    %% Create vector to store the feature vecs
    % Size of feature vec = Distances*(Distances-1) as ratio
    divVec = zeros(size(dataMatrix,1),size(dataMatrix,1)-1 );
    
    % Divide first column with all other columns and store result
    % eg. if We have 5 distances, hence 5*(5-1) ratios.
    
    for i = 1:size(divVec,2)
        divVec(:,i) = dataMatrix(:,1) ./ dataMatrix(:,i+1);
    end
    
    
    % We want to keep each row together so that we can use it in future for
    % voting
    % This step brings rows into columns
    featureVec = divVec';
    % This step brings all columns into on single row
    featureVec = featureVec(:)';
    
    %% Sorting removed the vector identification so we dont do it
    % featureVec = sort(featureVec);
end

if( method == 2)
    
    m = size(Data,2);
    % We have : (A,B) (A,C) (A,D) (A,E) (A,F)
    % Let notation [ 1 2 3 4 5] = [(A,B) (A,C) (A,D) (A,E) (A,F)]
    % What we want is = 1/{2,3,4,5} , 2/{1,2,4,5}... so on for all 5 points
    % Final vector size = (No of distances)^2 - No of distances
    % here = 5*5 - 5 = 20
    %%Create Feature vec
    % We repeat the column to make even matrix  [ 1 2 3 4 5] repeated = 5x5
    dataMatrix = repmat(Data,m,1);
    
    fvMatrix = dataMatrix;
    divVec = zeros(1,(m*(m-1)) );
    
%     Create matrix for fv = R1/C1 , R2/C2 and so on
%     Max = [ 1/1 1/2 1/3 1/4 1/5 
%     2/1 2/2 2/3 2/4 2/5 
%     3/1 3/2 3/3 3/4 3/5 
%     4/1 4/2 4/3 4/4 4/5 
%     5/1 5/2 5/3 5/4 5/5 ];
        
    
    for i = 1:m
        fvMatrix(i,:) = dataMatrix(i,:) ./ dataMatrix(:,i)' ; 
    end    
    
    % Now across the diagonal 
    m = 1; 
    % Final vector looks like :  [ 1/2 2/1 1/3 3/1 1/4 4/1 1/5 5/1 2/3 3/2 2/4 4/2 2/5 5/2 3/4 4/3 3/5 5/3 4/5 5/4]
    for i = 1:size(dataMatrix,1)
       for j = i+1:size(dataMatrix,2)
           
           divVec(1,m) = fvMatrix(i,j) ;
           divVec(1,m+1) = fvMatrix(j,i) ;
           m = m+2;
       end
    end
   
    featureVec = divVec;
    
end

end
