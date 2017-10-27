%% x(t) = -1V*sin(2*pi*10*t) + 2sin(2pi30t)
% fs = 400Hz

close all, clear all, clc;

fs = 500;
dt = 1/fs;
N = 120;
n = 0:dt:(N-1)*dt;

k = (0:(N-1)/2);
f = k*fs/N;

x = -1*sin(2*pi*10*n) + 2*sin(2*pi*30*n);

plot(n, x)

save('signal1.mat', 'x', 'fs')
% 
% clear all, close all, clc
