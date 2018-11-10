function [vb] = fase_1(A,b,m,n)
A_1 = A;
c_1 = zeros(1,n+m);
for i = 1:m
    c_1(n+1) = 1;
end
for i = 1:m
    new = zeros(m,1);
    new(m) = 1;
    A_1 = [A_1 new];
end
vb = n+1:n+m;
vn = 1:n;
xb = inv(A_1(:,vb))*b;
z = c(:,vb)*xb; 
[vb, vn, xb, z, iout] = simplex( c_1, A_1, b, vb, vn, xb, z,2);
