function [A, b, c, m, n] = read()
    Arxiu = fopen('dades.txt','r');
    formatSpec = '%f';
    sizec = [20 1];
    c = fscanf(Arxiu,formatSpec,sizec);
    sizeA = [20 10];
    A = fscanf(Arxiu,formatSpec,sizeA);
    sizeb = [10 1];
    b = fscanf(Arxiu,formatSpec,sizeb);
    A = A';
    [m,n] = size(A);
end