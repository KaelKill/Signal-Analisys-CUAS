% V = 4.5, offset = 2.25

%% The signal measured on oscilloscope had some error. 
% For a 4.5 V amplitude, the measure was aproximately 4.62 V
% In every MATLAB frequency graph there is a little DC level
% about 0.01 V. Little variations on the frequency are observed too
% Those errors were expected, as we are measuring real signals.

% Agilent DSO-X 2022A Digital Storage Oscilloscope
% Agilent 33500B Waveform generator 
% Osc <--> Fgen

filename = 'kael_sine_nooffset.mat'
% filename = 'kael_sine_offset.mat'
% filename = 'kael_rectangle_nooffset.mat'
% filename = 'kael_rectangle_offset.mat'
% filename = 'kael_triangle_nooffset.mat'
% filename = 'kael_triangle_offset.mat'

% [time_base, data] = dso_read();
% save(filename, 'data', 'time_base');
display_time_signal(filename);
% display_signal(filename)

load(filename);
xMax = max(data)
xMin = min(data)
xAvg = mean(data)
xPower = sum(abs(data).^2)/length(data)
xARV = sum(abs(data))/length(data)
xRMS = sqrt(sum(data.^2)/length(data))
F = xRMS/xARV % form factor
C = max(abs(data))/xRMS
