function [vb,f1out,niter] = fase_1(A,b,m,n,regla)
tol = 1e-12;
auxi1 = zeros(n,1);
auxi2 = ones(m,1);
c1 = [auxi1 ; auxi2];
aux = eye(m);
A1 = [A aux];
vb1 = n+1:n+m;
vn1 = 1:n;
xb1 = inv(A1(:,vb1))*b;
z1 = c1(vb1)'*xb1; 
iout = 0;
niter = 0;
while (iout == 0)
    niter = niter + 1;
    
    % regla = 1: simplex escollint VNB de cost reduit mes negatiu
    % regla = 2: simplex escollint VNB amb regla de Bland
    [vb1, vn1, xb1, z1, iout] = simplex( c1, A1, b, vb1, vn1, xb1, z1, regla,niter);
end
vb = vb1;
if (z1 > tol) 
    f1out = 0; % Problema infactible.
    disp(sprintf('Iteracio %3d : Problema infactible', niter))
    return;
end
correcte = true;
for i = 1:m
    if(vb1(i) > n) correcte = false;
    end
end
if correcte == true
    f1out = 1;
    disp(sprintf('Iteracio %3d : SBF inicial trobada', niter))
else f1out = 2;
end
end