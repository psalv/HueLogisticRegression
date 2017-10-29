function J = costFunctionReg(theta, X, y, lambda)

m = length(y); % number of training examples

% We substitite theta transpose * X as the input to the sigmoid function
hx = sigmoid(X * theta);

% We are computing all of the values of the sums at once by using matrix multiplication
J = ((-1 * y) .* log(hx)) - ((1 - y) .* (log(1 - hx)));
J = sum(J) / m;

J = J + ((lambda / (2 * m)) * sum(theta .^ 2));

end
