
close all, clear all, clc
filename = 'kael_cosine_nooffset.mat'
% filename = 'kael_sinc.mat'
% filename = 'kael_rect1k_50p.mat'
% filename = 'kael_rect1k_01p.mat'
% filename = 'kael_rect1k_99p.mat'
% filename = 'kael_rect1k_25p.mat'
% filename = 'kael_rect1k_75p.mat'
% filename = 'kael_rect1k_45p.mat' % from the ID

% [time_base, data] = dso_read();
% save(filename, 'data', 'time_base');
display_time_signal(filename);
% display_signal(filename);
