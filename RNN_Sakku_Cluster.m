clc
clear
close all

load 'data/Cluster_29_30_1_2.mat'

k = [2,7,12,13,14];
for i = 1:5
input_data_mem(:, i) = Cluster_29_30_1_2(:, k(i));
end

output_data_mem(:,:) = Cluster_29_30_1_2(:,10);

input = input_data_mem';
output = output_data_mem';
net.output.processFcns = {'mapminmax'};
net = layrecnet(1,70);%layrecnet(5,2);%feedforwardnet([7 3]);%feedforwardnet([10 6]);%[15 10 7]
net.trainFcn = 'trainrp';%trainscg trainrp trainoss  trainbr
% net.trainParam.lr=0.2;%0.2
net.trainParam.max_fail=70;%20
% net.trainParam.mc=0.95;%0.05
net.trainParam.epochs=5000;%2000
net = train(net,input,output,'useGPU','yes');
%Ws = net.WL;
% save([num2str(i)])
clear output_data_mem   output  input   input_data_mem 



load data/Cluster_3_4.mat

for i = 1:5
output_data_mem(:,:) = Cluster_3_4(:,10);
input = input_data_mem';
output = net(input);

actual = output_data_mem';
input_data_mem(:, i) = Cluster_3_4(:, k(i));
end


subplot(1,1,1)
plot(output)
hold on
plot(actual)
legend('Estimated','Actual')
