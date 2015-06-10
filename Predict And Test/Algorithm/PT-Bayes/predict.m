function predict()
fprintf('begin to predict using PT-Bayes\n');
Model=load('../../../Model/PT-Bayes/model.mat');
load('../../../DataSet/TestSet.mat');
test_num = size(X,1);
label_num = size(Y,2);
prediction=zeros(test_num,label_num);
for i=1:label_num
    prediction(:,i)=mvnpdf(X,Model.Mu(i,:),Model.Sigma{i,1})*Model.Prior(i,1);
end
total=sum(prediction,2);
for i=1:test_num
    prediction(i,:)=prediction(i,:)/total(i);
end
prediction(isnan(prediction))=1e-9;
prediction(prediction<1e-9)=1e-9;
prediction=prediction./repmat(sum(prediction,2),1,size(prediction,2));
save  '../../../Prediction And Performance/PT-Bayes/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\PT-Bayes\\Prediction\\prediction.mat"\n');
end

