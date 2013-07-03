% fitellip gives the 6 parameter vector of the algebraic circle fit
% to a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0
% X & Y are lists of point coordinates and must be column vectors.
function a = fitellip(X,Y)

%% Test Data 
% close all; 
% maj_a =  4; % 1/sqrt(2); 
% min_b =  2 ; % 1/sqrt(4); 
% rotAngle = 45 *pi/180; 
% trans_x = 3; 
% trans_y = 3; 
% % Create points
% i = 1;
% for theta = 0:10:360
%     conicPoints(1,i) = maj_a * cos(theta*pi/180) ;
%     conicPoints(2,i) = min_b * sin(theta*pi/180) ;
%     i = i+1;
% end
% figure;
% plot(conicPoints(1,:),conicPoints(2,:),'*' );   % Plot normal points
% % Applied Rotation
% R = [cos(rotAngle) -sin(rotAngle) ; sin(rotAngle) cos(rotAngle)];
% baseConicPoints = R * [ conicPoints(1,:) ;conicPoints(2,:) ];
% figure;
% plot(baseConicPoints(1,:),baseConicPoints(2,:),'*' ); % plot rotated points
% % Applied Translation
% X = baseConicPoints(1,:) + trans_x ;
% Y = baseConicPoints(2,:) + trans_y ;

%% 

% normalize data
X = X'; 
Y = Y' ; 
mx = mean(X);
my = mean(Y);
sx = (max(X)-min(X))/2;
sy = (max(Y)-min(Y))/2;
x = (X-mx)/sx;
y = (Y-my)/sy;

% Build design matrix
D = [ x.*x  x.*y  y.*y  x  y  ones(size(x)) ];

% Build scatter matrix
S = D'*D;

% Build 6x6 constraint matrix
C(6,6) = 0; C(1,3) = -2; C(2,2) = 1; C(3,1) = -2;

% Solve eigensystem
[gevec, geval] = eig(S,C);

% Find the negative eigenvalue
[NegR, NegC] = find(geval < 0 & ~isinf(geval));

% Extract eigenvector corresponding to positive eigenvalue
A = gevec(:,NegC);

% unnormalize
a = [
    A(1)*sy*sy,   ...
    A(2)*sx*sy,   ...
    A(3)*sx*sx,   ...
    -2*A(1)*sy*sy*mx - A(2)*sx*sy*my + A(4)*sx*sy*sy,   ...
    -A(2)*sx*sy*mx - 2*A(3)*sx*sx*my + A(5)*sx*sx*sy,   ...
    A(1)*sy*sy*mx*mx + A(2)*sx*sy*mx*my + A(3)*sx*sx*my*my   ...
    - A(4)*sx*sy*sy*mx - A(5)*sx*sx*sy*my   ...
    + A(6)*sx*sx*sy*sy   ...
    ]';

% To solve the angle and axis information 
%v = solveellipse(a)

%To draw the ellipse and show 
%drawellip(a,X,Y ); 


