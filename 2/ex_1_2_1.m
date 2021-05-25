X = (-3:0.2:3)';
Y = sinc(X) + 0.1.*randn(length(X),1);

%%
Xtrain = X(1:2:end);
Ytrain = Y(1:2:end);
Xtest = X(2:2:end);
Ytest = Y(2:2:end);


%%
% gam = 1e6;
% sig2 = 1;
% type = 'function estimation';
% [alpha,b] = trainlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel'});
%%
% 
% Yt = simlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xtest);
% 
%%
% plotlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});
% 
% 
% hold on; plot(min(X):.1:max(X),sinc(min(X):.1:max(X)),'r-.');
% 
% MSE = mean((Yt - Ytest).^2)   % Mean Squared Error
% disp(MSE)

%%



% gamlist = [1e-2 1e-1 1  1e1 1e2 1e3 1e6];
% sig2list = [1e-4 1e-2 1 1e2 1e4];
% 
% MSElist = zeros(length(gamlist),length(sig2list));
% 
% for i=1:length(gamlist)
%     for j=1:length(sig2list)
%         gam = gamlist(i);
%         sig2 = sig2list(j);
%         type = 'function estimation';
%         [alpha,b] = trainlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel'});
%         
%         Yt = simlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xtest);
%         
%         MSElist(i,j) = mean((Yt - Ytest).^2);   % Mean Squared Error
%         
%     end
% end
% 
%%
% cdata = MSElist;
% yvalues = gamlist;
% xvalues = sig2list;
% h = heatmap(xvalues,yvalues,cdata);
% 
% h.Title = 'MSE Results ';
% h.XLabel = 'Sig2';
% h.YLabel = 'Gam';
%%
type = 'f';
kernel_type = 'RBF_kernel';

model = {Xtrain,Ytrain,type,[],[],kernel_type};


[gam,sig2] = tunelssvm(model,'gridsearch','leaveoneoutlssvm', {'mse'});

[alpha,b] = trainlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel'});
        
Yt = simlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xtest);

plotlssvm({Xtrain,Ytrain,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});


hold on; plot(min(X):.1:max(X),sinc(min(X):.1:max(X)),'r-.');
        
MSE = mean((Yt - Ytest).^2);   % Mean Squared Error
disp(gam);
disp(sig2);
disp(MSE);