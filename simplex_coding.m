clear;
Arxiu = fopen('dades.txt','r');
formatSpec = '%f';
sizec = [20 1];
c = fscanf(Arxiu,formatSpec,sizec);
sizeA = [20 10];
A = fscanf(Arxiu,formatSpec,sizeA);
A = A';
sizeb = [10 1];
b = fscanf(Arxiu,formatSpec,sizeb);

[m,n] = size(A);
vb = zeros(1,m);
vn = zeros(1,n - m);
[vb1] = fase_1(A,b,m,n);
vb = vb1;
bool trobat;

for i = 1:n
    trobat = false;
    for j = 1:m
        if (vb(j) == i)
            trobat = true;
        end
    end
    if(trobat == false) 
        vn(iter) = i;
        ++iter;
    end
end

xb = inv(A(:,vb))*b;

z = c(:,vb)*xb;

niter = 0;
while (iout == 0)
    niter = niter + 1;
    
    % regla = 1: simplex escollint VNB de cost reduit mes negatiu
    % regla = 2: simplex escollint VNB amb regla de Bland
    [vb, vn, xb, z, iout] = simplex( c, A, b, vb, vn, xb, z, regla);
end
