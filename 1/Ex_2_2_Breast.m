%% 
% Ripley dataset

load breast.mat

Xtrain = trainset;
Ytrain = labels_train;

Xtest = testset;
Ytest = labels_test;
%% 
% Visualize the data. Inspect the data structure: what seems to be important 
% prop-
% 
% erties of the data?
% 
% 30 inputs , binary classification 
% 
% Which classi�cation model do you think you need, based on the
% 
% complexity of the data?
% 
% linear, RBF 
%% Visualize the training data
% 

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

%% Linear model
%% 
% Try out different models (linear, polynomial, RBF kernel) with tuned hyperparameter
% 
% and kernel parameters. Compute the ROC curves. Which model performs best?
% 
% Which model would you choose?
%% 
% Define the model parameters

type = 'c';
kernel_type = 'lin_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};

%% 
% Tuning the parameter

gam = tunelssvm(model,'simplex','leaveoneoutlssvm', {'misclass'});
%% 
% Compute the ROC curves

[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, [],'lin_kernel'});
[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, [],'lin_kernel'},{alpha, b},Xtest);
figure Name 'ROC Linear Kernel'
roc(Ylatent, Ytest);
%% Polynomial model
% 
%% 
% Define the model parameters

type = 'c';
kernel_type = 'poly_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};

%% 
% Tuning the parameter

[gam,sig2] = tunelssvm(model,'simplex','crossvalidatelssvm', {10, 'misclass'});
%% 
% Compute the ROC curves

[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'poly_kernel'});
[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'poly_kernel'},{alpha, b},Xtest);
figure Name 'ROC Poly Kernel'
roc(Ylatent, Ytest);
%% RBF model
% 
%% 
% Define the model parameters

type = 'c';
kernel_type = 'RBF_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};

%% 
% Tuning the parameter

[gam,sig2] = tunelssvm(model,'simplex','crossvalidatelssvm', {10, 'misclass'});

%% 
% Compute the ROC curves

[alpha, b] = trainlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'RBF_kernel'});
[Yest, Ylatent] = simlssvm({ Xtrain , Ytrain , 'c', gam, sig2,'RBF_kernel'},{alpha, b},Xtest);
figure Name 'ROC Poly Kernel'
roc(Ylatent, Ytest);