% function signal_analisys(filename)
clear all, close all, clc

format short eng

% N = 800
N = 1000
range = 17;

% filename = 'kael_cosine_nooffset.mat';
filename = 'kael_sinc.mat'
load(filename);

nData_points = 1000;
sample_time = time_base*10/nData_points;   
time = 0:sample_time:(time_base*10-sample_time);
L = N
% w = rectwin(L);
w = hann(L);
% w = hamming(L);
% w = hanning(L);
% w = blackman(L);
% w = bartlett(L);
% w = kaiser(L);
% w = triang(L);
% w = chebwin(L);

signal = data(1:N).*w;

figure(1)
subplot(2,1,1)
plot(time, data), grid on;
xlabel('Time [s]'), ylabel('Amplitude [V]');
title('Original signal');
subplot(2,1,2)
plot(time(1:N), signal), grid on; hold on
% plot(time(1:N),w), legend('signal', 'window')
xlabel('Time [s]'), ylabel('Amplitude [V]');
title('Windowed signal'), 

Fs = 1/sample_time;
%% fft original
Xo = fft(data);
Xampo = 2*abs(Xo(1:length(Xo)/2+1))/length(Xo);
Xampo(1) = Xampo(1)/2;
Xphaseo = angle(Xo(1:length(Xo)/2+1))*180/pi;

%% fft

f = Fs/2*linspace(0,1,N/2+1);
fo = Fs/2*linspace(0,1,length(Xo)/2+1);
X = fft(signal, N);
Xamp = 2*abs(X(1:(N)/2+1))/N;
Xamp(1) = Xamp(1)/2;
Xphase = angle(X(1:(N)/2+1))*180/pi;
figure(2)
subplot(2,1,1)
stem(f(1:range), Xamp(1:range)), hold on, grid on;
stem(fo(1:range), Xampo(1:range), '--d'),legend('Windowed', 'Original'), 
xlabel('Frequency [Hz]'), ylabel('Amplitude [V]'),
title('Amplitude spectrum')
subplot(2,1,2)
stem(f(1:range), Xphase(1:range)), grid on; hold on;
stem(fo(1:range), Xphaseo(1:range), '--d'),legend('Windowed', 'Original'),
xlabel('Frequency [Hz]'), ylabel('Phase [º]'),
title('Phase spectrum')
set(gca, 'yTick',-180:90:180)

%%
Xpow = Xamp.^2;
Xpowdb = mag2db(Xpow);
figure(3)
subplot(2,1,1)
stem(f(1:range), Xpow(1:range)), grid on; hold on
stem(fo(1:range), Xampo(1:range).^2, '--d'),legend('Windowed', 'Original')
xlabel('Frequency [Hz]'), ylabel('Power [W]'),
title('Power spectrum')

subplot(2,1,2)
faux = 10^0:Fs/N:10^6;
fauxo = 10^0:Fs/length(Xo):10^6;
semilogx(faux(1:range), Xpowdb(1:range), '--o'), grid on; hold on
semilogx(fauxo(1:range), mag2db(Xampo(1:range).^2), '--d'),legend('Windowed', 'Original')
xlabel('Frequency [Hz]'), ylabel('Power [db]'),
title('Power spectrum [db]')
% xlim([10^0 2e3])

t.max = max(signal);
t.min = min(signal);
t.avg = mean(signal);
t.pwr = sum(abs(signal).^2)/N;

x.pwr =  sum(abs(X).^2)/N^2;
x.dc = Xamp(1)^2;

t,x
% end