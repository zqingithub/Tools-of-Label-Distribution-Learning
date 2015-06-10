function predict()
fprintf('begin to predict using MSVR\n');
Model=load('../../../Model/MSVR/model.mat');
load('../../../DataSet/TestSet.mat');
Ktest = kernelmatrix(Model.ker,X',Model.train_feature',Model.par);
prediction = Ktest*Model.Beta+repmat(Model.b,size(Ktest,1),1);
prediction=abs(prediction);
prediction=prediction./repmat(sum(prediction,2),1,size(prediction,2));
save  '../../../Prediction And Performance/MSVR/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\MSVR\\Prediction\\prediction.mat"\n');
end

