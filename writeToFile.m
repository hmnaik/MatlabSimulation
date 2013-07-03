function writeToFile(fileName,fvec,gain)

if nargin ~=3 
    disp('WriteToFile : Input Missing');
    fileName = 'Default.txt';
    fvec = zeros(5); 
    gain = 100; 
end


%% Open the file

fileID = fopen(fileName,'w');
for i = 1: size(fvec,1)
    fprintf(fileID,'\n ID : %d \n',fvec(i,1));
    fprintf(fileID,'%f ',fvec(i,2:end).*gain);
    % fprintf(fileID,'\n');
end

%% Closing the file
fclose(fileID);

end