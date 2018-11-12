function [vb, vn, xb, z, iout] = simplex( c, A, b, vb, vn, xb, z, regla)
[m, n] = size(A);
B_inv = inv(A(:,vb));

% 1. Vector de costos
r = (c(vn,:))' - (c(vb,:))'*B_inv*A(:,vn);

if regla == 1   % apliquem cost reduit mes negatiu
    x = min(r);
    if x >= 0
        iout = 1;       % SBF optima trobada
        return;
    end
    q = find(r, x) % es INDEX de la VNB d'entrada. Entra vn(q)
end

if regla == 2    % apliquem regla de Bland
    q = -1;
    trobat = false;
    for i = 1:n-m
        if (trobat == false)
            if (r(i) < 0)
                q = i; % es INDEX de la VNB d'entrada. Entra vn(q)
                trobat = true;
            end
        end
    end
    if (q == -1) 
        iout = 1;       % SBF optima trobada
        return;
    end
end

% 2. Direcció bàsica
db = -B_inv*A(:,q)
if min(db) >=0
    iout = 2    % problema il·limitat
    return;
end

% 3. Longitud de pas
theta = inf;
p = 0;
for i = 1:m
    if (db(i) < 0) & (-xb(i)/db(i) < theta)
        theta = -xb(i)/db(i);
        p = i;
    end
end
if theta == 0
    iout = 3    % SBF degenerada
    return;
end

% 4. Actualitzacions per retornar en executar simple_function

% vb i vn actualitzats
j = vb(p);
vb(p) = vn(q);
vn(q) = j;

xb = inv(A(:,vb))*b;
z = c(vb,:)'*xb;
iout = 0;
        