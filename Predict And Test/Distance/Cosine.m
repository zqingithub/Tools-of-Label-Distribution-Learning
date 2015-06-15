function distance = Cosine(prediction,test)
inner=sum(prediction.*test,2);
len=(sqrt(sum(prediction.*prediction,2))).*(sqrt(sum(test.*test,2)));
distance=mean(inner./len);
end


