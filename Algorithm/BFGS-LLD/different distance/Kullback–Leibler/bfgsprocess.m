function [target,gradient] = bfgsprocess(weights)
%BFGSPROCESS	Calculate the target function and the gradient.
%
%	Description
%   [TARGET,GRADIENT] = BFGSPROCESS(WEIGHTS) calculate the target function and the gradient.
%   The results will be used in the optimization process of BFGSLLD -- BFGSLLDTRAIN.
%   
%   Inputs,
%       WEIGHTS: the weights which will be optimized in BFGSLLDTRAIN
%   Outputs,
%       TARGET:  the target function which will be used in BFGSLLDTRAIN
%       GRADIENT: the gradient which will be used in BFGSLLDTRAIN
% 
%	See also
%	BFGSLLDTRAIN, LLDPREDICT, FMINLBFGS 
%	
%   Copyright: Xin Geng (xgeng@seu.edu.cn)
%   School of Computer Science and Engineering, Southeast University
%   Nanjing 211189, P.R.China
%

load('../../DataSet/TrainSet.mat');
% lambda=0.5;
modProb = exp(X * weights);  % size_sam * size_Y
modProb =modProb./repmat(sum(modProb,2),1,size(modProb,2));
% target = -sum(sum(yTrain.*log(modProb)))+lambda*sum(sum(weights.^2));

% Target function.
target = -sum(sum(Y.*log(modProb)));

% Gradient is optional the gradient
gradient = X'*(modProb - Y);


end
