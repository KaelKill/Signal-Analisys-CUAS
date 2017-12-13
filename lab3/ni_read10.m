%------------------------------------------------------------------------
% function [time_base, data] = ni_read10()
% Version 1.0 H.Sterner
% Date 18.08.2016
% MATLAB Version: 8.6.0.267246 (R2015b)
% Read 1000 floating poind vaues from chanel 0
% Signal analyse Lab3 10000 points
%------------------------------------------------------------------------

% close all; clear all;
function [time_base, data] = ni_read10()

NumDataPoints = 10000;
SampleRate = 200000;
devices = daq.getDevices;
session = daq.createSession('ni'); 
session.NumberOfScans = NumDataPoints;
session.Rate = SampleRate;

data = zeros(1,NumDataPoints);
dev_size=size(devices);
dev_index = 0;
for n = 1:dev_size(2)
    if strcmp(devices(n).Model,'NI 9215 (BNC)')
        dev_index = n;
    end
end
if dev_index > 0
    fprintf('NI 9215 (BNC) mit device %s gefunden\n',devices(dev_index).ID);
    ch0 = session.addAnalogInputChannel(devices(dev_index).ID,0,'Voltage'); % Channel 0
    data=session.startForeground();
else
    fprintf('Kein modul NI 9215 (BNC) gefunden\n');
end;
session.release();
time_base = 1/(SampleRate/NumDataPoints)/10;