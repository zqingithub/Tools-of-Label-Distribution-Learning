function distance = Kullback_Leibler(prediction,test)
temp=test.*(log(test./prediction));
distance=mean(sum(temp,2));
end

