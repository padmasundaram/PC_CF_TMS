
%--- FUNC:plot_allthresholds ---------------------------------------------------
function plot_allthresholds(datestring, mso_thresh, times, avgs_thresh, ms, gain, pos, Emeasured)

    figure('color','w', 'Position', pos,'Name',datestring);
    for i=1:size(mso_thresh,2)
        subplot(ceil(length(mso_thresh)/2),2,i);
        plot(ms*times, gain*avgs_thresh{i},'k', 'LineWidth', 1);
        ylim([-3,1]);
        xlim([-5,25]);
        title(sprintf("%d %% -> %5.1f", mso_thresh(i),(mso_thresh(i)*Emeasured/5)));
    end

end