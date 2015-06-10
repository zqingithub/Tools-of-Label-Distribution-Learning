function test_performance()
fprintf('begin to test performance of CPNN Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('CPNN');
cd('..\Algorithm\CPNN\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\CPNN\\Performance\\performance.mat"\n');
end

