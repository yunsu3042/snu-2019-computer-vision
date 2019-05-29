
function d = point_to_line(pt, v1, v2)
      b = v1 - v2;
      a = pt - v2;
      c = abs(dot(a, b) / norm(b));
      d = sqrt(norm(a) ^ 2 - c ^ 2);
end

