clear all;
close all;
X = (-3:0.01:3)';
Y = sinc(X) + 0.1.*randn(length(X),1);

%%
% Xtrain = X(1:2:end);
% Ytrain = Y(1:2:end);
Xtest = X(2:2:end);
Ytest = Y(2:2:end);


Xtrain = 6.*rand(100, 3) - 3;
Ytrain = sinc(Xtrain(:,1)) + 0.1.*randn(100,1);

sig2= 0.4;
gam= 10;
crit_L1  = bay_lssvm({Xtrain, Ytrain, 'f', gam, sig2}, 1);
crit_L2  = bay_lssvm({Xtrain, Ytrain, 'f', gam, sig2}, 2);
crit_L3= bay_lssvm({Xtrain, Ytrain, 'f', gam, sig2}, 3);


[~,alpha,b] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 1);
[~,gam] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 2);
[~,sig2] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 3);

sig2e = bay_errorbar({Xtrain, Ytrain, 'f', gam, sig2}, 'figure');



[selected, ranking] = bay_lssvmARD({Xtrain, Ytrain, 'f', gam, sig2});

nums = [1,2,3]
ranking = [1,2,3]
bar (nums, ranking)
xlabel("input column")
ylabel("ranking")