function TrainData(train_feature,train_data)
k=1;
temp_train_feature=zeros(size(train_data,1)*size(train_data,2),size(train_feature,2));
temp_train_Prob=zeros(size(train_data,1)*size(train_data,2),1);
temp_train_label=zeros(size(train_data,1)*size(train_data,2),1);
for i=1:size(train_data,1)
    for j=1:size(train_data,2)
        temp_train_feature(k,:)=train_feature(i,:);
        temp_train_Prob(k,:)=train_data(i,j)/size(train_data,1);
        temp_train_label(k,:)=j;
        k=k+1;
    end
end
[train_feature_,train_label_]=resample(temp_train_feature,temp_train_label,temp_train_Prob,size(train_data,2)); 
reduce_size=size(train_data,2);
index=reduce_size/size(train_data,2);
select=rand(size(train_data,1)*size(train_data,2),1);
train_feature_=train_feature_(select<=index,:);
train_label_=train_label_(select<=index,:);
model = svmtrain(train_label_, train_feature_, '-h 0 -b 1');
para='-b 1';
save ../../Model/PT-SVM/model model para;
end
