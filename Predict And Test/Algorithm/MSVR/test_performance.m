function test_performance()
fprintf('begin to test performance of MSVR Algorithm\n');
cd('..\..\Auxiliary\');
compute_distance('MSVR');
cd('..\Algorithm\MSVR\');
fprintf('finish\n');
fprintf('the outcomes are stored in the file:\n');
fprintf('"Tools of Label Distribution Learning\\Prediction And Performance\\MSVR\\Performance\\performance.mat"\n');
end

