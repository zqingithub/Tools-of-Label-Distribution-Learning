function distance = WaveHedges(prediction,test)
temp=(abs(prediction-test))./(max(prediction,test));
distance=mean(sum(temp,2));
end

