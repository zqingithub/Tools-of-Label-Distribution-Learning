function cross_validation(Algorithm,times)
fprintf('begin the cross validation in the %s algorithm\n',Algorithm);
load('..\DataSet\DataSet.mat');
storeX=X;
storeY=Y;
n=floor(size(storeX,1)/times);
Distance=[];
if(exist(['..\Record\',Algorithm],'dir')==7)
    rmdir(['..\Record\',Algorithm],'s');
end
mkdir('..\Record\',Algorithm);
for i=1:times
    fprintf('begin the %ith cross validation\n',i);
    X=[storeX(1:n*(i-1),:);storeX(n*i+1:end,:)];
    Y=[storeY(1:n*(i-1),:);storeY(n*i+1:end,:)];
    save ..\..\DataSet\TrainSet X Y;
    X=storeX(n*(i-1)+1:n*i,:);
    Y=storeY(n*(i-1)+1:n*i,:);
    save ..\..\DataSet\TestSet X Y;
    cd(['..\..\Algorithm\',Algorithm,'\']);
    Train();
    cd('..\..\Experiment\Tools\');
    cd(['..\..\Predict And Test\Algorithm\',Algorithm,'\']);
    predict();
    test_performance();
    cd('..\..\..\Experiment\Tools\');
    performance=load(['..\..\Prediction And Performance\',Algorithm,'\Performance\performance.mat']);
    Distance=[Distance;performance.distance];
    mkdir(['..\Record\',Algorithm,'\'],num2str(i));
    copyfile('..\..\DataSet\TestSet.mat',['..\Record\',Algorithm,'\',num2str(i),'\']);
    copyfile(['..\..\Prediction And Performance\',Algorithm,'\Prediction\prediction.mat'],['..\Record\',Algorithm,'\',num2str(i),'\']);
    copyfile(['..\..\Model\',Algorithm,'\model.mat'],['..\Record\',Algorithm,'\',num2str(i),'\']);
end
distance_mean=mean(Distance);
distance_std=std(Distance);
distance_name=performance.distance_name;
save(['..\Results\',Algorithm,'\result.mat'],'distance_mean','distance_std','Distance','distance_name'); 
fprintf('finish\n');
fprintf('the experiment result is stored in the file:\n');
fprintf(['Tools of Label Distribution Learning\\Experiment\\Results\\',Algorithm,'\\result.mat\n']);
fprintf(['the records about training and predicting information of each cross validation \n' ...
    ,'are stored in the path:\n']);
fprintf(['Tools of Label Distribution Learning\\Experiment\\Record\\',Algorithm,'\\\n']);
end

