load iris.mat
%%
gam=0.3741;
sig2=0.3050;
type='c';
[alpha,b] = trainlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel'});

% Plot the decision boundary of a 2-d LS-SVM classifier
%plotlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});

% Obtain the output of the trained classifier
[Yest, Ylatent] = simlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel'}, {alpha,b}, Xtest);
%roc(Ylatent, Ytest);
bay_modoutClass({Xtrain,Ytrain,type,gam,sig2},'figure');
colorbar()