load iris.mat
%%
value = [1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3];
gam = value;
sig2 = value;

m = length(gam);
n = length(sig2);

record = zeros(m*n,5);

%%
for i = 1:m
    
    for j = 1:n
        
        model = {Xtrain,Ytrain,'c',gam(i),sig2(j),'RBF_kernel'};
        measure = 'misclass';
        index = (i-1)*m+j;
        
        
        perc = 0.8;
        cost_RS = rsplitvalidate(model, perc, measure);
        
        k = 10;
        cost_CV = crossvalidate(model, k, 'misclass');

        cost_LOO = leaveoneout(model, 'misclass');
        
        record(index,1) = gam(i);
        record(index,2) = sig2(j);
        record(index,3) = cost_RS;
        record(index,4) = cost_CV;
        record(index,5) = cost_LOO;
        
             
    end
end

%%
x = log10(record(:,1));
y = log10(record(:,2));
z1 = record(:,3);
z2 = record(:,4);
z3 = record(:,5);

figure

stem3(x,y,z1, '-r','LineWidth',4);
hold on;
stem3(x,y+0.1,z2, '-g','LineWidth',4);
hold on;
stem3(x,y-0.1,z3, '-b','LineWidth',4);


min_gam = 10000;
min_sig = 10000;
global_min_loss = 100;
for rec = record'
      min_loss = min([rec(3,1), rec(4,1), rec(5,1)]);
      if min_loss < global_min_loss
          global_min_loss = min_loss;
          min_gam = rec(1,1);
          min_sig = rec(2,1);
      end
      
end



xlabel('log10(gam)'); ylabel('log10(sig2)'); zlabel('misclass error');
legend('cost RS','cost CV','cost LOO')
zoom on; grid on;
min_gam
min_sig



%xlim([-3 3])
%ylim([-3 3])
zlim([0 0.6])
%%
% % Random split 
% perc = 0.8;
% 
% cost_RS = rsplitvalidate(model, perc, measure);
% 
%%
% % k-fold crossvalidation
% k = 10;
% cost_CV = crossvalidate(model, k, 'misclass');
% 
%%
% % leave-one-out validation
% cost_LOO = leaveoneout(model, 'misclass');

%%
% % Evaluate the LS-SVM at the given points
% 
% Ypred = simlssvm(model,{alpha,b},Xtest);
% 
%%
% eval = Evaluate(Ytest,Ypred);
% disp('accuracy');
% disp(eval(1));
% 
% % plotconfusion(Ytest',Ypred')
% C = confusionchart(Ytest,Ypred)
% 
%% 
% 

% % plot the LS-SVM results in the environment of the training data 
% 
% plotlssvm(model,{alpha,b});