function [error_train, error_val] = learningCurve(X, y, Xval, yval, lambda, threshold)

m = size(X, 1);
m_val = size(Xval, 1);

error_train = zeros(m, 1);
error_val   = zeros(m, 1);

for i = 1:m
	theta = normalEquation(X(1:i, :), y(1:i), lambda);

	error_train(i) = sum ( predict( theta, X(1:i, :), threshold ) != y(1:i) ) / ( 2 * i );
 	error_val(i) = sum ( predict(theta, Xval, threshold) != yval ) / ( 2 * m_val );
end


end