function compute_distance(Algorithm)
file=['..\..\Prediction And Performance\',Algorithm];
file=[file,'\Prediction\prediction.mat'];
prediction=load(file);
TestSet=load('..\..\DataSet\TestSet.mat');
distance_name={'WaveHedges','Squared_Chord','PearsonX','Kullback_Leibler','InnerProduct','Chebyshev'};
distance=zeros(1,6);
cd('../Distance/');
distance(1,1)=WaveHedges(prediction.prediction,TestSet.Y);
distance(1,2)=Squared_Chord(prediction.prediction,TestSet.Y);
distance(1,3)=PearsonX(prediction.prediction,TestSet.Y);
distance(1,4)=Kullback_Leibler(prediction.prediction,TestSet.Y);
distance(1,5)=InnerProduct(prediction.prediction,TestSet.Y);
distance(1,6)=Chebyshev(prediction.prediction,TestSet.Y);
cd('../Auxiliary/');
file=['..\..\Prediction And Performance\',Algorithm];
file=[file,'\Performance\performance.mat'];
save(file,'distance_name','distance');
end

