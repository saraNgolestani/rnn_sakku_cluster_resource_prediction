clc;
clear;
close all;


load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_10_13.mat

k = [2,7,12,13,14];
for i = 1:5
input_data_mem(:, i) = Cluster_10_13(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_10_13(1:10:end,10);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),50,'sgolay',10);

%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.3, 'rloess');

input = input_data_mem;
output = output_data_mem;
% 
options = genfisOptions('FCMClustering','FISType','sugeno');
options.NumClusters = 250;
options.Exponent = 1.45;
options.MaxNumIteration = 2000; 
options.MinImprovement = 1e-15;

fismat=genfis(input,output,options);

clear input output input_data_mem output_data_mem 

load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_13_15.mat
for i = 1:5
input_data_mem(:, i) = Cluster_13_15(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_13_15(1:10:end,10);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),50,'sgolay',10);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.3, 'rloess');


input = input_data_mem;
output = evalfis(input,fismat);
%output(:,:) = smooth(output(:,:),50,'sgolay',10);
%output(:,:) = smooth(output(:,:),0.3, 'rloess');


MSE = (sum((abs(output_data_mem) - abs(output)).^2))/3001
Max = max(abs((output_data_mem) - (output)))

subplot(1,1,1)
plot(output)
hold on
plot(output_data_mem)
legend('Estimated','Actual')
xlabel('Minute')
ylabel('Percent CPU (X axis)')
title('ANFIS')

