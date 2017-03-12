clear
load /Users/aeradillo/data_MNIST_MATLAB/train1mat.mat
load /Users/aeradillo/data_MNIST_MATLAB/test1mat.mat

MSE_mat=zeros(2,9);
for i=50:50:150
    load(['net_',num2str(i),'_trained.mat']);
    %obtain output of network on train and test sets
    train_output=net(train1mat);
    test_output=net(test1mat);
    %compute MSE on train and test sets
    MSE_train=mse(net,train1mat,train_output);
    MSE_test=mse(net,test1mat,test_output);
    %store on matrix
    MSE_mat(:,round(i/50))=[MSE_train;MSE_test];
end

for i=250:50:350
    load(['sparse_005_',num2str(i),'.mat']);
    %obtain output of network on train and test sets
    train_output=predict(trained_autoenc,train1mat);
    test_output=predict(trained_autoenc,test1mat);
    %compute MSE on train and test sets
    MSE_train=mse(train1mat-train_output);
    MSE_test=mse(test1mat-test_output);
    %store on matrix
    MSE_mat(:,round((i-50)/50))=[MSE_train;MSE_test];
end

for i=250:50:350
    load(['sparse_015_',num2str(i),'.mat']);
    %obtain output of network on train and test sets
    train_output=predict(trained_autoenc,train1mat);
    test_output=predict(trained_autoenc,test1mat);
    %compute MSE on train and test sets
    MSE_train=mse(train1mat-train_output);
    MSE_test=mse(test1mat-test_output);
    %store on matrix
    MSE_mat(:,round((i+100)/50))=[MSE_train;MSE_test];
end