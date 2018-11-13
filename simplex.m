function [vb, vn, xb, z, iout] = simplex(c, A, b, vb, vn, xb, z, regla, niter)
tol = 1e-12;
[m, n] = size(A);
B_inv = inv(A(:,vb));

% 1. Vector de costos
r = (c(vn,:))' - (c(vb,:))'*B_inv*A(:,vn);

if regla == 1   % apliquem cost reduit mes negatiu
    minim = 0;
    q = -1;
    for i = 1:n-m
        if r(i) < minim
           minim = r(i);
           q = i;
        end
    end
end

if regla == 2    % apliquem regla de Bland
    q = -1;
    minim = inf;
    for i = 1:n-m
        if (r(i) < 0)
            if (vn(i) < minim)
                q = i; % es INDEX de la VNB d'entrada. Entra vn(q)
                minim = vn(i);
            end
        end
    end
end

 if (q == n + m + 1 | q == -1) 
        iout = 1;       % SBF optima trobada
        return;
 end
    
% 2. Direccio basica
db = -B_inv*A(:,vn(q));
if min(db) >=0
    iout = 2    % identificacio del problema il.limitat
    return;
end


% 3. Longitud de pas
theta = inf;
p = 0;              % p es l'INDEX de la vb de sortida
for i = 1:m
    if (db(i) < 0) & (-xb(i)/db(i) < theta)
        theta = -xb(i)/db(i);
        p = i;
    end
end

if theta < tol
    iout = 3    % SBF degenerada
    return;
end

% 4. Actualitzacions per tornar en executar simple_function
j = vb(p);
vb(p) = vn(q);
vn(q) = j;

xb = inv(A(:,vb))*b;
z = c(vb,:)'*xb;
disp(sprintf('Iteracio %3d : N(q) = %3d , rq = %8.3f , B(p) = %3d , theta* = %8.3f , z = %8.3f' ,niter,vb(p),r(q),vn(q),theta,z))

iout = 0;