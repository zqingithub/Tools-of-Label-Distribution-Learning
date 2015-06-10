function bayes(train_feature,train_label,label_num)
train_num = size(train_label,1);
Mu=zeros(label_num,size(train_feature,2));
Sigma=cell(label_num,1);
Prior=zeros(label_num,1);
tmp_feature=zeros(size(train_feature));
for i=1:label_num
    k=0;
    for j=1:train_num
        if train_label(j)==i
            k=k+1;
            tmp_feature(k,:)=train_feature(j,:);
        end
    end
    mu=mean(tmp_feature(1:k,:));
    prior=k/train_num;
    sigma=cov(tmp_feature(1:k,:));
    sigma=sigma+eye(size(sigma,1))*1e-14;
    Mu(i,:)=mu;
    Sigma{i,1}=sigma;
    Prior(i,1)=prior;
end
save ../../Model/PT-Bayes/model Mu Sigma Prior;
end