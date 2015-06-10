function test_performance()
fprintf('begin to test performance of AA-BP Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('AA-BP');
cd('..\Algorithm\AA-BP\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\AA-BP\\Performance\\performance.mat"\n');
end

