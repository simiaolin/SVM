
index = 88;
opt_order = orderlist(index);
disp(opt_order);
opt_gam = gamlist(index);
disp(opt_gam);
opt_sig2 = sig2list(index);
disp(opt_sig2);

Xs = Z(end - opt_order + 1:end , 1);
X = windowize(Z, 1:(opt_order + 1));
Y = X(:, end);
X = X(:, 1:opt_order);

nb = 50;
prediction = predict({X, Y, 'f', opt_gam, opt_sig2,'RBF_kernel'}, Xs, nb);

figure;

hold on;
plot_title = ['Prediction with order: ' num2str(opt_order) ' gam: ' num2str(opt_gam) ' sig2: ' num2str(opt_sig2)];
title(plot_title);
plot(Ztest, 'k');
plot(prediction, 'r');
hold off;