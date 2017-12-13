%------------------------------------------------------------------------
% function display_time_signal10(filename)
% display oszilloscope data
% demonstrates the calculation of sample rate and 
% sample frequency fron oszilloscope data
% further the korrect scaling of the fft plot ist demonstrated
% see also: Fast Fourier transform documentation in Matlab
% Signal analyse Lab3 10000 points
%------------------------------------------------------------------------

function display_time_signal10(filename)
% filename = 'kael_noise_20p_sine1k'
load(filename);
% close all;
% the timebase at the Oszilloscpe = 1.0e-4 Seconds/Division
% => 0.1mS/Div 
% we have 10 divisions, and 1000 Data points
% so we have 1e-4*10 =1e-3 = 1mS at the x-axix
nData_points = 10000;
sample_time = time_base*10/nData_points;   
time = 0:sample_time:(time_base*10-sample_time);

figure(1);
subplot(2,1,1), hold on
plot(time, data); grid on;
xlabel('Time [S]');
ylabel('Amplitude [V]');
title('Time Signal');
subplot(2,1,2), hold on
[C, lag] = xcorr(data, 'coeff');
plot(lag*sample_time, C), grid on
xlabel('Lag')
ylabel('ACF')


Fs = 1/sample_time;
X = fft(data)/nData_points;
f = Fs/2*linspace(0,1,nData_points/2+1);
nFrequency_points = 150;

figure(2);
Xdisp=zeros(1,nData_points);
Xdisp(1) = X(1);
Xdisp(2:end) = 2*abs(X(2:end));

subplot(2,1,1), hold on
[PSD,F] = periodogram(C,[],length(C),Fs);
plot(F, 20*log10(PSD)), grid on
title('PSD');
xlabel('Frequency [Hz]');
ylabel('|Y(f)| [V]');

[X,F] = periodogram(data,[],length(data),Fs, 'power');
subplot(2,1,2), hold on
plot(F, 20*log10(X)), grid on
title('Power Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('|Y(f)| [V]');



