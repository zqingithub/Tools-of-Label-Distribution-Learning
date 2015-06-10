function Train()
load('../../DataSet/TrainSet.mat');
fprintf('begin to train AA-KNN\n');
k=4;
save ../../Model/AA-KNN/model k X Y;
fprintf('finish\n');
fprintf('the model parameters are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Model\\AA-KNN\\model.mat"\n');
end

