function test_performance()
fprintf('begin to test performance of BFGS-LLD Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('BFGS-LLD');
cd('..\Algorithm\BFGS-LLD\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\BFGS-LLD\\Performance\\performance.mat"\n');
end

