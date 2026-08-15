%------------------------------------------------------------------
%
% Fig4_LFP_CSD_KYNA
%
% Generates the laminar LFP and CSD plots
% in the KYNA Condition
% Figures 4AB
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

plot_laminar_profile_fig(LFP_KYNA_Depths, ...
                         LFP_KYNA, ...
                         LFP_KYNA_Times, ...
                         [tmin,tmax], [vmin,vmax]); 
set(gcf,'Name','Fig4A:KYNA LFP'); 
set(gcf, 'Position', pos);

plot_csd_profile_filled_fig(CSD_KYNA_Depths, ...
                            CSD_KYNA, ...
                            CSD_KYNA_Times, ...
                            [tmin,tmax], [jmin,jmax]); 
set(gcf,'Name','Fig4B:Ctrl CSD'); 
set(gcf, 'Position', pos);

