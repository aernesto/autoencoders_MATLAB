function net=create_NN(hiddenSize)
net=network;

%number of layers, presence or absence of biases and connections
net.numInputs=1;
net.numLayers=2;
net.biasConnect=[1;1];
net.inputConnect=[1;0];
net.layerConnect=[0,0;1,0];
net.outputConnect=[0,1];

%input range
net.inputs{1}.range=repmat([0,1],196,1);

%layers dimensions
net.layers{1}.size=hiddenSize;%or anything in 50:50:350
net.layers{2}.size=196;

%select sigmoidal transfer function
net.layers{1}.transferFcn='logsig';
net.layers{2}.transferFcn='logsig';

%Note that automatically the following is true
% net.initFcn='initlay';
% net.layers{1}.initFcn='initwb';
% net.layers{2}.initFcn='initwb';

%random symmetric initialization
net.inputWeights{1,1}.initFcn='rands';
net.layerWeights{2,1}.initFcn='rands';
net.biases{1}.initFcn='rands';
net.biases{2}.initFcn='rands';

%learning rule
%net.trainFcn='traingd'; %gradient descent
net.trainFcn='trainb'; %batch training
net.inputWeights{1}.learnFcn='learngd';
net.layerWeights{2,1}.learnFcn='learngd';
net.biases{1}.learnFcn='learngd';
net.biases{2}.learnFcn='learngd';
%use net.trainParam.lr=<SOME VALUE>
%use net.inputWeights{1}.learnParam.lr=<SAME VALUE>; 
%use net.layerWeights{2,1}.learnParam.lr=<SAME VALUE>; 
%and net.biases{1/2}.learnParam.lr=<SAME VALUE>;
%to set the learning rate. Default is 0.01

net.trainParam.epochs=1; %only one sweep through the batch
net.trainParam.time=1000;%maximum training time 1000 sec. for one batch
net.trainParam.showWindow=false;
net.trainParam.show=NaN;

%initialize the weights and biases
net=init(net);
end

