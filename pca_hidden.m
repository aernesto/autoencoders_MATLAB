function [pca_dim,pca_proj]=pca_hidden(trained_network_file)
%returns relevant info for PCA analysis of hidden layer of trained network
load(trained_network_file) 
net.outputConnect=[1 0];%set the readout at the Hidden layer level
load ~/data_MNIST_MATLAB/train1mat.mat%load training data
H=net(train1mat);   %Hidden layer activations under presentation of training data
%PCA computations
[~,score,~,~,explained, ~]=pca(H','Algorithm','eig');
%Find number of eigenvalues that compose 90% of the spectral energy
indices=1:length(explained);
pca_dim=max(indices(cumsum(explained)<90))+1;
pca_proj=score(:,1:3);%projection of the data (in PCA space) onto the first three Principal Components
end