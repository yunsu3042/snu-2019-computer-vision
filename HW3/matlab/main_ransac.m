sigma = 0.1;
random_x = -1 + 2 * rand(1, 100);
random_y = -1 + 2 * rand(1, 100);
x = linspace(-1, 1, 100);
y = linspace(-1, 1, 100);
points = [x random_x; y random_y];
noise = random('norm', 0, sigma,[2,200]);
points = points + noise;

iter = 6;
thr = 0.2;
mininlier = 70;
[line, inliers] = ransac(points, iter, thr, mininlier);

inlier_x = zeros(1, 200);
inlier_y = zeros(1, 200);
outlier_x = zeros(1, 200);
outlier_y = zeros(1, 200);
count = sum(inliers);

[p, n] = size(points);
j = 1;
k = 1;
for i = 1 : n
    if inliers(i) == 1
        inlier_x(j) = points(1, i);
        inlier_y(j) = points(2, i);
        j = j + 1;
    else
        outlier_x(k) = points(1, i);
        outlier_y(k) = points(2, i);
        k = k + 1;
    end    
end

plot_x = linspace(-2, 2, 100);
X = [plot_x' ones(100, 1)]; 
Y = X * line;
scatter(outlier_x(1: k), outlier_y(1: k), 'MarkerEdgeColor', 'b');

hold on 
scatter(inlier_x(1 : count), inlier_y(1: count), 'MarkerEdgeColor', 'r');
plot(plot_x, Y);
