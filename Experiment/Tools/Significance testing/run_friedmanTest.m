% a_index = [1 4 3 9 8 2 7 5 6 10];
% d_index = [1 2 6 5 3 4 7 8];
% c = a.MacroAveragedRecall;
% c_1 = c([1 2 3 4 6 7 8 9],:);
% c_1 = c_1';
% b_1 = b(:,[1 2 3 4 5 6 7 9]);
% c_2 = c_1(a_index,:);
% c_3 = c_2(:,d_index);
% 
% d = b_1 - c_3;% if zeros , then it's right!

metric=load('ICDM_friedmantest_17_final.mat');
name = fieldnames(metric);  
all_algorithms = [1 2 3 4 7];
the_object = find(all_algorithms==4);
lamda = 0.1;

savedPath = 'C:\Users\GTDer\Desktop\LIABLE\handle\';
resultsFileName = strcat([savedPath 'ICMD_Friedmantest_d17_final_lamda' num2str(lamda) '.txt']);

% define the values, do not change!
all_q = [1.960 2.241 2.394 2.498 2.576 2.638 2.690 2.724 2.773;
        1.645 1.960 2.128 2.241 2.326 2.394 2.450 2.498 2.539];
the_rows = -1;
if lamda == 0.05
    the_rows = 1;
else if lamda == 0.1
        the_rows = 2;
    end
end
q = all_q(the_rows, size(all_algorithms, 2)-1)
%run friedmanTest...
dlmwrite(resultsFileName, ['lamda =' num2str(lamda)], 'delimiter','');
for i=1:size(name)
    if ~strcmp(name{i}, 'Datasets') && ~strcmp(name{i}, 'Algorithms')
        X = metric.(name{i});
        X = X(:,all_algorithms);
        mode = 'descend';
        if strcmp('HammingLoss',name{i}) ||  strcmp('Coverage',name{i}) || strcmp('OneError',name{i}) || strcmp('RankingLoss',name{i}) 
            mode = 'ascend';
        end
        [average_rank, rank_X, Ff, CD] = friedmanTest(X, mode, q);
        dlmwrite(resultsFileName, name{i}, 'delimiter','', '-append');
        dlmwrite(resultsFileName, [average_rank], 'delimiter',' ', '-append');
        average_rank_significant = average_rank - average_rank(the_object);
        for j=1:size(average_rank_significant,2)
            if average_rank_significant(j) >= CD
                average_rank_significant(j) = 1;
            else if average_rank_significant(j) > -CD
                    average_rank_significant(j) = 0;
                else average_rank_significant(j) = -1;
                end
            end
        end
        dlmwrite(resultsFileName, [average_rank_significant],'delimiter',' ', '-append');
        dlmwrite(resultsFileName, [Ff CD],'delimiter',' ', '-append');
%         dlmwrite(['AveragedRank_CDBR.txt'], name{i}, '-append');
%         dlmwrite(['AveragedRank_CDBR.txt'], [rank_X],'delimiter',' ', '-append');
%         dlmwrite(['AveragedRank_CDBR.txt'], [average_rank],'delimiter',' ', '-append');
    end
end