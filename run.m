



%% %%% ========== INIT ========== %%%

clear ; close all ; clc



%%% ========== VARIABLE PARAMETERS ========== %%%

threshold = 0.60;
lambda = 20;



%%% ========== LOADING DATA AND DIVIDING INTO SETS ========== %%%

data = load('testData.txt');
X = data(:, [1, 2]); y = data(:, 3);

X = mapFeature(X(:,1), X(:,2));

m = size(y)(1);

x_train = X([1:floor(m * 0.6)], :);
y_train = y([1:floor(m * 0.6)], :);

x_val = X([floor(m * 0.6) + 1:floor(m * 0.8)], :);
y_val = y([floor(m * 0.6) + 1:floor(m * 0.8)], :);

x_test = X([floor(m * 0.8):end], :);
y_test = y([floor(m * 0.8):end], :);



%%% ========== TESTING OUT VARIOUS LAMBDA AND THRESHOLD ========== %%%

max = 0;
maxL = -1;
maxT = -1;

for L = 0:0.1:50
  for T = 0.1:0.01:0.9
    theta = normalEquation(x_train, y_train, L);
    predicted_y = predict(theta, x_val, T);
    
    %fprintf("\n\n\nLambda: %d", L);
    %fprintf("\nThreshold: %d\n", T);
    f = fscore(predicted_y, y_val);
    if f > max
      max = f;
      maxL = L;
      maxT = T;
    endif
  end
end

%fprintf("\n\n\n\n---------\n\nMax Lambda: %d", maxL);
%fprintf("\nMax Threshold: %d", maxT);
%fprintf("\nMax F: %d\n", max);



%%% ========== PLOTTING THE LEARNING CURVE ========== %%%

%[error_train, error_val] = learningCurve(x_train, y_train, x_val, y_val, lambda, threshold);

%figure(1);
%plot(1:size(x_train)(1), error_train, 1:size(x_train)(1), error_val);
%title('Learning curve for logistic regression')
%legend('Train', 'Cross Validation')
%xlabel('Number of training examples')
%ylabel('Error')
%axis([0 size(x_train)(1) 0 1])



%%% ========== CHECKING PARAMS ========== %%%

%theta = normalEquation(x_train, y_train, lambda);
%predicted_y = predict(theta, x_val, threshold);

%% [predicted_y y_test]

%fscore(predicted_y, y_val)