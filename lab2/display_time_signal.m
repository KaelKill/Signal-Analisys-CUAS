%------------------------------------------------------------------------
% function display_time_signal(filename)
% display oszilloscope data
% demonstrates the calculation of sample rate and 
% sample frequency fron oszilloscope data
% further the korrect scaling of the fft plot ist demonstrated
% see also: Fast Fourier transform documentation in Matlab
%------------------------------------------------------------------------

function display_time_signal(filename)

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

Fs = 1/sample_time
X = fft(data)/nData_points;
f = Fs/2*linspace(0,1,nData_points/2+1);
nFrequency_points = 50;
figure(2);
Xdisp=zeros(1,nData_points);
Xdisp(1) = X(1);
Xdisp(2:end) = 2*abs(X(2:end));
stem(f(1:nFrequency_points),Xdisp(1:nFrequency_points)); grid on;
% plot(f(1:nFrequency_points),20*log10(2*abs(X(1:nFrequency_points)))); grid on;
title('Single-Sided Amplitude Spectrum of Time Signal');
xlabel('Frequency [Hz]');
ylabel('|Y(f)| [V]');

