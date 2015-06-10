function TrainData(train_feature,train_data)
tol  = 1e-11;
epsi = 1e-4;
C    = 2;
par  = 1.4*mean(pdist(train_feature));
ker  = 'rbf';
[Beta,~,~,~,b] = msvr(train_feature,train_data,ker,C,epsi,par,tol);
save ../../Model/MSVR/model Beta b ker par train_feature;
end

