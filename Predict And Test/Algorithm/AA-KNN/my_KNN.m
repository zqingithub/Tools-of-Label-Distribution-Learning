% K-Nearest-Neighbor classifier(K-NN classifier)
%Input:
%     train_feature,test_feature are training set and test 
%     set,respectively.
%     train_distribution,test_distribution are label distribution of training
%     set and test set,respectively.
%     k is the number of nearest neighbors
%     Distance_mark: ['Euclidean', 'L2'| 'L1' | 'Cos'] 
%     'Cos' represents Cosine distance.
%Output:
%     result: average distance between true distribuiton and predicted distribution of the test label

function prediction=my_KNN(train_feature,train_distribution,test_feature,test_distribution,k,Distance_mark)
if nargin < 5
    error('Not enought arguments!');
elseif nargin < 6
    Distance_mark='L2';
end
[rows,cols]=size(test_feature);
train_number=size(train_feature, 1);
dist=zeros(train_number,1);
prediction=zeros(size(test_distribution));
for i=1:rows
    test=test_feature(i,:);
    for j=1:train_number
        train=train_feature(j,:);
        V=test-train;
        switch Distance_mark
            case {'Euclidean', 'L2'}
                dist(j,1)=norm(V,2); % Euclead (L2) distance
            case 'L1'
                dist(j,1)=norm(V,1); % L1 distance
            case 'Cos'
                dist(j,1)=acos(test*train'/(norm(test,2)*norm(train,2))); % cos distance
            otherwise
                dist(j,1)=norm(V,2); % Default distance
        end
    end
    [sort_dist,indices] = sort(dist);
    sum_distribution=zeros(1,size(train_distribution,2));
    for j=1:k
        sum_distribution=sum_distribution+train_distribution(indices(j),:);
    end
    prediction(i,:)=sum_distribution/k;
end
prediction=prediction./repmat(sum(prediction,2),1,size(prediction,2));
end