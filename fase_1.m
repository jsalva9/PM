function [vb] = fase_1(A,b,m,n)
c1 = zeros(1,n+m);
A1 = A;
for i = 1:m
    A1(n+1) = 1;
end
for i = 1:m
    new = zeros(m,1);
    new(m) = 1;
    A1 = [A new];
end
vb1 = n+1:n+m;
vn1 = 1:n;
abanico = A1(:,vb);
xb1 = inv(abanico)*b;
z1 = c(:,vb)*xb; 
iout = 0;
while (iout == 0)
    niter = niter + 1;
    
    % regla = 1: simplex escollint VNB de cost reduit mes negatiu
    % regla = 2: simplex escollint VNB amb regla de Bland
    [vb1, vn1, xb1, z1, iout] = simplex( c1, A1, b, vb1, vn1, xb1, z1,2);
end
vb = vb1;
