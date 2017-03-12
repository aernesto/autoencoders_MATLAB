function net=create_IH(autoenc)
%transforms an autoencoder object into a 2-layer MLP
net=network;

%number of layers, presence or absence of biases and connections
net.numInputs=1;
net.numLayers=1;
net.biasConnect=1;
net.inputConnect=1;
net.layerConnect=0;
net.outputConnect=1;

%input range
net.inputs{1}.range=repmat([0,1],196,1);

%layers dimensions
net.layers{1}.size=autoenc.HiddenSize;

%select sigmoidal transfer function
net.layers{1}.transferFcn='logsig';

%import weights and biases from autoencoder
net.IW={autoenc.EncoderWeights};
net.b={autoenc.EncoderBiases};
end

