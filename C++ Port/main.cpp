#include "Predict.cpp"

int main(void){

	arma::mat frequencyPredict = Predict::trainAndPredict(1, 0);
	arma::mat logisticPredict = Predict::trainAndPredict(1, 1);

	std::cout << arma::join_rows(frequencyPredict, logisticPredict) << "\n\n";
	std::cout << "Checking threshold: " << Predict::checkConfidence(1) << "\n";


	return 0;
}