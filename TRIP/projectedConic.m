function Ci = projectedConic( Cw , Rt, K )

H = K*Rt;

Ci = inv(H)'*Cw*inv(H);

%Normalize 
Ci = Ci ./ Ci(3,3); 

end