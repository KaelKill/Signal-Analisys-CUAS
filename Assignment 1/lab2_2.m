function display_signal.m('signal1.mat')
    % Display waveform, magnitude, phase and 
    % power spectrum for a input signal
  
    clear all, close all, clc;

    load('signal1.mat','x','fs');
    N = length(x); % number of samples

    timestep = 1/fs;
    t = 0:timestep:(N-1)*timestep;

    plot(t, x), title('Signal in Time Domain');
    xlabel('Time [s]'), ylabel('Amplitude [V]');

    X = fft(x);
    Xamp = abs(X(1:N/2)/N);
    Xamp = 2*Xamp;
    Xamp(1) = Xamp(1)/2;

    Xphase = angle(round(X(1:N/2),6));
    k = 0:N/2-1;
    f = k*fs/N;
    subplot(2,1,1)
    plot(f,Xamp),title('Amplitude Spectrum')
    xlabel('f (Hz)'),ylabel('|X(f)|'),
    subplot(2,1,2)
    stem(f,Xphase),title('Phase Spectrum')
    xlabel('f (Hz)'),ylabel('Phase(f)')

    figure
    Xpower = Xamp.^2;
    Xpowerdb = 10*log10(Xamp);
    subplot(2,1,1)
    plot(f,Xpower),title('Power Spectrum')
    xlabel('f (Hz)'),ylabel('Power')
    subplot(2,1,2)
    plot(f,Xpowerdb),title('Power Spetrum - dB')
    xlabel('f (Hz)'),ylabel('Power/db')
    ax = gca;
    ax.YAxis.TickLabelFormat = '%g/dB'; 
end