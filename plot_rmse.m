clear
load net_50_trained.mat
clear net tr
mse50=sqrt(MSE);
clear MSE
load net_100_trained.mat
mse100=sqrt(MSE);
clear net tr MSE
load net_150_trained.mat
mse150=sqrt(MSE);
clear net tr MSE
figure
subplot(3,1,1)
plot(1:3000,mse50,'-')
title('h=50')
ylabel('RMSEn')
ax=gca;
ax.FontSize=20;

subplot(3,1,2)
plot(1:3000,mse100,'-')
title('h=100')
ylabel('RMSEn')
ax=gca;
ax.FontSize=20;
subplot(3,1,3)
plot(1:3000,mse150,'-')
title('h=150')
ylabel('RMSEn')
ax=gca;
ax.FontSize=20;