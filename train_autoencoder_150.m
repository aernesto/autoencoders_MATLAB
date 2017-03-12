%load initialized NN
clear
tic
load net_150.mat
net=net_150;
%change learning rate
%gamma=1000; %gain rate
% newRate=gamma/batch_number;
%newRate=1000;
%net.trainParam.lr=newRate;
%net.inputWeights{1}.learnParam.lr=newRate;
%net.layerWeights{2,1}.learnParam.lr=newRate;
%net.biases{1}.learnParam.lr=newRate;
%net.biases{2}.learnParam.lr=newRate;


%loop over batches
nBatch=3000;
%nBatch=3000;
MSE=zeros(nBatch,1);
for batch_number=1:nBatch
	load(['batches/batch_500_100_1-60000_20_',num2str(batch_number),'.mat']);
	X=batch;
	[net,tr]=train(net,X,X);

	%obtain output of network on current batch
 	%Y=net(X);
 	%MSE(batch_number)=mse(net,X,Y);
    MSE(batch_number)=tr.perf(end);
	%change learning rate
%     newRate=gamma/batch_number;
% 	net.trainParam.lr=newRate;
%     net.inputWeights{1}.learnParam.lr=newRate; 
%     net.layerWeights{2,1}.learnParam.lr=newRate; 
%     net.biases{1}.learnParam.lr=newRate;
%     net.biases{2}.learnParam.lr=newRate;
end
toc
save('~/autoencoder/net_150_trained.mat','net','tr','MSE','-v7.3')
