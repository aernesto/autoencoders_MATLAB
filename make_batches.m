function make_batches(batchsize,range,overlap,nRepeat)
%produce variables related to each batch and saves each batch as a .mat
%file
%ARGUMENTS:
%'batchsize' is the number of cases per batch
%'range' is a 1x2 vector containing the min and max number for images filenames
%   if the training set ranges from file 1 to 60,000, then range=[1,60000]
%'overlap' is a number of cases representing overlap between 2 consec batches
%   overlap must be < batchsize
%'nRepeat' is the number of times that the training set should be looped
%over in order to create the batches.

nRange=range(2)-range(1)+1; %total number of considered image files in the training set

%string of parameters used for created file names
paramString=[num2str(batchsize),'_',...
            num2str(overlap),'_',...
            num2str(range(1)),'-',...
            num2str(range(2))];

nSample=(range(2)-range(1)+1)*nRepeat;
u_bound=(nSample-overlap)/(batchsize-overlap);
nBatches=floor(u_bound); 
%add extra batch if the last case of the last batch is not aligned with
%the last item of nRepeat * training_set
miniBatch=not(u_bound == nBatches); %1 only if an additional batch of 
%smaller size is needed to complete the full presentation of the training set nRepeat times
if miniBatch
    nBatches=nBatches+1;
end

%the strategy for allocating cases to batches is to shuffle
%the indices of the cases in the training set, nRepeat times, and
%append everything in the indices column vector
indices=zeros(nRange*nRepeat,1);

for iteration=1:nRepeat
    shuf_indices=range(1)-1+randperm(nRange);
    indices(1+(iteration-1)*nRange:iteration*nRange)=shuf_indices';
end

for batch_number=1:nBatches
    start_index=(batch_number-1)*(batchsize-overlap)+1;
    if miniBatch
        batchsize=nSample-start_index+1;%number of cases in the last batch
    end
    batch=zeros(196,batchsize);
    for input=1:batchsize
        file_number=indices(start_index+input-1);
        %the following location for .mat file should be changed if the 
        %batch is constructed with cases from the test set
        % '../test_mat_files/test_',...
        file_name=['~/data_MNIST_MATLAB/train_mat_files/train_',...
            num2str(file_number),'.mat'];
        load(file_name)
        batch(:,input)=rmax_train_vector;%rmax_test_vector for test set batch
    end
    save_file=['batches/batch_',...
            paramString,'_',...
            num2str(batch_number),'.mat'];
    save(save_file,'batch','-v7.3')
end
end
