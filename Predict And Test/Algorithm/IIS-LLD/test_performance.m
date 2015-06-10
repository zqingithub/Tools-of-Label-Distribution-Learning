function test_performance()
fprintf('begin to test performance of IIS-LLD Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('IIS-LLD');
cd('..\Algorithm\IIS-LLD\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\IIS-LLD\\Performance\\performance.mat"\n');
end

