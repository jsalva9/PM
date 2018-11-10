clear;
Arxiu = fopen('dades.txt','r');
formatSpec = '%f';
sizec = [1 20];
c = fscanf(Arxiu,formatSpec,sizec);
sizeA = [10 20];
A = fscanf(Arxiu,formatSpec,sizeA);
sizeb = [1 10];
b = fscanf(Arxiu,formatSpec,sizeb);


[m,n] = size(A);

vb = zeros(m);
vn = zeros(n - m);

% Falta la funció "fase1". Creació del problema de F1;
[vb] = fase_1(A,b,m,n);

bool trobat;
iter = 1;
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
