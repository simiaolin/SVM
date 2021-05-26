 clear all;
 close all;
 X = ( -6:0.2:6)';
 Y = sinc(X) + 0.1.*rand(size(X));

 out = [15 17 19];
 Y(out) = 0.7+0.3*rand(size(out));
 out = [41 44 46];
 Y(out) = 1.5+0.2*rand(size(out));

type = 'RBF_kernel';
 algo = 'simplex';
  costFun = 'rcrossvalidatelssvm';

%  model = initlssvm(X, Y, 'f', [], [], type);
%  costFun = 'crossvalidatelssvm';
%  model = tunelssvm(model, 'simplex', costFun, {10, 'mse';});
%  figure;
%  plotlssvm(model);

 model = initlssvm(X, Y, 'f', [], [ ], type);
 wFun = 'whuber';
 model = tunelssvm(model, algo, costFun, {5, 'mae';},wFun);
 model = robustlssvm(model);
 figure;
 plotlssvm(model);

  wFun = 'whampel';
  model = initlssvm(X, Y, 'f', [], [ ], type);
 model = tunelssvm(model, algo, costFun, {5, 'mae';},wFun);
 model = robustlssvm(model);
 figure;
 plotlssvm(model);
 
 
   wFun = 'wlogistic';
  model = initlssvm(X, Y, 'f', [], [ ], type);
 model = tunelssvm(model, algo, costFun, {5, 'mae';},wFun);
 model = robustlssvm(model);
 figure;
 plotlssvm(model);
 
 
   wFun = 'wmyriad';
  model = initlssvm(X, Y, 'f', [], [ ], type);
 model = tunelssvm(model, algo, costFun, {5, 'mae';},wFun);
 model = robustlssvm(model);
 figure;
 plotlssvm(model);