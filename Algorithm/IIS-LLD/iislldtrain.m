function weights = iislldtrain(para, xTrain, yTrain, varargin)
%IISLLDTRAIN	The training part of IISLLD algorithm.
%
%	Description
%   [WEIGHTS] = IISLLDTRAIN(PARA, XTRAIN, YTRAIN, VARARGIN) is the training
%   part of IISLLD algorithm. This classification is based on the improved 
%   iterative scaling algorithm for maximum entropy models.
%   IISLLD starts with an arbitrary set of parameters. Then for each step, 
%	it updates the current estimate of the parameters ¦È to ¦È+¦¤, where ¦¤ 
%	maximizes a lower bound to the change in likelihood ¦¸ = T(¦È+¦¤)-T(¦È).
%
%	Inputs,
% 		PARA: parameters 
% 		XTRAIN: training examples
%		YTRAIN: training labels
%
%   Outputs,
%       WEIGHTS: the weights that can generate a distribution similar
%       to the distribution of instance x.
%
%   Extended description of input/ouput variables
%   PARA,
%       PARA.MINVALUE : the feature value to replace 0, default: 1e-7
%   	PARA.ITER : learning iterations, default: 50
%       PARA.MINDIFF : minimum log-likelihood difference for convergence, default: 1e-7
%       PARA. REGFACTOR : regularization factor, default: 0
%
%   Others,
%		XTSET: testing examples
%		YTEST: testing labels 
%		NUMCLASS: number of classes
%		CLASSSET: set of class labels such as [1,-1], the first one is the
% 		positive label
%
%	See also
%	IISLLDDEMO, LLDPREDICT
%	
%   Copyright: Xin Geng (xgeng@seu.edu.cn)
%   School of Computer Science and Engineering, Southeast University
%   Nanjing 211189, P.R.China
%

minValue = para.minValue;
maxIter = para.iter;
minDiff = para.minDiff;
[numData, numFeature] = size(xTrain);
numClass = size(yTrain,2);

% Initialize the weights
if ~isempty(varargin)
    weights = varargin{1};
else
    weights=eye(numFeature,numClass);
end
% Avoid zero values in xTrain
% xTrain = ((xTrain == 0) .* minValue + xTrain)';

% Compute the fsum
xSum = sum(abs(xTrain),2);

% Compute the average logarithm conditional likelihood
[avglogliklihoodNew, modProb] = avglogliklihood(weights, xTrain, yTrain);
fprintf('iter:%4d, avglogliklihood:%15.7f\n', 0, avglogliklihoodNew);

for iter = 1:maxIter
   avglogliklihoodOld = avglogliklihoodNew;
   
   % Find optimum delta
   delta = zeros(numFeature, numClass);
   options = optimset('Display','off', 'TolFun', 1e-7);
   for i = 1:numFeature
       for y=1:numClass
           % Compute the delta
           delta(i,y) = fsolve(@betader, 0, options, modProb(:, y), xTrain(:, i), yTrain(:,y), xSum); 
       end
   end
   beta = betadelta(delta, xTrain, yTrain, modProb, xSum);
   weights = weights + delta;
   
   [avglogliklihoodNew, modProb] = avglogliklihood(weights, xTrain, yTrain);
   
   % Print out the avglogliklihood information
   % fprintf('Iter:%4d, avglogliklihood:%15.7f', iter, avglogliklihoodNew);
   fprintf('iter:%4d, avglogliklihood:%15.7f, beta: %15.7f\n', iter, avglogliklihoodNew, beta);
   if (abs(avglogliklihoodOld - avglogliklihoodNew) < minDiff), break; end;       
end


function [avgavglogliklihood, modProb] = avglogliklihood(weights, xTrain, yTrain)

modProb = exp(xTrain * weights);
modProb =modProb./repmat(sum(modProb,2),1,size(modProb,2));
% modProb = modProb + 1e-10 * (modProb <= 0);
avgavglogliklihood = -sum(sum(yTrain.*log(modProb)));
   
   
function bd = betader(delta, modProb, features, yTrain, xSum)

item1 = yTrain'*features;
item2 = sum(modProb.*features.*exp(delta.*sign(features).*xSum));
bd = item1-item2;

function beta = betadelta(delta, xTrain, yTrain, modProb, xSum)

[numData, numClass] = size(yTrain);
item1 = sum(sum(yTrain.*(xTrain*delta)));
temp = zeros(numData, numClass);
for x=1:numData
    temp(x,:) = abs(xTrain(x,:))/xSum(x)*exp(delta*xSum(x).*repmat(sign(xTrain(x,:))',1,numClass));
end    
item2 = sum(sum(modProb.*temp));
beta = numData+item1-item2;
