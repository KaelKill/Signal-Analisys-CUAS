%------------------------------------------------------------------------
% function display_time_signal(filename)
% display oszilloscope data
% demonstrates the calculation of sample rate and 
% sample frequency fron oszilloscope data
% further the korrect scaling of the fft plot ist demonstrated
% see also: Fast Fourier transform documentation in Matlab
%------------------------------------------------------------------------

function display_time_signal(filename)

format short eng
load(filename);
close all;
% the timebase at the Oszilloscpe = 1.0e-4 Seconds/Division
% => 0.1mS/Div 
% we have 10 divisions, and 1000 Data points
% so we have 1e-4*10 =1e-3 = 1mS at the x-axix
nData_points = 1000;
sample_time = time_base*10/nData_points;   
time = 0:sample_time:(time_base*10-sample_time);

figure(1);
plot(time, data); grid on;
xlabel('Time [S]');
ylabel('Amplitude [V]');
title('Time Signal');

Fs = 1/sample_time;
X = fft(data)/nData_points;
f = Fs/2*linspace(0,1,nData_points/2+1);
nFrequency_points = 50;
figure(2);
Xdisp=zeros(1,nData_points);
Xdisp(1) = X(1);
Xdisp(2:end) = 2*abs(X(2:end));
Xpha = rad2deg(angle(round(X, 6)));
subplot(2,1,1)
stem(f(1:nFrequency_points),Xdisp(1:nFrequency_points)); grid on;
% plot(f(1:nFrequency_points),20*log10(2*abs(X(1:nFrequency_points)))); grid on;
title('Single-Sided Amplitude Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('|Y(f)| [V]');
subplot(2,1,2)
stem(f(1:nFrequency_points),Xpha(1:nFrequency_points)); grid on;
title('Single-Sided Phase Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('Phase');

figure
Xpow = Xdisp.^2/2;
Xpowdb = 10*log10(Xpow);
subplot(2,1,1)
stem(f(1:nFrequency_points),Xpow(1:nFrequency_points)); grid on;
% plot(f(1:nFrequency_points),20*log10(2*abs(X(1:nFrequency_points)))); grid on;
title('Single-Sided Power Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('Magnitude [V]');

[pks, locs] = findpeaks(Xpowdb(1:nFrequency_points));

subplot(2,1,2)
plot(f(1:nFrequency_points), Xpowdb(1:nFrequency_points)); grid on; hold
% plot(f(locs), pks, 'rv')
title('Single-Sided Power Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('Magnitude [db]');
% xlim([0 N])
ax = gca;
ax.YAxis.TickLabelFormat = '%g/dB';

[XMax, I] = max(Xpow)
Ptotal = sum(abs(fft(data)).^2)/length(data)^2
PDC = Xdisp(1).^2/2
F_frequency = (I-1)*5000
noise_floor = sum(pks)/(length(pks)) - XMax


