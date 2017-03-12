for i=250:50:350
    tic
    trained_autoenc=train_sparse(i,1,0.15);
    toc
    save(['sparse_015_',num2str(i),'.mat'],'trained_autoenc')
end
