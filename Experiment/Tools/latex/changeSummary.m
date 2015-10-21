function changeSummary()
distance_name={'P-div','Cheb','W-Hedges','KL-div','Loren','Cosine'};
distance_no=[4,7,2,5,3,6];
algorithm_name={'PT-Bayes','PT-SVM','AA-kNN','AA-BP','IIS-LLD','BFGS-LLD'};
algorithm_no=[6,7,3,2,5,4];
data_name={'Artificial','Yeast-alpha','Yeast-cdc','Yeast-elu','Yeast-diau','Yeast-heat','Yeast-spo','Yeast-cold', ...
    'Yeast-dtt','Yeast-spo5','Yeast-spoem','Human Gene','Natural Scene','s-JAFFE','s-BU_3DFE','Movie'};
table=cell(17,7);
table(1,2:7)=algorithm_name;
table(2:17,1)=data_name';
latex=cell(17,1);
store_rank=zeros(size(data_name,2),size(algorithm_name,2));
for i=1:size(distance_name,2)
    latex(1:16,1)=data_name;
    latex{17,1}='Avg. Rank ';
    for j=1:size(data_name,2)
        latex{j,1}=[latex{j,1},' '];
        load([data_name{1,j},'.mat']);
        for k=1:size(algorithm_name,2)
            temp_str=summary{algorithm_no(1,k),distance_no(1,i)};
            table{1+j,1+k}=temp_str;
            latex{j,1}=[latex{j,1},temp_str];
            if temp_str(1,end)==')'
                store_rank(j,k)=temp_str(1,end-1)-'0';
            else
                store_rank(j,k)=1;
            end
        end
        latex{j,1}=[latex{j,1},' \\'];
    end
    avg_rank=mean(store_rank);
    for j=1:size(algorithm_name,2)
        latex{17,1}=[latex{17,1},'&',num2str(avg_rank(1,j))];
    end
    latex{17,1}=[latex{17,1},' \\'];
    save([distance_name{1,i},'.mat'],'table','latex');
end
end

