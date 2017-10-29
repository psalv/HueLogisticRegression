function g = sigmoid(z)

g = zeros(size(z));

g = arrayfun(@(x) (1+e.^(-1*x)).^(-1), z );

end
