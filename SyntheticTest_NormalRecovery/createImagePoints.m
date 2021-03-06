function circlePointsImage = createImagePoints(P, circlePoints, imageWidth , imageHeight, drawImagePoints)


% circlePoints = [2 3 4 5; 2 2 2 2 ; 3 3 3 3]';
% P = [ 1233 0 0 0 ; 0 1233 0 0 ; 0 0 1 1000] ;


% 3xN = 3x4 * 4xN
[m n ] = size(P);
[q t] = size(circlePoints);

if( n ~= 4 && m ~= 3 )
    error('Error in projection matrix');
end

if( q ~= 4 )
    error('Points not homogenised or Need to transpose ');
end


circlePointsImage = P * circlePoints;
circlePointsImage(1,:) = circlePointsImage(1,:) ./ circlePointsImage(3,:);
circlePointsImage(2,:) = circlePointsImage(2,:) ./ circlePointsImage(3,:);
circlePointsImage = [ circlePointsImage(1,:)  ; circlePointsImage(2,:)];


if( circlePointsImage(1,:) > imageWidth )
    error('x points exceed image limits ');
    
elseif( circlePointsImage(1,:) < 0 )
    error('x points exceed image limits');
    
end
if( circlePointsImage(2,:) > imageHeight )
    error('y points exceed image limit');
    
elseif( circlePointsImage(2,:) < 0 )
    error('y points exceed image limit');
end

end