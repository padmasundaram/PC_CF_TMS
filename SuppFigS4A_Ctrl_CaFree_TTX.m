%
% Fig2C_Ctrl_CaFree_TTX.m
% This script will plot Figure 2C
% It shows:
% (1) the evoked LFP in normal saline, 
% (2) the evoked LFP in Ca2+ free saline with Mn2+ replacement
% (3) the evoked LFP with 2 uM TTX
%
% All recorded at the same location in the Purkinje Cell Layer
%


load(fullfile(pwd, "Data", "Fig2C_data.mat"));

ymin = -4; ymax = 1;
ms = 1e3; gain = 10;
pos = [1800,900,1600,800];
tmin = -5; tmax = 15;
lw = 1;
fsz = 14;

blucolor = [5,113,176]/255;

std_ctrl   = std(ctrl_data*gain,0,2);
std_cafree = std(cafree_data*gain,0,2);
std_ttx    = std( ttx_data*gain,0,2);

figure('color', 'w', 'position', pos); hold on;
h = shadedErrorBar(ctrl_times*ms, ctrl_avg*gain, std_ctrl); aa = 0.2;
set(h.patch, 'FaceColor', 'k', 'FaceAlpha', aa);  set(h.mainLine, 'Color', 'k', 'LineWidth', 1);
h = shadedErrorBar(cafree_times*ms, cafree_avg*gain, std_cafree); 
set(h.patch, 'FaceColor', blucolor, 'FaceAlpha', aa);  set(h.mainLine, 'Color', blucolor, 'LineWidth', 1);
set(gca, 'FontSize', fsz);
legend("Ctrl", "Ca2+-free");
ylim([ymin, ymax]);
xlim([tmin, tmax]);
box on;