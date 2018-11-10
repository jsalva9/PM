function [vb] = fase_1(A,b,m,n)
c = zeros(1,n+m);
for i = 1:m
    cA(n+1) = 1;
end
for i = 1:m
    new = zeros(m,1);
    new(m) = 1;
    A = [A new];
end
vb = n+1:n+m;
vn = 1:n;
abanico = A(:,vb);
xb = inv(abanico)*b;
z = c(:,vb)*xb; 
[vb, vn, xb, z, iout] = simplex( c, A, b, vb, vn, xb, z,2);
