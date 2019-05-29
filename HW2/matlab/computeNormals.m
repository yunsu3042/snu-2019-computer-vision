function [normals, albedo] = computeNormals(img1, img2, img3, lv1, lv2, lv3, threshold)
    [h, w] = size(img2);
    normals = zeros(3, h, w);
    albedo = zeros(h, w);
    S = [lv1; lv2; lv3];
 
     for i = 1 : h
         for j = 1 : w
             I = [img1(i, j); img2(i, j); img3(i,j)];
             if sum(I >= threshold) ~= 3 
                 albedo(i, j) = 0;
                 n = [0;0;0];
             else
                 n_bar = inv(S) * I;
                 rho = norm(n_bar);
                 albedo(i, j) = rho;
                 n = n_bar / rho;
             end
             normals(1, i, j) = n(1);
             normals(2, i, j) = n(2);
             normals(3, i, j) = n(3);
         end
     end
end