function [average_rank rank_X Ff CD] = friedmanTest(X,MODE,q)
    N = size(X,1);
    k = size(X,2);
    if N <= 5 || k <= 2
        disp('error, N or k are not big enough! ');
        Ff = NaN;
    else
        rank_X = zeros(size(X));
        [sort_X, sort_index] = sort(X,2,MODE);
        for i=1:N
            [c2,ia2] = unique(sort_X(i,:),'stable');
            for j=1:size(ia2)-1
                the_index = [ia2(j):(ia2(j+1)-1)];
                the_rank = (ia2(j)+ ia2(j+1)-1)/2;
                rank_X(i,sort_index(i,the_index)) = the_rank;
            end
            %the last ranking 
            the_index = [ia2(end):k];
            the_rank = sum(the_index)/size(the_index,2);
            rank_X(i,sort_index(i,the_index)) = the_rank;
        end
        average_rank = sum(rank_X,1)/N;
        lamda = 12*N/(k*(k+1));
        Xf = lamda*(sum(average_rank.*average_rank) - k*(k+1)*(k+1)/4);
        Ff = (N-1)*Xf/(N*(k-1) - Xf);
        CD = q*sqrt(k*(k+1)/(6*N));

        
        
    end
    
end