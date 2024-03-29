clc
clear
close all

load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_30_4.mat

%k = [2,7,12,13,14];
k = [2,6,12,13,14];

for i = 1:5
input_data_cpu(:, i) = Cluster_30_4(1:10:end, k(i));
end

output_data_cpu(:,:) = Cluster_30_4(1:10:end,9);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.4, 'rloess');
output_data_cpu(:,:) = smooth(output_data_cpu(:,:),60,'sgolay',10); 

input = input_data_cpu';
output = output_data_cpu';
net.output.processFcns = {'mapminmax'};
net = layrecnet(2,[100 100 100]);%(4,[90,50,35])
net.trainFcn = 'trainscg';%trainscg trainrp trainoss  trainbr
% net.trainParam.lr=0.2;%0.2
net.trainParam.max_fail=60;%20
% net.trainParam.mc=0.95;%0.05
net.trainParam.epochs=5000;%2000
net = train(net,input,output,'useGPU','yes');
%Ws = net.WL;
% save([num2str(i)])
clear output_data_cpu   output  input   input_data_cpu 



load F:\Golestani\NNs_Matlab\Sakku\Cluster\data\Cluster_5_12.mat

for i = 1:5
input_data_cpu(:,i) = Cluster_5_12(1:10:end, k(i));
end

output_data_cpu(:,:) = Cluster_5_12(1:10:end,9);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.4, 'rloess');
output_data_cpu(:,:) = smooth(output_data_cpu(:,:),50,'sgolay',10);

input = input_data_cpu';
output = net(input);
output(:,:) = smooth(output(:,:),50,'sgolay',10);

actual = output_data_cpu';
%output(:,:) = smooth(output(:,:),0.4,'rloess');


MSE = (sum((abs(actual') - abs(output')).^2))/3001
Max = max(abs((actual') - (output')))


subplot(1,1,1)
plot(output)
hold on
plot(actual)
legend('Estimated','Actual')
