function predict()
fprintf('begin to predict using AA-KNN\n');
Model=load('../../../Model/AA-KNN/model.mat');
TestSet=load('../../../DataSet/TestSet.mat');
prediction=my_KNN(Model.X,Model.Y,TestSet.X,TestSet.Y,Model.k);
save  '../../../Prediction And Performance/AA-KNN/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\AA-KNN\\Prediction\\prediction.mat"\n');
end

