function create_cd()
setName={'alpha_','cdc_','cold_','diau_','dtt_','elu_','expression','expression_small','heat_','human gene','spo5_','spo_','spoem_','Í¼Ïñ','µçÓ°'};
algorithm={'AA-BP','AA-KNN','BFGS-LLD','IIS-LLD','PT-Bayes','PT-SVM'};
distance_name={'WaveHedges','Squared_Chord','PearsonX','Kullback_Leibler','InnerProduct','Chebyshev'};
isAscend={'ascend','ascend','ascend','ascend','descend','ascend'};
store=zeros(size(setName,2),size(algorithm,2),size(distance_name,2));
all_q = [1.960 2.343 2.569 2.728 2.850 2.949 3.031 3.102 3.164;1.645 2.052 2.291 2.459 2.589 2.693 2.780 2.855 2.920];
row=1;%lamda 0.05 row 1;lamda 0.10 row 2
q=all_q(row,size(algorithm,2)-1);
for i=1:size(setName,2)
    path=[setName{1,i},'/Results/'];
    for j=1:size(algorithm,2)
        inPath=[path,algorithm{1,j},'/result.mat'];
        load(inPath);
        for k=1:size(distance_name,2)
            store(i,j,k)=distance_mean(1,k);
        end
    end
end
averageRank=zeros(size(distance_name,2),size(algorithm,2));
CD=zeros(1,size(distance_name,2));
for i=1:size(distance_name,2)
    [averageRank(i,:),~,~,CD(1,i)]=friedmanTest(store(:,:,i),isAscend{1,i},q);
end
save CD_outcome.mat averageRank CD setName algorithm  distance_name;
end

