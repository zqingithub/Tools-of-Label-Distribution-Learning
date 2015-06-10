function predict()
fprintf('begin to predict using PT-SVM\n');
Model=load('../../../Model/PT-SVM/model.mat');
load('../../../DataSet/TestSet.mat');
[~, ~, prediction] = svmpredict(ones(size(X,1),1),X,Model.model,Model.para);
save  '../../../Prediction And Performance/PT-SVM/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\PT-SVM\\Prediction\\prediction.mat"\n');
end