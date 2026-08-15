%
% FigS3_Ctrl_KYNA_TTX.m
% This script will plot Figure S3(A-C)
% It shows:
% (1) the evoked LFP in normal saline, 
% (2) the evoked LFP with excitatory synaptic transmission blocked with 10 mM KYNA
% (3) the evoked LFP with 2 uM TTX
%
% Each is avg of 3 trials
% All recorded at the same location in the Purkinje Cell Layer
%

load(fullfile(pwd, "Data", "Fig2B_data.mat"));

ymin = -3; ymax = 1;
ms = 1e3; gain = 10;
pos = [1800,900,1600,800];
tmin = -5; tmax = 15;
lw = 1;

fsz = 14;

redcolor = [202,0,32]/255;
blucolor = [5,113,176]/255;
aa = 0.2;

std_ctrl = std(ctrl_data*gain,0,2);
std_kyna = std(kyna_data*gain,0,2);
std_ttx  = std( ttx_data*gain,0,2);

figure('color', 'w', 'position', pos, 'Name', 'Supplementary Fig S3(A)'); hold on;
h = shadedErrorBar(ctrl_times*ms, ctrl_avg*gain, std_ctrl); 
set(h.patch, 'FaceColor', 'k', 'FaceAlpha', aa);  set(h.mainLine, 'Color', 'k', 'LineWidth', 1);
h = shadedErrorBar(kyna_times*ms, kyna_avg*gain, std_kyna); 
set(h.patch, 'FaceColor', blucolor, 'FaceAlpha', aa);  set(h.mainLine, 'Color', blucolor, 'LineWidth', 1);
h = shadedErrorBar( ttx_times*ms, ttx_avg*gain, std_ttx);
set(h.patch, 'FaceColor', redcolor, 'FaceAlpha', aa);  set(h.mainLine, 'Color', redcolor, 'LineWidth', 1);
set(gca, 'FontSize', fsz);
ylim([ymin, ymax]);
xlim([tmin, tmax]);
xlabel('time (ms)');
ylabel('LFP at v-500 (mV)');
legend("Ctrl", "KYNA", "TTX");
box on;



