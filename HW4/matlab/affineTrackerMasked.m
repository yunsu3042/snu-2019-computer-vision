
function Wout = affineTrackerMasked(img, tmp, mask, W, context, nIter)
%     disp(W);
    J = context.Jacobian;
    H_inv = context.HessianInv;
    [h, w] = size(img);
    dW = eye(3, 3);
    error = ones(6, 1);
    iter = 1;
%     T_masked = tmp .* mask;
    
    while (iter < nIter)
        I_warped = double(warpImageMasked(img, mask, W));

        T_masked = double(warpImageMasked(tmp, mask, dW));
        error = (-I_warped + T_masked);
        dP = H_inv * J' * error(:);
        dP(1) = dP(1) / w; 
        dP(2) = dP(2) / w; 
        
        dP(3) = dP(3) / h;
        dP(4) = dP(4) / h;
        dW = [1 + dP(1) dP(3) dP(5); dP(2) 1 + dP(4) dP(6); 0 0 1];
        
        W = W / dW;
        iter = iter + 1;

    end
    fprintf("error : %f\n", norm(error));
    Wout = W;
end