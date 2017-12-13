%------------------------------------------------------------------------
% function [time_base, data] = dso_read()
% Version 1.3 H.Sterner
% Date 18.08.2016
% MATLAB Version: 8.6.0.267246 (R2015b)
% Read the Timebase [Seconds]
% Read 1000 floating poind vaues from chanel 1
%------------------------------------------------------------------------
function [time_base, data] = dso_read()
wave = 0;
time_base = 0;

% Find a VISA-TCPIP object.
scope = instrfind('Type', 'visa-tcpip', 'RsrcName', 'TCPIP0::10.0.0.40::inst0::INSTR', 'Tag', '');
% Create the VISA-TCPIP object if it does not exist
% otherwise use the object that was found.
if isempty(scope)
    scope = visa('AGILENT', 'TCPIP0::10.0.0.40::inst0::INSTR');
    % fprintf('is empty\n');
else
    fclose(scope);
    % fprintf('is not empty\n');
end

% festlegen der Ausgangsbuffer size
set (scope,'InputBufferSize',1000000)
set (scope,'OutputBufferSize',1000000)

% Connect to instrument object, obj1.
fopen(scope);

fprintf(scope,':TIMebase:SCALe?');
str_time_base = fscanf(scope);
time_base = str2num(str_time_base);
time_base = time_base;  % 10 times div/sec!

fprintf(scope,':WAV:SOUR CHAN1'); % prepare read wave1
% fprintf(scope,':WAV:SUR CHAN2'); % prepare read wave2
fprintf(scope,':WAV:FORM ASC');
fprintf(scope,':WAV:POIN 1000');
fprintf(scope,':WAV:DATA?');% read waveform1
rawdata = fscanf(scope);
wave = strsplit(rawdata(1,11:end),',');  %den asciistring in cells zerlegen
dtemp = str2mat(wave(:));
data = str2num(dtemp);

fclose(scope);
