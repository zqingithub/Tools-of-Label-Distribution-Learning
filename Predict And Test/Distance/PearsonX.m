function distance= PearsonX(prediction,test)
temp=prediction-test;
temp=temp.*temp;
temp=temp./test;
temp=sum(temp,2);
num=size(temp,1);
distance=sum(temp)/num;
end

