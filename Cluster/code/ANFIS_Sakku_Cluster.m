clc;
clear;
close all;

% Create Time-Series Data
j = 1:2:30;

load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_30_4.mat

k = [2,6,12,13,14];
for i = 1:5
input_data_mem(:, i) = Cluster_30_4(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_30_4(1:10:end,9);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.3, 'rloess');

input = input_data_mem;
output = output_data_mem;
% 
options = genfisOptions('FCMClustering','FISType','sugeno');
options.NumClusters = 250;
options.Exponent = 1.45;
options.MaxNumIteration = 2000;
options.MinImprovement = 1e-5;

fismat=genfis(input,output,options);

clear input output input_data_mem output_data_mem 

load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_5_12.mat
for i = 1:5
input_data_mem(:, i) = Cluster_5_12(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_5_12(1:10:end,9);
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
