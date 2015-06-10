function test_performance()
fprintf('begin to test performance of PT-Bayes Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('PT-Bayes');
cd('..\Algorithm\PT-Bayes\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\PT-Bayes\\Performance\\performance.mat"\n');
end

