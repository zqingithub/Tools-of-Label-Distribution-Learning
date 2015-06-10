function classifier(train_feature,train_data)
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
bayes(train_feature_,train_label_,size(train_data,2));
end
