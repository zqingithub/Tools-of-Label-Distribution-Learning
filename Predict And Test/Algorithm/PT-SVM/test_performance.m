function test_performance()
fprintf('begin to test performance of PT-SVM Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('PT-SVM');
cd('..\Algorithm\PT-SVM\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\PT-SVM\\Performance\\performance.mat"\n');
end

