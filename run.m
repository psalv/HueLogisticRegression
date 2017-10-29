



%% %%% ========== INIT ========== %%%

clear ; close all ; clc



%%% ========== VARIABLE PARAMETERS ========== %%%

threshold = 0.6;
lambda = 1;


%%% ========== LOADING DATA AND DIVIDING INTO SETS ========== %%%

data = load('testData.txt');
X = data(:, [1, 2]); y = data(:, 3);






%max = 0;
%maxL = -1;
%maxT = -1;
%maxD = -1;

%m = size(y)(1);
%y_train = y([1:floor(m * 0.6)], :);
%y_val = y([floor(m * 0.6) + 1:floor(m * 0.8)], :);
%y_test = y([floor(m * 0.8):end], :);

%for d = 1:10
%  X = mapFeature(X(:,1), X(:,2), d);
%  x_train = X([1:floor(m * 0.6)], :);
%  x_val = X([floor(m * 0.6) + 1:floor(m * 0.8)], :);
%  x_test = X([floor(m * 0.8):end], :);
%  for L = 1:1:50
%    for T = 0.3:0.03:0.9
%      theta = normalEquation(x_train, y_train, L);
%      predicted_y = predict(theta, x_val, threshold);
%      [f, p, r] = fscore(predicted_y, y_val);
%      if f > max
%        max = f;
%        maxL = L;
%        maxT = T;
%        maxD = d;
%      endif
%    end
  %end
%end

%fprintf("\n\n\n\n---------\n\nMax Lambda: %d", maxL);
%fprintf("\nMax F: %d\n", max);













oldX = X;
X = mapFeature(X(:,1), X(:,2), 5);

m = size(y)(1);

x_train = X([1:floor(m * 0.6)], :);
y_train = y([1:floor(m * 0.6)], :);

x_val = X([floor(m * 0.6) + 1:floor(m * 0.8)], :);
y_val = y([floor(m * 0.6) + 1:floor(m * 0.8)], :);

x_test = X([floor(m * 0.8):end], :);
y_test = y([floor(m * 0.8):end], :);



%%% ========== TESTING OUT VARIOUS LAMBDA AND THRESHOLD ========== %%%

%max = 0;
%maxL = -1;
%maxT = -1;

%for L = 0:0.2:50
%  for T = 0.1:0.02:0.9
%    theta = normalEquation(x_train, y_train, L);
%    predicted_y = predict(theta, x_val, T);
%    
    %fprintf("\n\n\nLambda: %d", L);
    %fprintf("\nThreshold: %d\n", T);
%    f = fscore(predicted_y, y_val);
%    if f > max
%      max = f;
%      maxL = L;
%      maxT = T;
%    endif
%  end
%end

%fprintf("\n\n\n\n---------\n\nMax Lambda: %d", maxL);
%fprintf("\nMax Threshold: %d", maxT);
%fprintf("\nMax F: %d\n", max);



%%% ========== PLOTTING THE LEARNING CURVE ========== %%%

[error_train, error_val] = learningCurve(x_train, y_train, x_val, y_val, lambda, threshold);

figure(1);
plot(1:size(x_train)(1), error_train, 1:size(x_train)(1), error_val);
title('Learning curve for logistic regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 size(x_train)(1) 0 1])



%%% ========== CHECKING PARAMS ========== %%%
theta = normalEquation(x_train, y_train, lambda);
predicted_y = predict(theta, x_val, threshold);

%[oldX([floor(m * 0.6) + 1:floor(m * 0.8)], :)(:, 2) predicted_y y_val]

[f, p, r] = fscore(predicted_y, y_val);

fprintf('Precision: %d\n', p);
fprintf('Recall: %d\n', r);
fprintf('F1 Score: %d\n', f);
