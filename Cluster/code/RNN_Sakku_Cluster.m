clc
clear
close all

load 'data/Cluster_30_4.mat'

k = [2,7,12,13,14];
for i = 1:5
input_data_mem(:, i) = Cluster_30_4(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_30_4(1:10:end,10);
output_data_mem(:,:) = smooth(output_data_mem(:,:),0.4, 'rloess');

input = input_data_mem';
output = output_data_mem';
net.output.processFcns = {'mapminmax'};
net = layrecnet(4,[90,50]);%(4,[90,50,35])
net.trainFcn = 'trainscg';%trainscg trainrp trainoss  trainbr
% net.trainParam.lr=0.2;%0.2
net.trainParam.max_fail=60;%20
% net.trainParam.mc=0.95;%0.05
net.trainParam.epochs=5000;%2000
net = train(net,input,output,'useGPU','yes');
%Ws = net.WL;
% save([num2str(i)])
clear output_data_mem   output  input   input_data_mem 



load data/Cluster_4_7.mat

for i = 1:5
input_data_mem(:,i) = Cluster_4_7(1:10:end, k(i));
end

output_data_mem(:,:) = Cluster_4_7(1:10:end,10);
output_data_mem(:,:) = smooth(output_data_mem(:,:),0.4, 'rloess');

input = input_data_mem';
output = net(input);

actual = output_data_mem';
output(:,:) = smooth(output(:,:),0.4,'rloess');




subplot(1,1,1)
plot(output)
hold on
plot(actual)
legend('Estimated','Actual')
