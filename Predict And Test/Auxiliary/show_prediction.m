function show_prediction(Algorithm)
file=['..\..\Prediction And Performance\',Algorithm];
file=[file,'\Prediction\prediction.mat'];
prediction=load(file);
TestSet=load('..\..\DataSet\TestSet.mat');
x=1:size(prediction.prediction,2);
xx=1:0.01:size(prediction.prediction,2);
sign=1;
while(sign==1)
    i=ceil(rand()*size(prediction.prediction,1));
    values_a =spline(x,prediction.prediction(i,:),xx);
    values_b =spline(x,TestSet.Y(i,:),xx);
    plot(x,prediction.prediction(i,:),'r*',xx,values_a,'r',x,TestSet.Y(i,:),'go',xx,values_b,'g');
    title('red£ºprediction     green£ºreal');
    sign=input('input a number(type 1 to continue,or to end):');
end
end

