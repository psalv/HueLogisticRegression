function f = fscore(predicted_y, actual_y)

f = 0;

true_positive = 0;
for i = 1:size(predicted_y),
  if predicted_y(i) == 1
    if actual_y(i) == 1
      ++true_positive;
    endif
  endif
end

pred_positive = sum(predicted_y);
actual_positive = sum(actual_y);

recall = true_positive / actual_positive;

if pred_positive == 0
  precision = 0;
  recall = 1;
else
  precision = true_positive / pred_positive;
endif


f = 2 * ( (precision * recall) / (precision + recall) );

%fprintf('Precision: %d\n', precision);
%fprintf('Recall: %d\n', recall);
%fprintf('F1 Score: %d\n', f);

end
