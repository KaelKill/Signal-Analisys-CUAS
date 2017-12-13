function display_signal(filename)
% Display an input signal in time domain and amplitude,
% phase and power in frequency domain.

close all, clc;
load(filename, 'x', 'fs');
N = length(x);  % number of samples
dt = 1/fs;      % timestep
n = 0:dt:(N-1)*dt;
figure(1)
plot(n, x), title('Signal in Time Domain'), grid;
xlabel('Time [s]'), ylabel('Amplitude [V]');

%% fft
X = fft(x);
% Power calc
P_time = sum(abs(x.^2));
P_freq = sum(abs(X.^2))/N;
X = 2*fft(x)/N;             % fft normalized
X(1) = X(1)/2;              % DC value correction
X = round(X(1:(N)/2),6);
X_mag = abs(X);             % magnitude of X
X_pha = angle(X)*180/pi;    % phase of X
X_pow = (X_mag).^2;         % power of X
X_powdb = mag2db(X_pow);    % power of X in db
X_powdb(isinf(X_powdb)) = -1000; % -Inf breaks power graphs!
k = (0:(N-1)/2);
f = k*fs/N;
%% Plot magnitude and phase
figure(2)
subplot(2,1,1)
stem(f, X_mag), title('Magnitude Spectrum'), grid
ylabel('Magnitude [V]'), xlabel('Frequency [Hz]')
xlim([0 N])
subplot(2,1,2)
stem(f,X_pha(1:N/2)),title('Phase Spectrum'), grid
ylabel('Phase [deg]'), xlabel('Frequency [Hz]')
axis([0 N -180 180])
set(gca, 'yTick',-180:45:180)
%% Plot power graphs
figure(3)
subplot(2,1,1)
plot(f, X_pow);
title('Power Spectrum'), grid
ylabel('Magnitude [V]'), xlabel('Frequency [Hz]')
xlim([0 N])
subplot(2,1,2)
semilogx(f,X_powdb);
title('Power Spectrum - db'), grid
ylabel('Magnitude [db]'), xlabel('Frequency [Hz]')
xlim([0 N])
ax = gca;
ax.YAxis.TickLabelFormat = '%g/dB';
end
