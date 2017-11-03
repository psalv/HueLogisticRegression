#include <iostream>
#include <armadillo>
#include <stdlib.h>

#define LAMBDA 1
#define THRESHOLD 0.6
#define CERTAINTY_THRESHOLD 0.6
#define DEGREE 5
#define MAPPED_NUM 21



arma::mat mapFeature(arma::mat X1, arma::mat X2){
    arma::mat out(size(X1, 0), MAPPED_NUM);

    int column = 0;
    for(int i = 0; i <= DEGREE; i++){
        for(int j = 0; j <= i; j++){
            out.col(column++) = ( pow(X1, i-j) % pow(X2, j) );
        }
    }

    return out;
}


/**
 *
 * @param theta: (n + 1) x 1 vector
 * @param X: m x (n+1) vector where m is number of training examples and n is the number of features
 * @param m equivallent to the number of training examples in X
 * @return a vector of size m x 1 representing the sigmoid function applied to each value of z
 */
arma::mat sigmoid(arma::mat *theta, arma::mat *X, unsigned long m){
    arma::mat z = *theta * *X;

    arma::mat s(m, 1);

    for(int i = 0; i < m; i++){
        s(i, 0) = ( 1.0/(1.0 + exp(-1.0 * z(i, 0))) );
    }

    return s;
}


/**
 *
 * @param theta: (n + 1) x 1 vector
 * @param X: m x (n+1) vector where m is number of predictions to make and n is the number of features
 * @param threshold is a double representing the threshold from which to consider the output positive
 * @return the prediction for each of the values in X parameterized with theta: m x 1 vector
 */
arma::mat predict(arma::mat *theta, arma::mat *X){
    unsigned long m = arma::size(*X, 0);
    arma::mat p = arma::zeros(m, 1);

    arma::mat sigmoids = sigmoid(X, theta, m);

    for(int i = 0; i < m; i++){
        if( sigmoids(i, 0) >= THRESHOLD ){
            p(i, 0) = 1;
        }
    }

    return p;
}


/**
 *
 * @param X: m x (n+1) matrix, where m is number of training examples and n is the number of features
 * @param y: m x 1 vector
 * @param lambda the regularization parameter
 * @return the minimized values of theta: (n+1) x 1 vector
 */
arma::mat normalEquation(arma::mat *X, arma::mat *y){
    arma::mat X_transpose = X->t();

    unsigned long n = arma::size(*X, 1);
    arma::mat normalMatrix = arma::eye<arma::mat>(n, n);
    normalMatrix(0, 0) = 0;

    return ( arma::pinv(X_transpose * *X + LAMBDA * normalMatrix) * X_transpose * *y );
}


// TODO !!! REWRITE TO READ AND FORMAT FROM DATABASE
arma::mat generateLightMatrix(int lightId){
    // vector<vector<int>> lightData = getLightData();


    arma::mat data;
    data.load("../testData.txt");
    return data;
}

arma::mat generateWeekOfX(){
    arma::mat x_predict(7, 24*7);
    int pos = 0;
    for(int day = 1; day < 8; day++){
        for(int hour = 0; hour < 24; hour++) {
            x_predict(pos, 0) = day;
            x_predict(pos, 1) = hour;
        }
    }
    return x_predict;
}



/**
 *
 * @param lightId the id of a light to collect all data for, train theta, and predict a weeks worth of scheduling
 * @return a matrix representing a week of scheduling
 */
arma::mat trainAndPredict(int lightId, int machineLearning){

	// Data does not need to be randomized since we are using all of it
    arma::mat data = generateLightMatrix(lightId);
	arma::mat x_predict = generateWeekOfX();

    if(machineLearning){
    	// train and predict and then schedule
   		arma::mat y = data.col(2);
    	arma::mat X = mapFeature(data.col(0), data.col(1));
    	
    	arma::mat theta = normalEquation(&X, &y);

   		return predict(&theta, &x_predict);
    } else {
    	// predict based on most frequent for that day
    	// arma::mat = 

    	return x_predict;
    }


}


double fscore(arma::mat *y_predicted, arma::mat *y_test){
	double true_postive = 0;
	double pred_positive = 0;
	double actual_positive = 0;
	for(int i = 0; i < arma::size((*y_predicted), 0); i++){
		if((*y_predicted).at(i, 0) == 1){
			if((*y_test).at(i, 0) == 1){
				true_postive++;
				actual_positive++;
			}
			pred_positive++;
		} else if ((*y_test).at(i, 0) == 1){
			actual_positive++;
		}
	}

	if(actual_positive == 0 || true_postive == 0){
		return 0;
	}

	double recall = true_postive / actual_positive;
	double precision = true_postive / pred_positive;

	return 2 * ( (precision * recall) / (precision + recall) );
}

int checkConfidence(int lightId){

	arma::mat data = generateLightMatrix(lightId);

	// Randomizing the data for training
	data = arma::shuffle(data, 1);

	// Dividing into train (70%) and test (30%) sets
	int rowSize = arma::size(data, 0);
    arma::mat y_train = data.col(2).rows(0, std::floor(rowSize * 0.7));
    arma::mat y_test = data.col(2).rows(std::floor(rowSize * 0.7) + 1,  rowSize - 1);
    
    arma::mat X = mapFeature(data.col(0), data.col(1));
    arma::mat X_train = X.rows(0, std::floor(rowSize * 0.7));
    arma::mat X_test = X.rows(std::floor(rowSize * 0.7) + 1,  rowSize - 1);

    // Training theta with the training set
   	arma::mat theta = normalEquation(&X_train, &y_train);
   
   	// Predicting values for the test set
    arma::mat predicted =  predict(&theta, &X_test);

    // Checking how confidence we are
    return fscore(&predicted, &y_test) > CERTAINTY_THRESHOLD;
}


int main(int argc, const char **argv) {


    int checked = checkConfidence(1);


    return 0;
}
