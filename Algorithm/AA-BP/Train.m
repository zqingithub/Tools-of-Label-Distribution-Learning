function Train()
load('../../DataSet/TrainSet.mat');
fprintf('begin to train AA-BP\n');
classifier(X,Y);
fprintf('finish\n');
fprintf('the model parameters are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Model\\AA-BP\\model.mat"\n');
end

