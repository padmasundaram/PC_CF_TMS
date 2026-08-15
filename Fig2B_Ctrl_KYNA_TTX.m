figure%------------------------------------------------------------------
% 
% Fig2B_Ctrl_KYNA_TTX.m
%
% This script will plot Figure 2B
% It shows:
% (1) the evoked LFP in normal saline, 
% (2) the evoked LFP with excitatory synaptic transmission blocked with 10 mM KYNA
% (3) the evoked LFP with 2 uM TTX
%
% Each is avg of 3 trials
% All recorded at the same location in the Purkinje Cell Layer
%
% P. Sundaram Aug 2026
%------------------------------------------------------------------

load(fullfile(pwd, "Data", "Fig2B_data.mat"));

ymin = -3; ymax = 1;
ms = 1e3; gain = 10;
pos = [1800,900,1600,800];
tmin = -5; tmax = 15;
lw = 1;

fsz = 14;

redcolor = [202,0,32]/255;
blucolor = [5,113,176]/255;

figure('color', 'w', 'position', pos, 'Name', 'Fig 2B'); hold on;
plot(ctrl_times*ms, ctrl_avg*gain, 'k', 'LineWidth', lw);
plot(kyna_times*ms, kyna_avg*gain, 'Color', blucolor, 'LineWidth', lw);
plot( ttx_times*ms, ttx_avg *gain, 'Color', redcolor, 'LineWidth', lw);
set(gca, 'FontSize', fsz);
ylim([ymin, ymax]);
xlim([tmin, tmax]);
xlabel('time (ms)');
ylabel('LFP at v-500 (mV)');
legend("Ctrl", "KYNA", "TTX");
box on;
