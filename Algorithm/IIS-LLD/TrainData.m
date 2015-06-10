function TrainData(train_feature,train_data)
para.minValue = 1e-4;
para.iter=30;
para.minDiff = 1e-7;
weights = iislldtrain(para,train_feature,train_data);
save ../../Model/IIS-LLD/model weights;
end

