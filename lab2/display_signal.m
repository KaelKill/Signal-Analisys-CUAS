
% function display_signal(filename)

clear all, close all, clc;

format short eng
filename = 'kael_cosine_nooffset.mat'
% filename = 'kael_sinc.mat'
% filename = 'kael_rect1k_50p.mat'

load(filename);

nData_points = 1000;
N = nData_points*4/5;
% N = nData_points 
sample_time = time_base*10/nData_points;   
time = 0:sample_time:(time_base*10-sample_time);

figure(1)
plot(time(1:N), data(1:N)), grid on;
xlabel('Time [S]');
ylabel('Amplitude [V]');
title('Time Signal');


Fs = 1/sample_time;
X = fft(data, N)/N;
f = Fs/2*linspace(0,1,N/2+1);
nFrequency_points = 50;

Xdisp=zeros(1,N);
Xdisp(1) = X(1);
Xdisp(2:end) = 2*abs(X(2:end));
%%
figure(2);
subplot(2,1,1)
stem(f(1:nFrequency_points),Xdisp(1:1:nFrequency_points)); grid on;
% plot(f(1:nFrequency_points),20*log10(2*abs(X(1:nFrequency_points)))); grid on;
title('Single-Sided Amplitude Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('|Y(f)| [V]');
xlim([0 10e4])

%  
Xpha = angle(X)*180/pi
subplot(2,1,2)
stem(f(1:nFrequency_points),Xpha(1:1:nFrequency_points)); grid on;
title('Single-Sided Phase Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('Phase [º]');
xlim([0 10e4])
set(gca, 'yTick',-180:90:180)

%% Plot power graphs
figure(3)

X_pow = (Xdisp).^2;         % power of X
X_powdb = mag2db(X_pow);    % power of X in db
X_powdb(isinf(X_powdb)) = -1000;

subplot(2,1,1)
stem(f(1:nFrequency_points),X_pow(1:1:nFrequency_points));
title('Power Spectrum'), grid
ylabel('Magnitude [V]'), xlabel('Frequency [Hz]')
xlim([0 10e4])
subplot(2,1,2)
plot(f(1:nFrequency_points),X_powdb(1:1:nFrequency_points));
title('Power Spectrum - db'), grid
ylabel('Magnitude [db]'), xlabel('Frequency [Hz]')
xlim([0 10e4])
ax = gca;
ax.YAxis.TickLabelFormat = '%g/dB';

%%
xMax = max(data)
xMin = min(data)
xAvg = mean(data)
xPower = sum(abs(data).^2)/length(data)
xARV = sum(abs(data))/length(data)
xRMS = sqrt(sum(data.^2)/length(data))
F = xRMS/xARV % form factor
C = max(abs(data))/xRMS

% end