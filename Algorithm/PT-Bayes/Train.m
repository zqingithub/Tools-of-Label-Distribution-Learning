function Train()
load('../../DataSet/TrainSet.mat');
fprintf('begin to train PT-Bayes\n');
classifier(X,Y);
fprintf('finish\n');
fprintf('the model parameters are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Model\\PT-Bayes\\model.mat"\n');
end

