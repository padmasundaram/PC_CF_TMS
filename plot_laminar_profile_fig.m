%------------------------------------------------------------------
%
% plot_laminar_profile_filled_fig
%
% This script plots the laminar LFP as a function of depth, time
%
%------------------------------------------------------------------

function fig = plot_laminar_profile_fig(depths, timecourses, times, xlimparam, ylimparam)

N = length(depths);

gain=10;
ms=1e3;

fig=figure('color','w','name','LFP');
set(gcf, 'Position', [180, 27, 571, 2017]);

t=tiledlayout(N,1,'Padding','none','TileSpacing','none');
t.OuterPosition = [0 0 1 1];  

for i=1:N
    nexttile;
    plot(ms*times{i}, gain*timecourses(i,:),'k', 'LineWidth', 1);
    hold on; plot([0,0],ylimparam,'k--');
    ylim(ylimparam); xlim(xlimparam);
    L = line(xlimparam,[0,0]);
    set(L,'LineStyle',':','Color','k');
    box off; axis off;
end

axis on;


