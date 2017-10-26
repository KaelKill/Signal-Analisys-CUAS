function display_signal(filename)
    % Display waveform, magnitude, phase and 
    % power spectrum for a input signal
  
    close all, clc
    
    load(filename,'x','fs');
    N = length(x); % number of samples
    timestep = 1/fs;
    t = 0:timestep:(N-1)*timestep;

    plot(t, x), title('Signal in Time Domain');
    xlabel('Time [s]'), ylabel('Amplitude [V]');

    X = fft(x);
    Xamp = abs(X(1:N/2)/N);
    Xamp = 2*Xamp;
    Xamp(1) = Xamp(1)/2;

    Xphase = angle(round(X(1:N/2),6))*180/pi;
    k = 0:N/2-1;
    f = k*fs/N;
    subplot(2,1,1)
    stem(f,Xamp),title('Amplitude Spectrum')
    xlabel('f (Hz)'),ylabel('|X(f)|'),
    subplot(2,1,2)
    stem(f,Xphase),title('Phase Spectrum')
    xlabel('f (Hz)'),ylabel('Phase(f)')

    figure
    Xpower = (Xamp.^2);
    Xpowerdb = mag2db(Xpower);
  
    pmin = min(Xpowerdb)
    pmax = max(Xpowerdb)
    for i = 1:length(Xpowerdb)
        if(Xpowerdb(i) < 0)
            Xpowerdb(i) = 0;
        end
    end
    
    subplot(2,1,1)
    stem(f,Xpower),title('Power Spectrum')
    xlabel('f (Hz)'),ylabel('Power')
    subplot(2,1,2)
    semilogy(f,Xpowerdb,'o'),title('Power Spetrum - dB')
    axis([0 N round(pmax/10, 3) 2*ceil(pmax)])
    xlabel('f (Hz)'),ylabel('Power/db'),grid on
    ax = gca;
    ax.YAxis.TickLabelFormat = '%g/dB'; 
  end