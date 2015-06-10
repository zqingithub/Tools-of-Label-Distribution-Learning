function Train()
load('../../DataSet/TrainSet.mat');
fprintf('begin to train PT-SVM\n');
TrainData(X,Y);
fprintf('finish\n');
fprintf('the model parameters are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Model\\PT-SVM\\model.mat"\n');
end

