function Train()
load('../../DataSet/TrainSet.mat');
fprintf('begin to train CCPN\n');
% Bulid cpnn structure.
cpnnStructure.hNumber = 50; % the number of hidden layer.
cpnnStructure.iNumber = size(X,2); % the number of input layer.
cpnnStructure.epachs = 400; % the number of iteration times.
cpnnStructure.goal = 5 ; % the number of accuracy to decimal.
cpnnStructure.showResult = true;
h = cpnnStructure.hNumber;
i = cpnnStructure.iNumber;    
on = 1;
% The weight of input layer and hidden layer.
ihw = ( rand ( h , i + 2 ) - 0.5 ) ;
% The weight of hidden layer and output layer.
how = ( rand ( on , h ) - 0.5 ) ; 
cpnnStructure.ihw = ihw;
cpnnStructure.how = how;

% Set parameters in the training of cpnn mode.
para.itaP = 1.2;
para.itaN = 0.5;
% Train the cpnn structure.
model=cpnntrain(X,Y,cpnnStructure,para);
save ../../Model/CPNN/model model;
fprintf('finish\n');
fprintf('the model parameters are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Model\\CCPN\\model.mat"\n');
end

