function writeMatchingHypothesisToFile(fileName, matchingData)

fileID = fopen(fileName,'w');

fprintf(fileID,'\n');
fprintf(fileID,' WorldID \t ImageID  \t Votes');
max = size(matchingData,1); 
for i = 1: max
 
    fprintf(fileID,'\n');
    if( i~=1 && matchingData(i,2) ~= matchingData(i-1,2)  )
        fprintf(fileID,'\n --------------------------------\n');
    end
    fprintf(fileID,'\t%d',matchingData(i,1));
    fprintf(fileID,'\t%d',matchingData(i,2));
    fprintf(fileID,'\t%d',matchingData(i,3));
  
 
end
%% Closing the file
fclose(fileID);

end