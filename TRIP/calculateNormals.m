function [n1 n2 T1 T2 calculatedRadius] = calculateNormals(Ci, radius, Rt , K )


Cn = K'*Ci*K;

[V D] = eig(Cn);
V = -V*prod(sign(diag(D)));
D = -D*prod(sign(diag(D)));
[dummy, i] = sort(diag(D));
Ds = D(i,i);
Vs = V(:,i);

z2 = -Ds(2,2)^2/(Ds(1,1)*Ds(3,3))*radius^2;
a2 = (Ds(3,3) - Ds(2,2))*(Ds(2,2) - Ds(1,1))*z2/Ds(2,2)^2;
calculatedRadius = sqrt(-(Ds(1,1)*Ds(3,3))/Ds(2,2)^2);
d2Target = sqrt(a2 + z2);
d2TargetPlane = sqrt(z2);


theta1 = atan(sqrt((Ds(2,2) - Ds(1,1))/(Ds(3,3) - Ds(2,2))));
ct = cos(theta1); st = sin(theta1);
R2 = [ct 0 st; 0 1 0; -st 0 ct];
R1 = Vs;
Rc1 = R1*R2;
n1 = Rc1(:,3); % Note we want the positive one and not the negative one as Forsyth says

theta2 = -theta1;
ct = cos(theta2); st = sin(theta2);
R2 = [ct 0 st; 0 1 0; -st 0 ct];
R1 = Vs;
Rc2 = R1*R2;
n2 = Rc2(:,3);

if (n1(3) < 0)
    n1 = -n1;
    Rc1 = -Rc1;
end

if (n2(3) < 0)
    n2 = -n2;
    Rc2 = -Rc2;
end

T1 = Rc1*[sqrt(a2) 0 sqrt(z2)]';
T2 = Rc2*[-sqrt(a2) 0 sqrt(z2)]';


if (T1(3) < 0)
  T1 = -T1;
  n1 = -n1;
end


if (T2(3) < 0)
  T2 = -T2;
  n2 = -n2;
end
 

% T1
% T2
% n1
% n2

end