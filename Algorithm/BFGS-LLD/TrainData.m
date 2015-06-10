function TrainData(train_feature,train_data)
item=ones(size(train_feature,2),size(train_data,2));
[weights,fval] = bfgslldtrain(@bfgsprocess,item);
save ../../Model/BFGS-LLD/model weights;
end
