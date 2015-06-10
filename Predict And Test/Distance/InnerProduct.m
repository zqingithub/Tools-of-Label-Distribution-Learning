function distance=InnerProduct(prediction,test)
temp=prediction.*test;
temp=sum(temp,2);
distance=mean(temp);
end

