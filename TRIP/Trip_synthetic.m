
clear all; 
radius = 10
C = eye(3)/radius^2; C(3,3) = -1;
center(:,1) = [ 0 0 1]';
center(:,2) = [ 20 15 1]'; 
center (:,3) = [33 61 1]' ; 

T(:,:,1) = eye(3); T(:,3,1)= T(:,:,1)*center(:,1); 
T(:,:,2) = eye(3); T(:,3,2)= T(:,:,2)*center(:,2); 
T(:,:,3) = eye(3); T(:,3,3)= T(:,:,3)*center(:,3); 

Cw(:,:,1) = T(:,:,1)'\(C/(T(:,:,1)))  
Cw(:,:,2) =  T(:,:,2)'\(C/(T(:,:,2))) 


K = [1496 0 600; 0 1472 500; 0 0 1];
alpha = 30 ; beta = 40 ; gamma = 0;
t = [1.232 2.90 99.333]; 

Rt = createRotationMatrix( alpha, beta , gamma , t);

Ci(:,:,1) = projectedConic(Cw(:,:,1), Rt, K) 
Ci(:,:,2) = projectedConic(Cw(:,:,2), Rt, K); 



fprintf( ' First contour \n');
[ni(:,1,1) ni(:,2,1) Ti(:,1,1) Ti(:,2,1) calculatedRadius1] = calculateNormals(Ci(:,:,1), radius , Rt , K ); 


fprintf( ' second contour \n');
[ni(:,1,2) ni(:,2,2) Ti(:,1,2) Ti(:,2,2) calculatedRadius2] = calculateNormals(Ci(:,:,2), radius, Rt, K ); 


distanceGT = sqrt(sum((center(:,1)-center(:,2) ).^2));
distance(1,1) = sqrt(sum((Ti(:,1,1)-Ti(:,1,2) ).^2)); % T1 - T1' 
distance(1,2) = sqrt(sum((Ti(:,1,1)-Ti(:,2,2) ).^2)); % T1 - T2'
distance(2,1) = sqrt(sum((Ti(:,2,1)-Ti(:,1,2) ).^2)); % T2 - T1'
distance(2,2) = sqrt(sum((Ti(:,2,1)-Ti(:,2,2) ).^2)); % T2 - T2'

ni
Ti

fprintf( ' Original Distance \n');
distanceGT
fprintf( ' All possible distances from obtained points \n');
distance

% distancesGT = 

%Cn = K'*Ci_*K;
% 
% [V D] = eig(Cn); 
% V = -V*prod(sign(diag(D)))
% D = -D*prod(sign(diag(D)))
% [dummy, i] = sort(diag(D));
% Ds = D(i,i);
% Vs = V(:,i);
% 
% z2 = -Ds(2,2)^2/(Ds(1,1)*Ds(3,3))*radius^2
% a2 = (Ds(3,3) - Ds(2,2))*(Ds(2,2) - Ds(1,1))*z2/Ds(2,2)^2
% d2Target = sqrt(a2 + z2)
% d2TargetPlane = sqrt(z2)
% 
% 
% theta1 = atan(sqrt((Ds(2,2) - Ds(1,1))/(Ds(3,3) - Ds(2,2))));
% ct = cos(theta1); st = sin(theta1);
% R2 = [ct 0 st; 0 1 0; -st 0 ct];
% R1 = Vs
% Rc1 = R1*R2
% n1 = Rc1(:,3); % Note we want the positive one and not the negative one as Forsyth says
% 
% theta2 = -theta1;
% ct = cos(theta2); st = sin(theta2);
% R2 = [ct 0 st; 0 1 0; -st 0 ct];
% R1 = Vs
% Rc2 = R1*R2
% n2 = Rc2(:,3);
% 
% if (n1(3) < 0)
%   n1 = -n1;
%   Rc1 = -Rc1;
% end
% 
% if (n2(3) < 0)
%   n2 = -n2;
%   Rc2 = -Rc2;
% end
% 
% 
% 
% T1 = Rc1*[sqrt(a2) 0 sqrt(z2)]'
% T2 = Rc2*[-sqrt(a2) 0 sqrt(z2)]'
% 
% signChangedT1 = 0
% if (T1(3) < 0)
%   T1 = -T1
%   n1 = -n1
%   signChangedT1 = 1
% end
% 
% signChangedT2 = 0
% if (T2(3) < 0)
%   T2 = -T2
%   n2 = -n2
%   signChangedT2 = 1
% end

% ************* Calculation of Rotation Matrix *************
% x0 = Rt(:,3); % <--> Rt * [0 0 1]'
% x1 =  Rt * [radius 0 1]'; % remember x=radius, x is columns of image
% 
% 
% s0a_1 = (x0'*n1)/d2TargetPlane; % we are taking into account the sign of s0
% s1a_1 = (x1'*n1)/d2TargetPlane;
% s0a_2 = (x0'*n2)/d2TargetPlane; % we are taking into account the sign of s0
% s1a_2 = (x1'*n2)/d2TargetPlane;
% 
% 
% % Obtain the cartesian coordinates of points
% X0_1 = [x0(1)/s0a_1; x0(2)/s0a_1; x0(3)/s0a_1]
% X1_1 = [x1(1)/s1a_1; x1(2)/s1a_1; x1(3)/s1a_1];
% % Obtain the cartesian coordinates of points
% X0_2 = [x0(1)/s0a_2; x0(2)/s0a_2; x0(3)/s0a_2]
% X1_2 = [x1(1)/s1a_2; x1(2)/s1a_2; x1(3)/s1a_2];
% 
% 
% normT1_X0_1 = norm(T1-X0_1)
% normT2_X0_2 = norm(T2-X0_2)
% 
% 
% % I correct the vectors of the rotation matrix
% r1_1 = (X1_1-X0_1)/norm(X1_1-X0_1);
% r2_1 = cross(n1,r1_1);
% r1_2 = (X1_2-X0_2)/norm(X1_2-X0_2);
% r2_2 = cross(n2,r1_2);
% 
% fprintf(1, '\n\n#######New method to break the ambiguity:\n');
% Rt1 = [r1_1 r2_1 T1]
% Rt2 = [r1_2 r2_2 T2]
% c1_n = Rt1 * [0 0 1]';
% % since this point is normalized we can make its z = 1
% c1_n = c1_n/c1_n(3)
% c2_n = Rt2 * [0 0 1]';
% c2_n = c2_n/c2_n(3)
% 
% 
% % calculate the centre of the ellipse
% c1_y = ((-2*Cn(1,3)*Cn(1,2)*2) + (2*Cn(1,1)*Cn(2,3)*2)) / (Cn(1,2)*2*2*Cn(1,2) - 4*Cn(1,1)*Cn(2,2))
% c1_y = ((2*Cn(1,1)*2*Cn(2,3)) - (Cn(1,2)*2*2*Cn(1,3))) / ((4*Cn(1,1)*Cn(2,2)) - (2*2*Cn(1,2)*Cn(1,2)))
% c1_y = -c1_y
% 
% c1_x = (-Cn(1,2)*2) * (Cn(1,3)*2 + Cn(1,2)*2*c1_y) / (2*Cn(1,1)*Cn(1,2)*2)
% c1_x = ((Cn(1,3)*2) - (Cn(1,2)*2*c1_y)) / (2*Cn(1,1))
% c_n = [c1_x c1_y 1]'
% 
% normCnC1n = norm(c_n-c1_n)
% normCnC2n = norm(c_n-c2_n)
% 
% if (normCnC1n < normCnC2n)
%   fprintf('\n*******First solution*******');
% else
%   fprintf('\n*******Second solution*******');
% end
% 
% 
% signChanged = 0
% if (norm(T1-X0_1)) < (norm(T2-X0_2))
%   fprintf('\n*******First solution*******');
%   T = T1;
%   r1 = r1_1;
%   r2 = r2_1;
%   n = n1;
%   if (signChangedT1)
%     signChanged = 1
%   end
% else
%   fprintf('\n*******Second solution*******');
%   T = T2;
%   r1 = r1_2;
%   r2 = r2_2;
%   n = n2;
%   if (signChangedT2)
%     signChanged = 1
%   end
% end
% 
% 
% rotMatrix1 = [r1 r2 n]
% beta1 = asin(n(1)); cb = cos(beta1);
% alpha1 = asin(-rotMatrix1(2,3)/cb);
% gamma_tmp = asin(-rotMatrix1(1,2)/cb);
% cos_gamma1 = rotMatrix1(1,1)/cb;
% cos_gamma_tmp = cos(gamma_tmp);
% if (sign(cos_gamma_tmp) == sign(cos_gamma1))
%   gamma1 = gamma_tmp;
% else
%   gamma1 = pi-gamma_tmp;
% end;
% 
% 
% if (signChanged)
%   alpha1 = -alpha1
%   beta1 = -beta1
%   gamma1 = -gamma1
% end
% 
% 
% fprintf(1, '\n\nNew values for angles are:\n');
% fprintf(1, '%s %f\n', 'Alpha1:', 180*alpha1/pi);
% fprintf(1, '%s %f\n', 'Beta1:', 180*beta1/pi);
% fprintf(1, '%s %f\n', 'Gamma1:', 180*gamma1/pi);
% fprintf(1, '\nThe translation vector is: \n');
% T















