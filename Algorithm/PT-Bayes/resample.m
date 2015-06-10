function [re_feature, re_label] = resample(feature,label,Prob,K)
n = length(label);
c_sum = cumsum(Prob);
select = rand(size(label));
% for i=1:n
%     s = find(c_sum>=select(i), 1 );
%     if(isempty(s))
%         select(i) = 0;
%     else
%         select(i) = s;
%     end
% end

for i=1:n
    temp=ceil(select(i)*(n/K));
    temp2=cumsum(Prob((temp-1)*K+1:temp*K,1));
    s=find(temp2>rand()/(n/K),1);
    if(isempty(s))
        select(i) = 0;
    else
        select(i) = (temp-1)*K+s;
    end
end
select = select(select>0);
re_feature = feature(select,:);
re_label = label(select);