function [affineLKContext] = initAffineLKTracker(img, mask)
        
    [h, w] = size(img);
    J = zeros(h * w, 6);
    T = img .* mask;
    [Tx,Ty] = gradient(T);
    idx = 1;
    
    for x = 1 : w
        for y = 1 : h 
            dx = x / w;
            dy = y / h;
            J(idx, :) = [Tx(idx), Ty(idx)] * [dx 0 dy 0 1 0; 0 dx 0 dy 0 1];
            idx = idx + 1;
        end
    end

    affineLKContext.Jacobian = J;
    affineLKContext.HessianInv = inv(J'*J);
    affineLKContext.Exception = false;
end