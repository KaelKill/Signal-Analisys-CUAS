%% x(t) = 3V*sin(2*pi*50*t)
% fs = 400Hz

close all, clear all, clc;

% fs = 400;
% N = 200;
% dt = 1/fs;
% n = 0:dt:(N-1)*dt;
% 
% x = 3*sin(2*pi*50*n);

Fs=40;f=4;Ts=1/Fs;T=2;t=0:Ts:T-Ts;N=length(t);
x=2*cos(2*pi*f*t);
fs = Fs
% plot(n, x)

save('signal1.mat', 'x', 'fs')
clear all