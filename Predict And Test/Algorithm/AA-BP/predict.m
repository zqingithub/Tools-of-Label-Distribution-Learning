function predict()
fprintf('begin to predict using AA-BP\n');
Model=load('../../../Model/AA-BP/model.mat');
load('../../../DataSet/TestSet.mat');
prediction=abs(sim(Model.net,X')');
prediction=prediction./repmat(sum(prediction,2),1,size(prediction,2));
save  '../../../Prediction And Performance/AA-BP/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\AA-BP\\Prediction\\prediction.mat"\n');
end

