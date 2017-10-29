function [X, y] = randomizeData(X, y)

m = size(y, 1);
perm = randperm(m);

x_temp = X(:, :);
y_temp = y(:, :);
for i = 1:m
  X(i, :) = x_temp(perm(i), :);
  y(i, :) = y_temp(perm(i), :);
end

clear x_temp;
clear y_temp;

end