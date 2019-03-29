function [Iedge] = myDoubleThresholding (In, highThreshold, lowThreshold)
    [h, w] = size(In);
    
    fixed = zeros(h, w);
    Iedge = zeros(h, w);
    strong = 1;
    weak = 0.5;
    for i = 1 : h
        for j = 1 : w
            if In(i, j) >= highThreshold
               fixed(i, j) = strong;
            elseif In(i, j) >= lowThreshold
                fixed(i, j) = weak;
            end
        end
    end
    
    for i = 1 : h
        for j = 1 : w
           if fixed(i, j) == strong
               Iedge(i, j) = strong;
           elseif fixed(i, j) == weak
               for r = -1 : 1
                   for c = -1 : 1
                       pos = in_box(i + r, j + c, h, w);
                       if pos
                           if fixed(i + r, j + c) == strong
                               Iedge(i, j) = strong;
                           end
                       end
                   end
               end
               
               
            end
        end
    end
    
    for i = 1 : h
        for j = 1 : w
            if Iedge(i, j) == strong
               Iedge(i, j) = In(i,j);
            end
        end
    end
    
end
 

