function varargout = matsplit(A,dim)
    if nargin==1
        varargout = num2cell(A);
    else
        varargout = num2cell(A,dim);
    end
end