%------------------------------------------------------------------
%
% Fig2C_Ctrl_CaFree_TTX.m
%
% This script will plot Figure 2C
% It shows:
% (1) the evoked LFP in normal saline, 
% (2) the evoked LFP in Ca2+ free saline with Mn2+ replacement
% (3) the evoked LFP with 2 uM TTX
%
% All recorded at the same location in the Purkinje Cell Layer
%
% P. Sundaram Aug 2026
%------------------------------------------------------------------


load(fullfile(pwd, "Data", "Fig2C_data.mat"));

ymin = -4; ymax = 1;
ms = 1e3; gain = 10;
pos = [1800,900,1600,800];
tmin = -5; tmax = 15;
lw = 1;
fsz = 14;

redcolor = [202,0,32]/255;
blucolor = [5,113,176]/255;

figure('color', 'w', 'position', pos); hold on;
plot(ctrl_times*ms, ctrl_avg*gain, 'k', 'LineWidth', lw);
plot(cafree_times*ms, cafree_avg*gain, 'Color', blucolor, 'LineWidth', lw);
plot(ttx_times*ms, ttx_avg*gain, 'Color', redcolor, 'LineWidth', lw);
set(gca, 'FontSize', fsz);
lgnd = legend("Ctrl", "Ca2+-free", "TTX"); set(lgnd, "Location", "southeast");
ylim([ymin, ymax]);
xlim([tmin, tmax]);
box on;


