clc
close all
% filename = 'kael_noise_20p_sine1k'
% filename = 'kael_noise_10p_sine1k'
% filename = 'kael_noise_5p_sine1k'
% filename = 'kael_noise_1p_sine1k'
% filename = 'kael_noise_01p_sine1k'
% 
filename = 'kael_noise_20p_rect1k'
% filename = 'kael_noise_10p_rect1k'
filename = 'kael_noise_5p_rect1k'
% filename = 'kael_noise_1p_rect1k'
% filename = 'kael_noise_01p_rect1k'

% [time_base, data] = dso_read10();
% save(filename, 'data', 'time_base');
display_time_signal10(filename);

% 9,4,3