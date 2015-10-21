function create_summary_latex(decimal_place_mean,decimal_place_std)
fprintf('begin to create the summary of experiment results:\n');
%algorithm={'AA-BP','AA-KNN','BFGS-LLD','CPNN','IIS-LLD','MSVR','PT-Bayes','PT-SVM'};
algorithm={'AA-BP','AA-KNN','BFGS-LLD','IIS-LLD','PT-Bayes','PT-SVM'};
isAscend=[true,true,true,true,false,true];
summary=[];
mean_store=[];
std_store=[];
for i=1:size(algorithm,2)
    load(['../Results/',algorithm{1,i},'/result.mat']);
    mean_store=[mean_store;distance_mean];
    std_store=[std_store;distance_std];
end
for i=1:size(isAscend,2)
    if(~isAscend(1,i))
        mean_store(:,i)=-mean_store(:,i);
    end
end
index=zeros(size(mean_store));
for i=1:size(index,2)
    for j=1:size(index,1)
        index(j,i)=1;
        for k=1:size(index,1)
            if mean_store(k,i)<mean_store(j,i)||(mean_store(k,i)==mean_store(j,i)&&std_store(k,i)<std_store(j,i))
                index(j,i)=index(j,i)+1;
            end
        end
        %summary{j,i+1}=['&',summary{j,i+1},'(',num2str(index(j,i)),')'];
    end
end
for i=1:size(algorithm,2)
    temp_out={[algorithm{1,i}]};
    for k=1:size(distance_mean,2)
%    temp_out=[temp_out,[num2str(roundn(distance_mean(1,k),-decimal_place_mean)), ...
%                '$\pm$',num2str(roundn(distance_std(1,k),-decimal_place_std))]];
%    end
        if mean_store(i,k)<0
            mean_store(i,k)=-mean_store(i,k);
        end
        mean_str=num2str(roundn(mean_store(i,k),-decimal_place_mean));
        std_str=num2str(roundn(std_store(i,k),-decimal_place_std));
        if mean_str(1,1)=='0'
            mean_str=mean_str(1,2:end);
        end
        if std_str(1,1)=='0'
            std_str=std_str(1,2:end);
        end
        if index(i,k)==1
            temp_out=[temp_out,['&\textbf{',mean_str,'$\pm$',std_str,'(1)}']];
        else
            temp_out=[temp_out,['&',mean_str,'$\pm$',std_str,'(',num2str(index(i,k)),')']];
        end
    end
    summary=[summary;temp_out];
end
index_mean={};
for i=1:size(index,1)
    index_mean=[index_mean;num2str(mean(index(i,:)),3)];
end
distance_name=[' ',distance_name,'average rating'];
summary=[summary,index_mean];
summary=[distance_name;summary];
save('../Results/summary_latex.mat','summary');
fprintf('finish\n');
fprintf('the summary table is stored in the file:\n');
fprintf('Tools of Label Distribution Learning\\Experiment\\Results\\summary.mat\n');

end

