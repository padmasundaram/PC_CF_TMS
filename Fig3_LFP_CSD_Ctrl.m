%------------------------------------------------------------------
%
% Fig3_LFP_CSD_Ctrl
%
% Generates the laminar LFP and CSD plots
% in the Ctrl Condition
% Figures 3AB
%
% P. Sundaram Aug 2026
%------------------------------------------------------------------

load(fullfile(pwd, "Data", "Fig3_4_data.mat"));

tmin = -1; % ms
tmax = 10; % ms
vmin = -2.6; % mV
vmax = +2.6; % mV
jmin = -1e4;
jmax = +1e4;
pos = [10 10 600 1680];

plot_laminar_profile_fig(LFP_Ctrl_Depths, ...
                         LFP_Ctrl, ...
                         LFP_Ctrl_Times, ...
                         [tmin,tmax], [vmin,vmax]); 
set(gcf,'Name','Fig3A:Ctrl LFP'); 
set(gcf, 'Position', pos);

plot_csd_profile_filled_fig(CSD_Ctrl_Depths, ...
                            CSD_Ctrl, ...
                            CSD_Ctrl_Times, ...
                            [tmin,tmax], [jmin,jmax]); 
set(gcf,'Name','Fig3B:Ctrl CSD'); 
set(gcf, 'Position', pos);

