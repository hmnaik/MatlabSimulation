function Max = distances(Matrix, id)

m = size(Matrix,1);
n = size(Matrix,2);

for i = 1:m
    Max(1,i) = sqrt( sum( (Matrix(id,2:n) - Matrix(i,2:n)).^2 ) ) ;
end

end