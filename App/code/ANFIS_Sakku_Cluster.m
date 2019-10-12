clc;
clear;
close all;

load F:\Golestani\NNs_Matlab\Sakku\App\data\app_30_5.mat

k = [6,9,10,11];
for i = 1:4
input_data_mem(:, i) = app_30_5(1:end, k(i));
end

output_data_mem(:,:) = app_30_5(1:end,3);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.3, 'rloess');

input = input_data_mem;
output = output_data_mem;
% 
options = genfisOptions('FCMClustering','FISType','mamdani');
options.NumClusters = 50;
options.Exponent = 1.55;
options.MaxNumIteration = 5000;
options.MinImprovement = 1e-16;

fismat=genfis(input,output,options);

clear input output input_data_mem output_data_mem 

load F:\Golestani\NNs_Matlab\Sakku\App\data\app_5_12.mat
for i = 1:4
input_data_mem(:, i) = app_5_12(1:end, k(i));
end

output_data_mem(:,:) = app_5_12(1:end,3);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.3, 'rloess');

input = input_data_mem;
output = evalfis(input,fismat);
%output(:,:) = smooth(output(:,:),0.3, 'rloess');




subplot(1,1,1)
plot(output)
hold on
plot(output_data_mem)
legend('Estimated','Real')
xlabel('Samples')
ylabel('Position (X axis)')
title('ANFIS')

legend('Actual','Estimated')
