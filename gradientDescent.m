function [theta, steps] = gradientDescent(X, y, alpha, lambda)

steps = zeros(100, 1);
theta = ones(3, 1);

for i = 1:100

  % TODO!! INPUT THE CODE FOR GRADIENT DESCENT (UPDATING THETA)

  steps(i) = costFunctionReg(theta, X, y, lambda);
end

end
