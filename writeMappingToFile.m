function writeMappingToFile ( fileName , indexMapping);




if nargin ~=2 
    disp('WriteToFile : Input Missing');
    fileName = 'Default.txt';
    indexMapping = zeros(5,5,5); 
    gain = 100; 
end

fileID = fopen(fileName,'w');

for i = 1: size(indexMapping,1)
    fprintf(fileID,'\n ID : %d ',indexMapping(i,1,1));
    fprintf(fileID,' %d',indexMapping(i,2:end,1));
    fprintf(fileID,'\n ID : %d ',indexMapping(i,1,2));
    fprintf(fileID,' %f',indexMapping(i,2:end,2));
end
%% Closing the file
fclose(fileID);

end