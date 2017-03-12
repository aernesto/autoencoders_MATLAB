clear
tic
NetNames=cell(9,1);
NetNames{1}='net_50_trained.mat';
NetNames{2}='net_100_trained.mat';
NetNames{3}='net_150_trained.mat';
NetNames{4}='sparse_005_250.mat';
NetNames{5}='sparse_005_300.mat';
NetNames{6}='sparse_005_350.mat';
NetNames{7}='sparse_015_250.mat';
NetNames{8}='sparse_015_300.mat';
NetNames{9}='sparse_015_350.mat';
HH=zeros(9,1);
HH(4:end)=[250,300,350,250,300,350];%technical detail for indices reference
figure;
for ii=1:3
    subplot(3,3,ii)
    [pca_dim,pca_proj]=pca_hidden(NetNames{ii});
    scatter3(pca_proj(:,1),pca_proj(:,2),pca_proj(:,3));
    title(['h=',num2str(ii*50),', k=',num2str(pca_dim)])
    ax=gca;
    ax.FontSize=15;
end
load ~/data_MNIST_MATLAB/train1mat.mat%load training data
for ii=4:9
    load(NetNames{ii})
    net=create_IH(trained_autoenc);
    H=net(train1mat);   %Hidden layer activations under presentation of training data
    %PCA computations
    [~,score,~,~,explained, ~]=pca(H','Algorithm','eig');
    %Find number of eigenvalues that compose 90% of the spectral energy
    indices=1:length(explained);
    pca_dim=max(indices(cumsum(explained)<90))+1;
    pca_proj=score(:,1:3);%projection of the data (in PCA space) onto the first three Principal Components
    subplot(3,3,ii)
    scatter3(pca_proj(:,1),pca_proj(:,2),pca_proj(:,3));
    title(['h=',num2str(HH(ii)),', k=',num2str(pca_dim)])
    ax=gca;
    ax.FontSize=15;
end
toc