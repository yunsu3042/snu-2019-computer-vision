function [p1, p2] = get_near_position(theta, i, j)
    tan225 = 0.4636;
    quart = pi / 2;
    tan675 = quart - tan225;
    
    if ((theta >= -tan225) && (theta <= tan225)) || ((theta >= quart + tan675) && (theta <= -(quart + tan675)))
        p1 = [i + 1, j];
        p2 = [i - 1, j];
        
    elseif ((theta >= tan225) && (theta <= tan675)) || ((theta >= -(quart + tan675)) && (theta <= -(quart + tan225)))
        p1 = [i + 1, j + 1];
        p2 = [i - 1, j - 1];
        
    elseif ((theta >= tan675) && (theta <= quart + tan225)) || ((theta >= -(quart + tan225)) && (theta <= -tan675))
        p1 = [i, j + 1];
        p2 = [i, j - 1];
    elseif ((theta >= quart + tan225) && (theta <= quart + tan675)) || ((theta >= -tan675) && (theta <= -tan225))
        p1 = [i - 1, j + 1];
        p2 = [i + 1, j - 1];      
    else
        p1 = [i - 1, j];
        p2 = [i, j + 1];        
        fprintf("Error : %d", theta);
    end
    
end