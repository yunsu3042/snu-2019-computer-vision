function [h_merged, w_merged, diff] = helper(Iin, Iref, H)
    [h, w, ~] = size(Iin);
    [h_ref, w_ref, ~] = size(Iref);
    
    % 왼쪽 상단
    p1 = [1, 1, 1]';
    % 왼쪽 하단 
    p2 = [1, h, 1]';
    % 오른쪽 상단
%     p3 = [1, w, 1]';
    % 오른쪽 하단 
%     p4 = [h, w, 1]';
    
    wp1 = H * p1;
    wp2 = H * p2;

    wp1 = wp1 ./ wp1(3);
    wp2 = wp2 ./ wp2(3);

    wp1 = ceil(wp1);
    wp2 = floor(wp2);

    top_most = min(wp1(2), 1);
    bot_most = max(wp2(2), h_ref);
    left_most = min(wp1(1), min(wp2(1), 0));
    right_most = w_ref;
    h_merged = bot_most - top_most+ 1;
    w_merged = right_most - left_most + 1;
    diff = [1, 1] - [top_most, left_most];
end