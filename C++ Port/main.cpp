#include <iostream>
#include <armadillo>

#define LAMBDA 1
#define THRESHOLD 0.6
#define DEGREE 5
#define MAPPED_NUM 21

/*
TODO:

-Break up training data into training and CV
-train with training
-predict cv
-ompute the F score
*/



/*
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = ( X1 .^ (i-j) ) .* (X2.^j);
    end
end
*/


// TODO !!! COMPLETE THIS FUNCTION
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
    arma::mat z = *X * *theta;

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

    unsigned long m = arma::size(*X, 0);
    arma::mat normalMatrix = arma::eye<arma::mat>(m, m);
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
arma::mat trainAndPredict(int lightId){
    arma::mat data = generateLightMatrix(lightId);
    arma::mat y = data.col(2);
    arma::mat X = mapFeature(data.col(0), data.col(1));

//    arma::mat theta = normalEquation(&X, &y);
//    arma::mat x_predict = generateWeekOfX();
//    return predict(&theta, &x_predict);

    return X;
}


int main(int argc, const char **argv) {

    // arma::mat predictions = trainAndPredict(0);
    arma::mat x1(10, 1);
    arma::mat x2(10, 1);
    for(int i = 1; i < 11; i++){
        x1(i - 1, 0) = i;
        x2(i - 1, 0) = i + 10;
    }

    arma::mat mapped = mapFeature(x1, x2);
    std::cout << arma::size(mapped) << "\n";
    std::cout << mapped.row(0) << "\n";

    return 0;
}
