function test_performance()
fprintf('begin to test performance of AA-KNN Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('AA-KNN');
cd('..\Algorithm\AA-KNN\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\AA-KNN\\Performance\\performance.mat"\n');
end

