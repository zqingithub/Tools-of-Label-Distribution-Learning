function mode = cpnntrain ( feature , target  ,cpnnStructure ,para)
%CPNNTRAIN	The training part of CPNN algorithm.
%
%    Description
%    MODE = CPNNTRAIN(FEATURE,TARGET,CPNNSTRUCTURE,PARA) trains the CPNN
%    structure.
%
%    Statement
%    CPNN is only suitable for totally ordered labels(such as the age),
%    and require label have numerical significance.Thus cannot be applied
%    to the general LDL problem.
%
%    Inputs,
%    FEATURE:the number of input layer of neural network(n*m, 
%    n is the number of sample, m is the number of feature)
%    TARGET:the target variable(n*s,n is the number of sample, s is the
%    number of performance level).
%    CPNNSTRUCTURE:
%      CPNNSTRUCTURE.HNUMBER: the number of hidden layer.
%      CPNNSTRUCTURE.INUMBER: the number of input layer.
%      CPNNSTRUCTURE.EPACHS: the number of iteration times.
%      CPNNSTRUCTURE.GOAL: the number of accuracy to decimal.
%      CPNNSTRUCTURE.SHOWRESULT: whether show the result. True for show, false for not.
%      CPNNSTRUCTURE.IHW:the weight of input layer and hidden layer.
%      CPNNSTRUCTURE.HOW:the weight of hidden layer and output layer.
%    PARA
%      PARA.ITAP:parameters in rprop, itap > 1.0.
%      PARA.ITAN:parameters in rprop, itan > 0.0 and itan < 1.0.
%
%
%    Outpus,
%    MODE:
%      MODE.IHW:the trained weight of input layer and hidden layer.
%      MODE.HOW:the trained weight of hidden layer and output layer.
%      MODE.LEVELNUM:the number of performance level.
%
%    See also
%    CPNN CPNNPREDICT
%
%    Copyright: Xin Geng (xgeng@seu.edu.cn)
%    School of Computer Science and Engineering, Southeast University
%    Nanjing 211189, P.R.China


disp ( 'notice : using entropy...' );
x = feature';
y = 1:size(target,2);
q = size(y,2);
% h1:the number of input layer neural network units
[h1 , k] = size ( x );           
if h1 ~= cpnnStructure.iNumber
    error('input layer number dismatch : Please check' );
end

% on:the number of output layer neural network units
on = 1;
% h2:the number of hidden layer neural network units
h2 = cpnnStructure.hNumber ; 

ihw = cpnnStructure.ihw;
how = cpnnStructure.how ;

epachs = cpnnStructure.epachs;      %iteration time
goal = cpnnStructure.goal;          %accuracy default 50
err = 100000000;                    %error default
iter = 1;
dets = 10000;


% Set parameters in rprop
itaP = 1.2;
itaN = 0.5;
changeHow = zeros ( size ( how ) ) + 0.1;
changeHowMax = zeros ( size ( how ) ) + 50;
changeHowMin = zeros ( size ( how ) ) + exp ( -6);
howDetaIjtNew = zeros ( size ( how ) ) + 0.1;

changeIhw = zeros(size( ihw ) )+0.1 ;
changeIhwMax = zeros( size ( ihw ) )+ 50;
changeIhwMin = zeros ( size ( ihw ) ) + exp ( -6);
ihwDetaIjtNew = zeros ( size ( ihw ) ) + 0.1;

rtable = zeros ( k , q );

% init weight variable quantity matrix
errArray = zeros ( 1 , epachs );
% check to exit the loop
% while ( abs (err) > goal || dets > 50 ) && iter < epachs
while ( abs (err) > goal || iter < epachs  ) 
    if cpnnStructure.showResult == true
        disp( ['   the current epach is  ', num2str( iter ) ] );
    end
    
    ls = 0;
    is = 0;
    for i = 1 : k
        input = [x(: , i ) ; y(1); 1 ];
        for n = 2 : q
            input = [ input [x(: , i ) ; y(n); 1] ];
        end
        iNet = ihw * input;
        io = logsig ( iNet );
        lNet = how * io;
        lo = exp(lNet);
        re = lo;
  
        b = -log ( sum (re));    
        t = target(i,:);
        % coef = (1/(K)).*( t - exp ( b + log (Re )) ) .* -1 .* exp ( b + log (Re) ); 
        % use entropy model
        coef = -t;
        rtable ( i ,: ) =  exp ( b + log (re) );
        
        las = diag ( coef );
        tss = diag( lo );
        
        l = sum ( lo );
        
        local = sum ( how );
        delt = local * logsig(iNet) .* ( 1 - logsig ( iNet ) );
        
        o2a =  sum ( coef ) * lo * io';        
        o1a = sum ( coef ) * delt * tss * input';       
        
        o2b =  sum ( las *io' );       
        o1b =  delt *las* input';

        lsum = -1 * ( o2a ./ l )  + o2b;
        ls = ls +  lsum;

        isum = -1 .* (o1a ./ l )  + o1b;
        is = is +  isum;
        
        samOut( i , : ) = t;
    end
      

  % update weight by rprop
  for ii = 1: on
       for jj = 1:h2
           if ls(ii , jj  ) * changeHow( ii , jj ) > 0
               howDetaIjtNew( ii , jj ) = min ( howDetaIjtNew ( ii , jj )*itaP , changeHowMax ( ii , jj ) );
               howDetaWijt = -sign ( ls ( ii , jj ) ) * howDetaIjtNew( ii , jj ) ;
               how ( ii , jj ) = how ( ii , jj ) + howDetaWijt; 
               changeHow( ii , jj ) = ls ( ii , jj );
           
           elseif ls ( ii, jj ) * changeHow ( ii , jj ) < 0 
               howDetaIjtNew ( ii , jj ) = max ( howDetaIjtNew ( ii , jj )*itaN , changeHowMin ( ii , jj ) );              
               changeHow( ii , jj ) = 0;
               
           elseif ls ( ii ,jj ) * changeHow ( ii , jj )  == 0
               howDetaWijt = -sign ( ls ( ii , jj )) * howDetaIjtNew( ii , jj );
               how ( ii , jj ) = how ( ii , jj ) + howDetaWijt; 
               changeHow( ii , jj ) = ls ( ii , jj );
           end
       end
   end
   
   for ii = 1: h2
       for jj = 1:h1+2   
           if is(ii , jj  ) * changeIhw( ii , jj ) > 0
               ihwDetaIjtNew( ii , jj ) = min ( ihwDetaIjtNew ( ii , jj )*itaP , changeIhwMax ( ii , jj ) );
               ihwDetaWijt = -sign ( is ( ii , jj ) ) * ihwDetaIjtNew( ii , jj ) ;
               ihw ( ii , jj ) = ihw ( ii , jj ) + ihwDetaWijt; 
               changeIhw( ii , jj ) = is ( ii , jj );
           
           elseif is ( ii, jj ) * changeIhw ( ii , jj ) < 0 
               ihwDetaIjtNew ( ii , jj ) = max ( ihwDetaIjtNew ( ii , jj )*itaN , changeIhwMin ( ii , jj ) );              
               changeIhw( ii , jj ) = 0;
               
           elseif is ( ii ,jj ) * changeIhw ( ii , jj )  == 0
               ihwDetaWijt = -sign ( is ( ii , jj )) * ihwDetaIjtNew( ii , jj );
               ihw ( ii , jj ) = ihw ( ii , jj ) + ihwDetaWijt; 
               changeIhw( ii , jj ) = is ( ii , jj );
           end
       end
   end


   % condition to stop training
   diff = samOut - rtable;
   errs = sumsqr( diff );
   % errs = -1*sum ( sum ( samOut.*log(rtable)));
   err = dets  - errs ;
   dets  = errs;
   % errArray( iter )= err;  
   if cpnnStructure.showResult == true
        disp( ['        the error  is  ', num2str( errs ) ] );   
        disp( ['        the difference  is  ', num2str( err ) ] ); 
   end   
   iter = iter + 1;  
end

mode.ihw = ihw;
mode.how = how;
mode.levelNum=q;
