%% 
% Ripley dataset

close all
clear all

% load ripley.mat  %2 dimension250
load breast.mat  %30 dimemsion *  400
% load diabetes.mat   % 8 dimension 300 



Xtrain = trainset;
Ytrain = labels_train;

Xtest = testset;
Ytest = labels_test;

% Visualize the data. Inspect the data structure: what seems to be important 

rng default % for reproducibility
Y = tsne(Xtrain,'Algorithm','barneshut','NumPCAComponents',2);

figure 
gscatter(Y(:,1),Y(:,2),Ytrain)

%% Visualize the test data
% 

rng default % for reproducibility
Y = tsne(Xtest,'Algorithm','barneshut','NumPCAComponents',2);

figure 
gscatter(Y(:,1),Y(:,2),Ytest)



type = 'c';
kernel_type = 'lin_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};


tic
[gam cost] = tunelssvm(model,'simplex','crossvalidatelssvm', {10, 'misclass'});
[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, [],'lin_kernel'});
toc

[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, [],'lin_kernel'},{alpha, b},Xtest);
roc(Ylatent, Ytest);
disp(gam)
disp(cost)
%% Polynomial model
type = 'c';
kernel_type = 'poly_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};

tic
[gam,sig2, cost] = tunelssvm(model,'simplex','crossvalidatelssvm', {10, 'misclass'});

[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'poly_kernel'});
toc
[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'poly_kernel'},{alpha, b},Xtest);
% figure Name 'ROC Poly Kernel'
disp(gam)
disp(sig2)
disp(cost)
roc(Ylatent, Ytest);

%% RBF model
type = 'c';
kernel_type = 'RBF_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};
tic()
[gam,sig2,cost] = tunelssvm(model,'simplex','crossvalidatelssvm', {10, 'misclass'});


[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'RBF_kernel'});
toc()
[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'RBF_kernel'},{alpha, b},Xtest);
% figure Name 'ROC Poly Kernel'
roc(Ylatent, Ytest);
disp(gam)
disp(sig2)
disp(cost)