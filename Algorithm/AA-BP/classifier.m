function classifier(train_feature,train_distribution)
net=newff(minmax(train_feature'),[24,60,size(train_distribution,2)],{'tansig','tansig','purelin'},'traingd');
net.trainParam.show=60;
net.trainParam.lr=0.05;
net.trainParam.mc=0.9;
net.trainParam.epochs=6000;
net.trainParam.goal=1e-4;
net=init(net);
net=train(net,train_feature',train_distribution');
save ../../Model/AA-BP/model net;
end