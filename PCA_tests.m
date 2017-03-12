clear
rng('shuffle')
N=500; %number of observations
data1=zeros(N,3);
data2=zeros(N,3);
data3=zeros(N,3);

%generate data 1 uniformly in 3D cube of radius 1
offset1=[2,4,1];
for i=1:N
    data1(i,:)=2*rand(1,3)-1+offset1;
end
%generate data 2 uniformly in an approximate 2D square (xy-plane) of radius 2
offset2=[2,5,-2];
for i=1:N
    data2(i,:)=[4*rand(1,2)-2,.01*(rand-.5)]+offset2;
end
%generate data 3 uniformly close to a 1D line
offset3=[0,-.5,2];
for i=1:N
    data3(i,:)=[-6*(rand-.5),.01*(rand-.5),0.01*(rand-.5)]+offset3;
end

%plot generated data
subplot(1,3,1)
scatter3(data1(:,1),data1(:,2),data1(:,3))
subplot(1,3,2)
scatter3(data2(:,1),data2(:,2),data2(:,3))
subplot(1,3,3)
scatter3(data3(:,1),data3(:,2),data3(:,3))

%PCA
[coeff1,score1,latent1,tsquared1,explained1, mu1]=pca(data1,'Algorithm','eig');
[coeff2,score2,latent2,tsquared2,explained2, mu1]=pca(data2,'Algorithm','eig');
[coeff3,score3,latent3,tsquared3,explained3, mu1]=pca(data3,'Algorithm','eig');

%Plot data in PCA space
subplot(1,3,1) 
scatter3(score1(:,1),score1(:,2),score1(:,3))
subplot(1,3,2)
scatter3(score2(:,1),score2(:,2),score2(:,3))
subplot(1,3,3)
scatter3(score3(:,1),score3(:,2),score3(:,3))