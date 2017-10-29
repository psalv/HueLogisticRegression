
%% Initialization
clear ; close all; clc


threshold = 0.5;
lambda = 1;


%% Load Data
% The first two columns contains the X values and the third column contains the label (y).

data = load('testData.txt');
X = data(:, [1, 2]); y = data(:, 3);

m = size(y)(1);

x_train = X([1:floor(m * 0.6)], :);
y_train = y([1:floor(m * 0.6)], :);

x_val = X([floor(m * 0.6) + 1:floor(m * 0.8)], :);
y_val = y([floor(m * 0.6) + 1:floor(m * 0.8)], :);

x_test = X([floor(m * 0.8):end], :);
y_test = y([floor(m * 0.8):end], :);



% Add Polynomial Features

% Note that mapFeature also adds a column of ones for us, so the intercept term is handled
% X = mapFeature(X(:,1), X(:,2));

[error_train, error_val] = learningCurve(x_train, y_train, x_val, y_val, lambda, threshold);

figure(1);
plot(1:size(x_train)(1), error_train, 1:size(x_train)(1), error_val);
title('Learning curve for logistic regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 size(x_train)(1) 0 1])

theta = normalEquation(x_train, y_train, lambda);
predicted_y = predict(theta, x_test, threshold);

% [predicted_y y_test]

fscore(predicted_y, y_test)