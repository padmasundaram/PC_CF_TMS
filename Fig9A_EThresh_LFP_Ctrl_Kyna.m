
%--------------------------------------------------------------------------
% Figure 9A
% EThresh-Ctrl-KYNA for single preparation
%
% Using the threshold for the 1.2 ms component from the calibrated studies
% (25.6 V/m) to convert MSO to E-field
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------

ETHRESH1 = 25.6;

plot_setup;

load(fullfile(pwd, "Data", "Fig9A.mat")); 

datestr='Fig9A';
cc = [1,3]; tt = [6,13];
bb = [1,3]; ss = [6,13];
ee = [1,3]; vv = [6,13];
dd = [1,3]; uu = [8,13];
xmin = -1; xmax = 14;

ms = 1e3;
gain=10;
w = 1;
y1=-0.5;y2=+3;
x1=+0.0;x2=12.0;


%--------------------------------------------------------------------------

flag = 0;

tmin=0.8; tmax=10; w=0;
[avgs_ctrl1_thresh_artrem, spk1_ctrl1_resp, spk2_ctrl1_resp, t_fit_ctrl1] = art_rem(strcat(datestr,'-CTRL1'), ctrl1_mso_thresh, times_ctrl1_thresh{1}, avgs_ctrl1_thresh, tmin, tmax, ms, gain, w, flag);
[avgs_ctrl2_thresh_artrem, spk1_ctrl2_resp, spk2_ctrl2_resp, t_fit_ctrl2] = art_rem(strcat(datestr,'-CTRL2'), ctrl2_mso_thresh, times_ctrl2_thresh{1}, avgs_ctrl2_thresh, tmin, tmax, ms, gain, w, flag);

tmin=0.6; tmax=10; w=0;
[avgs_kyna1_thresh_artrem, spk1_kyna1_resp, spk2_kyna1_resp, t_fit_kyna1] = art_rem(strcat(datestr,'-KYNA1'), kyna1_mso_thresh, times_kyna1_thresh{1}, avgs_kyna1_thresh, tmin, tmax, ms, gain, w, flag);

tmin=0.8; tmax=10; w=0;
[avgs_kyna2_thresh_artrem, spk1_kyna2_resp, spk2_kyna2_resp, t_fit_kyna2] = art_rem(strcat(datestr,'-KYNA2'), kyna2_mso_thresh, times_kyna2_thresh{1}, avgs_kyna2_thresh, tmin, tmax, ms, gain, w, flag);

%--------------------------------------------------------------------------
ymin = -1.5; ymax = 8;
lw=1;

figure('Color','w'); hold on;
set(gcf, 'Position', [44 551 717 1245]);

N = min(length(ctrl1_mso_thresh), length(ctrl2_mso_thresh));
avg_CTRL_spk2 = mean([spk2_ctrl1_resp(1:N),spk2_ctrl2_resp(1:N)],2);
std_CTRL_spk2 =  std([spk2_ctrl1_resp(1:N),spk2_ctrl2_resp(1:N)],0,2);
errorbar(ctrl1_mso_thresh(1:N),avg_CTRL_spk2*-1,std_CTRL_spk2,'Marker', 'o', 'MarkerFaceColor', Rd, 'Color',Rd,'LineStyle','None');

spk2_resp = avg_CTRL_spk2;
mso_thresh = ctrl1_mso_thresh(1:N);
[xi,yi,L1,L2] = linexline([mso_thresh(cc(1)), mso_thresh(cc(2))],...
                          [0,0], ...
                          [mso_thresh(tt(1)), mso_thresh(tt(2))],...
                       -1*[spk2_resp(tt(1)),spk2_resp(tt(2))], 1); 
THRESH_SPK2 = xi;
hold on; 
L3 = line([xi,mso_thresh(tt(2))],[yi,-1*spk2_resp(tt(2))]);
L4 = line([xi,0],[yi,0]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Rd);

[slope_ctrl_spk2, se_slope_ctrl_spk2, n_ctrl_spk2] = fit_slope([mso_thresh(tt(1)), mso_thresh(tt(2))], ...
                                                            -1*[spk2_resp(tt(1)),spk2_resp(tt(2))]);

off = 2;
N = min(length(ctrl1_mso_thresh), length(ctrl2_mso_thresh));
avg_CTRL_spk1 = mean([spk1_ctrl1_resp(1:N),spk1_ctrl2_resp(1:N)],2);
std_CTRL_spk1 =  std([spk1_ctrl1_resp(1:N),spk1_ctrl2_resp(1:N)],0,2);
errorbar(ctrl1_mso_thresh(1:N),off + avg_CTRL_spk1*-1,std_CTRL_spk1,'Marker', 'o', 'MarkerFaceColor', Bl, 'Color',Bl,'LineStyle','None');

spk1_resp = avg_CTRL_spk1;
mso_thresh = ctrl1_mso_thresh(1:N);
[xi,yi,L1,L2] = linexline([mso_thresh(bb(1)), mso_thresh(bb(2))],...
                          [0,0]+off, ...
                          [mso_thresh(ss(1)), mso_thresh(ss(2))],...
                       -1*[spk1_resp(ss(1)),spk1_resp(ss(2))] + off, 1); 
THRESH_SPK1 = xi;
hold on; 
L3 = line([xi,mso_thresh(ss(2))],[yi,-1*spk1_resp(ss(2)) + off]);
L4 = line([xi,0],[yi,0+off]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Bl);

[slope_ctrl_spk1, se_slope_ctrl_spk1, n_ctrl_spk1] = fit_slope([mso_thresh(ss(1)), mso_thresh(ss(2))],...
                                                            -1*[spk1_resp(ss(1)),spk1_resp(ss(2))]);

off = 4;
N = min(length(kyna1_mso_thresh), length(kyna2_mso_thresh));
avg_KYNA_spk2 = mean([spk2_kyna1_resp(1:N),spk2_kyna2_resp(1:N)],2);
std_KYNA_spk2 =  std([spk2_kyna1_resp(1:N),spk2_kyna2_resp(1:N)],0,2);
errorbar(kyna1_mso_thresh(1:N),off + avg_KYNA_spk2*-1,std_KYNA_spk2,'Marker', 'o', 'MarkerFaceColor', Or, 'Color',Or,'LineStyle','None');

spk2_resp = avg_KYNA_spk2;
mso_thresh = kyna1_mso_thresh(1:N);
[xi,yi,L1,L2] = linexline([mso_thresh(ee(1)), mso_thresh(ee(2))],...
                          [0,0]+off, ...
                          [mso_thresh(vv(1)), mso_thresh(vv(2))],...
                       -1*[spk2_resp(vv(1)),spk2_resp(vv(2))]+off, 1); 
THRESH_SPK2_KYNA = xi;
hold on; 
L3 = line([xi,mso_thresh(vv(2))],[yi,-1*spk2_resp(vv(2)) + off]);
L4 = line([xi,0],[yi,0+off]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Or);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Or);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Or);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Or);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Or);

[slope_kyna_spk2, se_slope_kyna_spk2, n_kyna_spk2] = fit_slope([mso_thresh(vv(1)), mso_thresh(vv(2))],...
                                                            -1*[spk2_resp(vv(1)),spk2_resp(vv(2))]);

off = 6;
N = min(length(kyna1_mso_thresh), length(kyna2_mso_thresh));
avg_KYNA_spk1 = mean([spk1_kyna1_resp(1:N),spk1_kyna2_resp(1:N)],2);
std_KYNA_spk1 =  std([spk1_kyna1_resp(1:N),spk1_kyna2_resp(1:N)],0,2);
errorbar(kyna1_mso_thresh(1:N),off + avg_KYNA_spk1*-1,std_KYNA_spk1,'Marker', 'o', 'MarkerFaceColor', Bu, 'Color',Bu,'LineStyle','None');

spk1_resp = avg_KYNA_spk1;
mso_thresh = kyna1_mso_thresh(1:N);
[xi,yi,L1,L2] = linexline([mso_thresh(dd(1)), mso_thresh(dd(2))],...
                          [0,0]+off, ...
                          [mso_thresh(uu(1)), mso_thresh(uu(2))],...
                       -1*[spk1_resp(uu(1)),spk1_resp(uu(2))]+off, 1); 
THRESH_SPK1_KYNA = xi;
hold on; 
L3 = line([xi,mso_thresh(uu(2))],[yi,-1*spk1_resp(uu(2)) + off]);
L4 = line([xi,0],[yi,0+off]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bu);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bu);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bu);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bu);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Bu);

[slope_kyna_spk1, se_slope_kyna_spk1, n_kyna_spk1] = fit_slope([mso_thresh(uu(1)), mso_thresh(uu(2))],...
                                                            -1*[spk1_resp(uu(1)),spk1_resp(uu(2))]);


grid off; box on;
xlim([xmin,xmax]);
ylim([ymin,ymax]);
xlabel('MSO (%)');
ylabel('LFP (mV)');
title(datestr);

yy=-0.5;
L = line([THRESH_SPK2,THRESH_SPK2],[yy,0]); set(L, 'Color', Rd, 'LineStyle', '--');
L = line([THRESH_SPK1,THRESH_SPK1],[yy,2]); set(L, 'Color', Bl, 'LineStyle', '--');

L = line([THRESH_SPK2_KYNA,THRESH_SPK2_KYNA],[yy,4]); set(L, 'Color', Or, 'LineStyle', '--');
L = line([THRESH_SPK1_KYNA,THRESH_SPK1_KYNA],[yy,6]); set(L, 'Color', Bu, 'LineStyle', '--');

ax = gca;
xlabel(ax, '');
ax1_pos = get(ax,'Position');
ax2 = axes('Position', ax1_pos + [0 -0.04 0 0]);
ax2.Position(:,4)=0.0010;
ax2.XLim = get(ax,'XLim') * ETHRESH1/THRESH_SPK1;
ax2.XTick = round(((0:15) * ETHRESH1/THRESH_SPK1),1);
ax2.XTick = sort([ax2.XTick, ETHRESH1]); % just so we can see the number
ax2.FontSize = 8; 
xlabel('E (V/m)');


%-------------------------------------------------------------------------------
%--- FUNC:artrem ---------------------------------------------------------------
function [avgs_thresh_artrem, spk1_resp, spk2_resp, t_fit] = art_rem(datestring, mso_thresh, times, avgs_thresh, tmin, tmax, ms, gain, w, flag)
    % figure out the 1 percent artifact
    torig = ms*times;
    yorig = avgs_thresh{1};
    fit_mask = (torig >= tmin) & (torig <= tmax);
    t_fit = torig(fit_mask); t_fit =t_fit';
    y_fit = yorig(fit_mask);
    
    avgs_thresh_artrem = zeros(length(mso_thresh),length(t_fit));
    
    % remove it from the other guys
    for i=1:length(mso_thresh)
        avgs_thresh_artrem(i,:) = avgs_thresh{i}(fit_mask)-y_fit;
    end
    
    if (flag)
        figure('Color','w','Name',datestring); hold on;
        set(gcf, 'position', [96  269 1127 1581]);
        for i=1:length(mso_thresh)
            subplot(ceil(length(mso_thresh)/2),2,i); hold on;
            plot(ms*times, avgs_thresh{i}, 'k:', 'LineWidth', 1);
            plot(t_fit, y_fit,'r:', 'LineWidth', 1);
            plot(t_fit, avgs_thresh_artrem(i,:), 'b', 'LineWidth', 1);
            title(sprintf("%d", mso_thresh(i)));
            ylim([-0.4,0.1]);
            xlim([-5,15]);
            box on;
        end
    end

    %--- thresh . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    indxA=6;
    indxB=14;
    spk1_resp = zeros(length(mso_thresh),1);
    spk2_resp = zeros(length(mso_thresh),1);
    for i=1:length(mso_thresh)
        spk1_resp(i)  = gain*min(avgs_thresh_artrem(i,indxA-w:indxA+w));
        spk2_resp(i)  = gain*min(avgs_thresh_artrem(i,indxB-w:indxB+w));
    end

end 

function [slope, se_slope, n] = fit_slope(x, y)
    x = x(:); y = y(:);
    n = length(x);
    A = [x, ones(n, 1)];
    coeffs = A \ y;
    slope = coeffs(1);

    % Residual standard error
    y_pred = A * coeffs;
    s2 = sum((y - y_pred).^2) / (n - 2);  % MSE

    % Variance of slope = s^2 / sum((x - x_mean)^2)
    se_slope = sqrt(s2 / sum((x - mean(x)).^2));
end
