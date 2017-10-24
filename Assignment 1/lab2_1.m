%% x(t) = 3V*sin(2*pi*50*t)
% fs = 400Hz

close all, clear all, clc;

fs = 400;
dt = 1/fs;
n = 0:dt:199*dt;

x = 3*sin(2*pi*50*n);
x = 3*sin(2*pi*50*n);

plot(n, x)

save('signal1.mat', 'x', 'fs')
clear all