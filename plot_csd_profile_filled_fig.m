%------------------------------------------------------------------
%
% plot_csd_profile_filled_fig
%
% This script plots the CSD filled plots as a function of depth, time
%
%------------------------------------------------------------------

function fig = plot_csd_profile_filled_fig(depths, timecourses, times, xlimparam, ylimparam)

N = length(depths);

gain=10;
ms=1e3;

fig = figure('color','w','name','CSD');
set(gcf, 'Position', [180, 27, 571, 2017]);

tiledlayout(N,1,'Padding','none','TileSpacing','none');

srccolor = [202,   0,  32]/255;
snkcolor = [ 12, 113, 176]/255;

for i=1:N
    nexttile;

    base = gain*timecourses(i,:);

    above = base .* (base >= 0);
    below = base .* (base <= 0);

    area(ms*times{i}, above,'FaceColor',srccolor, 'LineWidth', 1); hold on;
    area(ms*times{i}, below,'FaceColor',snkcolor, 'LineWidth', 1); %,'k');

    L = line(xlimparam,[0,0]);
    set(L,'LineStyle','--','Color','k');
    
    hold on; plot([0,0],ylimparam,'k--');

    ylabel(sprintf('%d',depths(i)));
    box off; axis off;
    ylim(ylimparam); xlim(xlimparam);
end

axis on; % just for the last one

