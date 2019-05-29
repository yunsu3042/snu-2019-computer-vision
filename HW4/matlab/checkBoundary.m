
function [ptx, pty] = checkBoundary(img_size, ptx, pty)
    % remove decimals
    pty = round(pty);
    ptx = round(ptx);

    % bounds checking
    pty = min(img_size(1), pty);
    pty = max(1, pty);
    ptx = min(img_size(2), ptx);
    ptx = max(1, ptx);
end
