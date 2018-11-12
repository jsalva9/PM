function [vb] = fase_1(A,b,m,n)
auxi1 = zeros(n,1);
auxi2 = ones(m,1);
c1 = [auxi1 ; auxi2];
aux = eye(m);
A1 = [A aux];
vb1 = n+1:n+m;
vn1 = 1:n;
abanico = A1(:,vb1);
xb1 = inv(abanico)*b;
z1 = c1(vb1)'*xb1; 
iout = 0;
niter = 0;
while (iout == 0)
    niter = niter + 1;
    
    % regla = 1: simplex escollint VNB de cost reduit mes negatiu
    % regla = 2: simplex escollint VNB amb regla de Bland
    [vb1, vn1, xb1, z1, iout] = simplex( c1, A1, b, vb1, vn1, xb1, z1,2);
end

vb = vb1;