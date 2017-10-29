function p = predict(theta, X)

m = size(X, 1); % Number of training examples

p = zeros(m, 1);

% Computing the sigmoid values for each prediction
sigmoids = sigmoid(X * theta);

% Iterating through predictions
for i = 1:m

	% If sigmoid value is over 0.5 then we predict positive for this
	if sigmoids(i) >= 0.5
		p(i, 1) = 1;
	else
		p(i, 1) = 0;
	endif
end


end
