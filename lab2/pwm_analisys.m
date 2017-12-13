clear all, close all, clc

format short eng

N = 1000
range = 19;

filename = 'kael_rect1k_45p.mat'
% filename = 'kael_rect1k_25p.mat'
% filename = 'kael_rect1k_01p.mat'

load(filename);

% filename = 'kael_rect1k_50p.mat'
% filename = 'kael_rect1k_01p.mat'
filename = 'kael_rect1k_99p.mat'
% filename = 'kael_rect1k_25p.mat'
% filename = 'kael_rect1k_75p.mat'
% filename = 'kael_rect1k_45p.mat'
s = load(filename);
signal = s.data;

d1 = round(dutycycle(data)*100);
d2 = round(dutycycle(signal)*100);

nData_points = 1000;
sample_time = time_base*10/nData_points;   
time = 0:sample_time:(time_base*10-sample_time);

figure(1)
plot(time, data, time, signal), grid on;
xlabel('Time [s]'), ylabel('Amplitude [V]');
legend(sprintf('%d%%', d1), sprintf('%d%%', d2))
title('Time signal')

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

Xpow = Xamp.^2;
Xpowdb = mag2db(Xpow);

figure(2)
subplot(2,1,1)
stem(fo(1:range), Xampo(1:range)), hold on, grid on;
stem(f(1:range), Xamp(1:range), '--d'), legend(sprintf('%d%%', d1), sprintf('%d%%', d2));
xlabel('Frequency [Hz]'), ylabel('Amplitude [V]'),
title('Amplitude spectrum')
subplot(2,1,2)
stem(fo(1:range), Xphaseo(1:range)), grid on; hold on;
stem(f(1:range), Xphase(1:range), '--d'),legend(sprintf('%d%%', d1), sprintf('%d%%', d2)),
xlabel('Frequency [Hz]'), ylabel('Phase [º]'),
title('Phase spectrum')
set(gca, 'yTick',-180:90:180)

figure(3)
subplot(2,1,1)
stem(fo(1:range), Xampo(1:range).^2, '--d'), grid on, hold on,
stem(fo(1:range), Xpow(1:range)), legend(sprintf('%d%%', d1), sprintf('%d%%', d2))
xlabel('Frequency [Hz]'), ylabel('Power [W]'),
title('Power spectrum')

subplot(2,1,2)
faux = 10^0:Fs/N:10^6;
fauxo = 10^0:Fs/length(Xo):10^6;
semilogx(faux(1:range), Xpowdb(1:range), '--o'), grid on; hold on
semilogx(fauxo(1:range), mag2db(Xampo(1:range).^2), '--d'),legend(sprintf('%d%%', d1), sprintf('%d%%', d2))
xlabel('Frequency [Hz]'), ylabel('Power [db]'),
title('Power spectrum [db]')
% xlim([10^0 2e3])

t.max = max(data);
t.min = min(data);
t.avg = mean(data);
t.pwr = sum(abs(data).^2)/N;

x.pwr =  sum(abs(Xo).^2)/N^2;
x.dc = Xampo(1)^2;

t1.max = max(signal);
t1.min = min(signal);
t1.avg = mean(signal);
t1.pwr = sum(abs(signal).^2)/N;

x1.pwr =  sum(abs(X).^2)/N^2;
x1.dc = Xamp(1)^2;



t, t1, x, x1
% end