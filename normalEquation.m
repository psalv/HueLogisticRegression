function theta = normalEquation(X, y, lambda)

X_trans = X';
normalMatrix = eye(size(X)(2));
normalMatrix(1,1) = 0;

theta = pinv(X_trans * X + lambda * normalMatrix) * X_trans * y; 

clear X_trans normalMatrix;
end
