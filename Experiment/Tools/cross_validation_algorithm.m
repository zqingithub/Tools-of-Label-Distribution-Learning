function cross_validation_algorithm()
algorithm={'AA-BP','AA-KNN','BFGS-LLD','CPNN','IIS-LLD','MSVR','PT-Bayes','PT-SVM'};
times=10;
for i=1:size(algorithm,2)
    cross_validation(algorithm{1,i},times);
end
end

