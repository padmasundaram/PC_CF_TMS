%
% Fig2A_EfieldProfile.m
% This script will plot Figure 2A.
% It shows the time course of the TMS induced E-field measured
% in saline using a dipole probe
%

load('Data/Fig2A_data.mat');

fs = 500e3; % Sampling Freq
ww = 3.5e-3; % Tip spacing in the E field probe

figure('color','w');
plot(1e3* (times*1e3 - 100.054), -ey/ww, 'Color', 'k', 'LineWidth', 1);
xlim([-100, 500]);
ymin = -50;
L = line([-100,500],[0,0]); set(L, 'Color', 'k', 'LineStyle', ':');
L = line([0,0],[ymin,0]); set(L, 'Color', 'k', 'LineStyle', ':');
L = line([6,6],[ymin,max(-ey/ww)]); set(L, 'Color', 'k', 'LineStyle', ':');
L = line([84,84],[ymin,0]); set(L, 'Color', 'k', 'LineStyle', ':');
L = line([410,410],[ymin,0]); set(L, 'Color', 'k', 'LineStyle', ':');
set(gca, 'YTick', [-max(-ey/ww), 0, max(-ey/ww)])
set(gca, 'YTickLabel', {' ', '0', 'Emax'});
set(gcf, 'Position', [300,200,1600,800]);
xlabel('time (\musec)');
ylabel('E field (V/m)');
set(gca, 'FontSize', 16);

