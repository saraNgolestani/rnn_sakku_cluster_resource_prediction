clc
clear
close all
load F:\Golestani\NNs_Matlab\Sakku\App\data\app_173_train_30_5.mat

k = [6,9,10,11];
for i = 1:4
input_data_mem(:, i) = app_173_data_train(1:end, k(i));
end

output_data_mem(:,:) = app_173_data_train(1:end,3);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.15, 'rloess');
%output_data_mem(:,:) = hampel(output_data_mem,10);


input = input_data_mem';
output = output_data_mem';
net.output.processFcns = {'mapminmax'};
net = feedforwardnet([150 100]);%layrecnet(5,2);%feedforwardnet([7 3]);%feedforwardnet([10 6]);%[15 10 7]
net.trainFcn = 'trainscg';%trainscg trainrp trainoss  trainbr
%net.trainParam.lr=0.1;%0.2
net.trainParam.max_fail=100;%20
net.trainParam.mc=0.01;%0.05
net.trainParam.epochs=2000;%2000
net = train(net,input,output,'useGPU','yes');
%Ws = net.WL;
% save([num2str(i)])
clear output_data_mem  output input input_data_mem input_data_mem1



load F:\Golestani\NNs_Matlab\Sakku\App\data\app_173_test_5_12.mat
for i = 1:4
input_data_mem(:, i) = app_173_data_test(1:end, k(i));
end

output_data_mem(:,:) = app_173_data_test(1:end,3);
%output_data_mem(:,:) = smooth(output_data_mem(:,:),0.1, 'rloess');
%output_data_mem(:,:) = hampel(output_data_mem,10);
input = input_data_mem';

output = net(input);
%output(:,:) = smooth(output(:,:),0.2,'rloess');
actual = output_data_mem';

subplot(1,1,1)
plot(output)
hold on
plot(actual)
legend('Estimated','Actual')
