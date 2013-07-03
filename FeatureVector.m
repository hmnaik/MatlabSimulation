%% Importing files 

%clear all; 



%% Glob file function
imageFile = dir( 'data/image/*.txt') ; 
storageDir = 'results/';
noOfFiles = size(imageFile,1);
worldpoints = load('WorldPoints3D.txt'); 
%%





%% Setting values
nbrPoints = 7; % How many neighbours to consider
gain = 100; % How much gain to be given to distances 
% Matching theshold for 2 values 
maxMatchingThreshold = ( gain * 0.10 ); % 5% of the gain
% Voting required to select a match 
fvSize = (nbrPoints*(nbrPoints - 1)); 
%maxVote = round( fvSize * 0.80  ); % 80% of the max possible feature vector size  
% Voting scheme 2
maxVote = round( ( (fvSize/2) * 0.80  ) ); % 80% of the max possible feature vector size  

%% Begin
disp(' New Experiment');
disp(' Neighbour Points Selected');disp(nbrPoints);
disp(' gain = '); disp(gain);
disp(' Matching Threshold ='); disp(maxMatchingThreshold);
disp(' fvSize = ');disp(fvSize);
disp(' Max Initial voting = %d ');disp(maxVote);

%%

%% Creating feature vectors for world points 
disp('No of world points'); disp(size(worldpoints,1));
[fvecWorld indexMappingWorld] = createFeatureVec(worldpoints,nbrPoints);
writeToFile('results\fvecWorld.txt',fvecWorld,gain);
writeMappingToFile ( 'results\MappingIndicesWorld.txt ', indexMappingWorld);
%%

%% Operation 
for fileIter = 1 : noOfFiles
   
    % Get the file names iteratively 
    fileName = imageFile(fileIter).name; 
    
    % load file from the right path 
    image = load(strcat('data/image/',fileName) );
    
    
    
    [fvecImage indexMappingImage] = createFeatureVec(image,nbrPoints);
    matchedPair = findMatch(fvecWorld,fvecImage,gain,maxMatchingThreshold,maxVote,nbrPoints); 
    
    
    fvecFile = strcat(storageDir,'fvec',fileName);
    mappingFile = strcat(storageDir,'MappingIndices',fileName);
    matchPairFile = strcat(storageDir,'MatchPair',fileName);
    writeToFile(fvecFile,fvecImage,gain);
    writeMappingToFile ( mappingFile, indexMappingImage);
    writeMatchingHypothesisToFile(matchPairFile,matchedPair);
    
    disp(fileName); disp(size(image,1));
    disp('No of possible match'); disp(size(matchedPair,1));
    goodPair = successCheck(matchedPair)
    
end





% 
% 
% 
% %%
% 
% %% Creating feature vectors for Image points 
% 
% %%Data for image 1
% disp('No of Image 1 points'); disp(size(image1,1));
% [fvecImage1 indexMappingImage1] = createFeatureVec(image1,nbrPoints);
% matchedPair1 = findMatch(fvecWorld,fvecImage1,gain,maxMatchingThreshold,maxVote,nbrPoints); 
% disp('No of possible match'); disp(size(matchedPair1,1));
% 
% writeToFile('results\fvecImg1.txt',fvecImage1,gain);
% writeMappingToFile ( 'results\MappingIndicesImage1.txt ', indexMappingImage1);
% writeMatchingHypothesisToFile('results\matchedPair1.txt',matchedPair1);
% %%
% 
% %% Data for image 12
% disp('No of Image 12 points'); disp(size(image12,1));
% [fvecImage12 indexMappingImage12]= createFeatureVec(image12,nbrPoints);
% matchedPair12 = findMatch(fvecWorld,fvecImage12,gain,maxMatchingThreshold,maxVote,nbrPoints);
% disp('No of possible match'); disp(size(matchedPair12,1));
% 
% writeToFile('results\fvecImg12.txt',fvecImage12,gain);
% writeMappingToFile ( 'results\MappingIndicesImage12.txt ', indexMappingImage12); 
% writeMatchingHypothesisToFile('results\matchedPair12.txt',matchedPair12);
% %%
% 
% 
% %% Data for image 8
% disp('No of Image 8 points'); disp(size(image8,1));
% [fvecImage8 indexMappingImage8]= createFeatureVec(image8,nbrPoints);
% matchedPair8 = findMatch(fvecWorld,fvecImage8,gain,maxMatchingThreshold,maxVote,nbrPoints);
% disp('No of possible match'); disp(size(matchedPair8,1));
% 
% writeToFile('results\fvecImg8.txt',fvecImage8,gain);
% writeMappingToFile ( 'results\MappingIndicesImage8.txt ', indexMappingImage8); 
% writeMatchingHypothesisToFile('results\matchedPair8.txt',matchedPair8);
% %%
% 
% %% Data for image 4
% disp('No of Image 4 points'); disp(size(image4,1));
% [fvecImage4 indexMappingImage4]= createFeatureVec(image4,nbrPoints);
% matchedPair4 = findMatch(fvecWorld,fvecImage4,gain,maxMatchingThreshold,maxVote,nbrPoints);
% disp('No of possible match'); disp(size(matchedPair4,1));
% 
% writeToFile('results\fvecImg4.txt',fvecImage4,gain);
% writeMappingToFile ( 'results\MappingIndicesImage4.txt ', indexMappingImage4); 
% writeMatchingHypothesisToFile('results\matchedPair4.txt',matchedPair4);
% %%
% 
% trueMatch1 = successCheck(matchedPair1)
% trueMatch12 = successCheck(matchedPair12)
% trueMatch8 = successCheck(matchedPair8)
% trueMatch4 = successCheck(matchedPair4)


%% Image based matching 
% matchedImagePair1n12 = findMatch(fvecImage1,fvecImage12,gain,maxMatchingThreshold,maxVote,nbrPoints);
% matchedImagePair1n8 = findMatch(fvecImage1,fvecImage8,gain,maxMatchingThreshold,maxVote,nbrPoints);
% matchedImagePair12n8 = findMatch(fvecImage12,fvecImage8,gain,maxMatchingThreshold,maxVote,nbrPoints);
% trueImgPairMatch1n12 = successCheck(matchedImagePair1n12)
% trueImgPairMatch1n8 = successCheck(matchedImagePair1n8)
% trueImgPairMatch12n8 = successCheck(matchedImagePair12n8)
%%



