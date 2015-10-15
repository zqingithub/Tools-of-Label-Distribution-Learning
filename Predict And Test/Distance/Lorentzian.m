function distance = Lorentzian(prediction,test)
temp=log(abs(prediction-test)+1);
distance=mean(sum(temp,2));
end

