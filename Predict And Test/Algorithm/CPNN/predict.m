function predict()
fprintf('begin to predict using CPNN\n');
Model=load('../../../Model/CPNN/model.mat');
load('../../../DataSet/TestSet.mat');
x = X';
y = 1:Model.model.levelNum;
ihw = Model.model.ihw;
how = Model.model.how;
q = size ( y,2 );
s= size (x,2);
prediction=zeros(size(Y));
re=zeros(q,1);
for i = 1 : s   
    for n = 1 : q            
        input = [ x(: , i ); y(n); 1 ];
        iNet = ihw * input;
        % the ouput of hidden layer.
        io = 1./(1+exp(-iNet));
        % IO = [ IO( : ) ; 1 ];
        % the output of output layer.
        lNet = how * io;
        % exp(Lnet);
        re ( n ) = exp(lNet);
   end    
   b = -log ( sum (re));
   for n = 1 : q             
        prediction( i ,n) =  exp ( b + log (re(n)  ) );
   end
end
save  '../../../Prediction And Performance/CPNN/Prediction/prediction' prediction;
fprintf('finish\n');
fprintf('the prediction is stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\CPNN\\Prediction\\prediction.mat"\n');
end

