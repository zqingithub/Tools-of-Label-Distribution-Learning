function distance = Squared_Chord(prediction,test)
temp=sqrt(prediction)-sqrt(test);
temp=temp.*temp;
distance=mean(sum(temp,2));
end

