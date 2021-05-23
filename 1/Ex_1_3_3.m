load iris.mat
%%
model = { Xtrain , Ytrain , 'c', [], [],'RBF_kernel'};

algorithm = 'simplex';

tic
[gam ,sig2 , cost] = tunelssvm(model, algorithm, 'crossvalidatelssvm',{10, 'misclass'});
toc

disp(gam);
disp(sig2);
disp(cost);