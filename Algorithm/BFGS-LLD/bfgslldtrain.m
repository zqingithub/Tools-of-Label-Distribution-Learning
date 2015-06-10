function [weights,fval,exitFlag,output,grad]=bfgslldtrain(funfcn,xInit,optim)
%BFGSLLDTRAIN	The training part of BFGSLLD algorithm.
%
%	Description
%   [WEIGHTS,FVAL,EXITFLAG,OUTPUT,GRAD]=BFGSLLDTRAIN(FUNFCN,XINIT,OPTIM) is the training
%   part of BFGSLLD algorithm. In order to optimize the IIS-LLD algorithm, we follow
%   the idea of an effective quasi-Newton method BFGS to further improve IIS-LLD algorithm. 
%   We can get the weights that can generate a distribution similar to the distribution of instance x.
%
%   Inputs,
%		FUNFCN: Function handle or string which is minimized, returning an
%           error value and optional the error gradient. 
%		XINIT: Initial values of unknowns can be a scalar, vector or matrix
%           (optional)
%		OPTIM: Structure with optimizer options, made by a struct or
%           optimset. (optimset doesnot support all input options)
%
%   Outputs,
%		X : The found location (values) which minimize the function.
%		FVAL : The minimum found
%		EXITFLAG : Gives value, which explain why the minimizer stopt
%		OUTPUT : Structure with all important ouput values and parameters
%		GRAD : The gradient at this location 
%
%   Extended description of input/ouput variables 
%   OPTIONS,
%		OPTIONS.GoalsExactAchieve : If set to 0, a line search method is
%               used which uses a few function calls to do a good line
%               search. When set to 1 a normal line search method with Wolfe 
%				conditions is used (default).
%		OPTIONS.GradConstr, Set this variable to true if gradient calls are
%				cpu-expensive (default). If false more gradient calls are 
%				used and less function calls.
%	    OPTIONS.HessUpdate : If set to 'bfgs'
%				optimization is used (default), when the number of unknowns is 
%				larger then 3000 the function will switch to Limited memory BFGS, 
%				or if you set it to 'lbfgs'. When set to 'steepdesc', steepest 
%				decent optimization is used.
%		OPTIONS.StoreN : Number of itterations used to approximate the Hessian,
%			 	in L-BFGS, 20 is default. A lower value may work better with
%				non smooth functions, because than the Hessian is only valid for
%				a specific position. A higher value is recommend with quadratic equations. 
%		OPTIONS.GradObj : Set to 'on' if gradient available otherwise finited difference
%				is used.
%     	OPTIONS.Display : Level of display. 'off' displays no output; 'plot' displays
%				all linesearch results in figures. 'iter' displays output at  each 
%               iteration; 'final' displays just the final output; 'notify' 
%				displays output only if the function does not converge; 
%	    OPTIONS.TolX : Termination tolerance on x, default 1e-6.
%	    OPTIONS.TolFun : Termination tolerance on the function value, default 1e-6.
%		OPTIONS.MaxIter : Maximum number of iterations allowed, default 400.
% 		OPTIONS.MaxFunEvals : Maximum number of function evaluations allowed, 
%				default 100 times the amount of unknowns.
%		OPTIONS.DiffMaxChange : Maximum stepsize used for finite difference gradients.
%		OPTIONS.DiffMinChange : Minimum stepsize used for finite difference gradients.
%		OPTIONS.OutputFcn : User-defined function that an optimization function calls
%				at each iteration.
%		OPTIONS.rho : Wolfe condition on gradient (c1 on wikipedia), default 0.01.
%		OPTIONS.sigma : Wolfe condition on gradient (c2 on wikipedia), default 0.9. 
%		OPTIONS.tau1 : Bracket expansion if stepsize becomes larger, default 3.
%		OPTIONS.tau2 : Left bracket reduction used in section phase,
%		default 0.1.
%		OPTIONS.tau3 : Right bracket reduction used in section phase, default 0.5.
%   FUNFCN,
%		The speed of this optimizer can be improved by also providing
%   	the gradient at X. Write the FUN function as follows
%   	function [f,g]=FUN(X)
%       	f , value calculation at X;
%   	if ( nargout > 1 )
%       	g , gradient calculation at X;
%   	end
%	EXITFLAG,
%		Possible values of exitFlag, and the corresponding exit conditions
%		are
%  		1, 'Change in the objective function value was less than the specified tolerance TolFun.';
%  		2, 'Change in x was smaller than the specified tolerance TolX.'; 
%  		3, 'Magnitude of gradient smaller than the specified tolerance';
%  		4, 'Boundary fminimum reached.';
%  		0, 'Number of iterations exceeded options.MaxIter or number of function evaluations exceeded options.FunEvals.';
%  		-1, 'Algorithm was terminated by the output function.';
%  		-2, 'Line search cannot find an acceptable point along the current search';
%
%	See also
%	LLDPREDICT, FMINLBFGS
%	
%   Copyright: Xin Geng (xgeng@seu.edu.cn)
%   School of Computer Science and Engineering, Southeast University
%   Nanjing 211189, P.R.China
%

% Read Optimalisation Parameters
if (~exist('optim','var')) 
    % Function is written by D.Kroon University of Twente (Updated Nov. 2010)
    [weights,fval,exitFlag,output,grad] = fminlbfgs(funfcn,xInit);
else
    % Function is written by D.Kroon University of Twente (Updated Nov. 2010)
    [weights,fval,exitFlag,output,grad] = fminlbfgs(funfcn, xInit,optim);
end
end

