load('../data/bunny.mat');
[m, n, c] = size(N);
X = zeros(m,n);
Y = zeros(m,n);
U = zeros(m,n);
V = zeros(m,n);
for i = 1 : m
    for j = 1 : n
        X((i - 1) * m + j) = j;
        Y((i - 1) * m + j) = i;
        U((i - 1) * m + j) = N(i, j, 1);
        V((i - 1) * m + j) = N(i, j, 2);
    end
end
figure(1);
quiver(X, Y, U, V);

s = [0, 0, 1];
s = reshape(s, 1, 1, 3);
Z = zeros(m,n);
for i = 1 : m
    for j = 1 : n
        Z(i, j) = dot(N(i, j, :), s);
    end
end
figure(2);
mesh(Z);
