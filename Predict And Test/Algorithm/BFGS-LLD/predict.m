function predict()
fprintf('begin to predict using BFGS-LLD\n');
Model=load('../../../Model/BFGS-LLD/model.mat');
load('../../../DataSet/TestSet.mat');
prediction = exp(X * Model.weights);
prediction=prediction./repmat(sum(prediction,2),1,size(prediction,2));
save  '../../../Prediction And Performance/BFGS-LLD/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\BFGS-LLD\\Prediction\\prediction.mat"\n');
end

