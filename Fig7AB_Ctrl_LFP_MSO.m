% Nov 29 2023
% PC Stimulation 
% Red-Black Polarity
% XY Insert


%--------------------------------------------------------------------------
% Figure 7AB (Prep1)
% Looking at LFP as a function of MSO 
% Looking at specific components as a function of MSO
% MSO converted to E-field using calibration expt in Fig 6.
%
% Showing Prep1: 5% MSO = 40.6 V/m
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------

Emeasured = 40.5859; % from the calibration measurement in Figure 6
plot_setup;

mytitle = 'Prep1';

% sampling rate was 50 KHz
ctrl_mso_thresh = [2,3,4,5,6,8,10,11,13,15,20]; % TMS intensities

load(fullfile(pwd, "Data", "Fig7A_Ctrl_LFP_MSO.mat"));

%--------------------------------------------------------------------------
datestr = 'Fig7';

tmin=0.8; tmax=15; w=5; ms=1e3; gain=100; flag=1;
y1=-0.5;y2=+2;
x1=+0.0;x2=20.0;
pos = [100 100  600 1400];

plot_allthresholds(strcat(datestr,'-A'), ctrl_mso_thresh, times_ctrl_thresh{1}, avgs_ctrl_thresh, ms, gain, pos, Emeasured);

load(fullfile(pwd, "Data", "Fig7B_Ctrl_LFP_MSO.mat")); 

%--------------------------------------------------------------------------
cc = [1,3]; tt = [4,7];
bb = [1,3]; ss = [4,9];
ee = [1,4]; vv = [9,12];

xmin = 0; xmax = 15;
ymin = -0.5; ymax = 1.0;
lw=1;

figure('Color','w', 'Name', datestr); hold on;
set(gcf, 'Position', [44 551 717 1245]);

subplot(311); hold on;
plot(ctrl_mso_thresh,-1*spk2_ctrl_resp, 'Marker', 'o', 'MarkerFaceColor', Rd, 'Color',Rd,'LineStyle','-');
[xi,yi,L1,L2] = linexline([ctrl_mso_thresh(cc(1)), ctrl_mso_thresh(cc(2))],...
                          [0,0], ...
                          [ctrl_mso_thresh(tt(1)), ctrl_mso_thresh(tt(2))],...
                       -1*[spk2_ctrl_resp(tt(1)),spk2_ctrl_resp(tt(2))], 1); 
THRESH_SPK2 = xi;
hold on; 
L3 = line([xi,ctrl_mso_thresh(tt(2))],[yi,-1*spk2_ctrl_resp(tt(2))]);
L4 = line([xi,0],[yi,0]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Rd);
xlim([xmin,xmax]); ylim([ymin,ymax]); grid off; box on;
ylabel('LFP for 2.0 ms component');
ax = gca;
xlabel(ax, '');
ax1_pos = get(ax,'Position');
ax2 = axes('Position', ax1_pos + [0 -0.04 0 0]);
ax2.Position(:,4)=0.0010;
ax2.XLim = get(ax,'XLim') * Emeasured/5;
ax2.XTick = round(((0:15) * Emeasured/5),1);
ax2.FontSize = 8; %fsz;
xlabel('E (V/m)');

subplot(312); hold on;
plot(ctrl_mso_thresh,-1*spk1_ctrl_resp, 'Marker', 'o', 'MarkerFaceColor', Bl, 'Color',Bl,'LineStyle',':');
[xi,yi,L1,L2] = linexline([ctrl_mso_thresh(bb(1)), ctrl_mso_thresh(bb(2))],...
                          [0,0], ...
                          [ctrl_mso_thresh(ss(1)), ctrl_mso_thresh(ss(2))],...
                       -1*[spk1_ctrl_resp(ss(1)),spk1_ctrl_resp(ss(2))], 1); 
THRESH_SPK1 = xi;
hold on; 
L3 = line([xi,ctrl_mso_thresh(ss(2))],[yi,-1*spk1_ctrl_resp(ss(2))]);
L4 = line([xi,0],[yi,0]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Bl);
xlim([xmin,xmax]); ylim([ymin,4]); grid off; box on;
ylabel('LFP for 1.2 ms component');
ax = gca;
xlabel(ax, '');
ax1_pos = get(ax,'Position');
ax2 = axes('Position', ax1_pos + [0 -0.04 0 0]);
ax2.Position(:,4)=0.0010;
ax2.XLim = get(ax,'XLim') * Emeasured/5;
ax2.XTick = round(((0:15) * Emeasured/5),1);
ax2.FontSize = 8; %fsz;
xlabel('E (V/m)');


subplot(313); hold on;
plot(ctrl_mso_thresh,-1*spkw_ctrl_resp, 'Marker', 'o', 'MarkerFaceColor', Gr, 'Color',Gr,'LineStyle',':');
[xi,yi,L1,L2] = linexline([ctrl_mso_thresh(ee(1)), ctrl_mso_thresh(ee(2))],...
                          [0,0], ...
                          [ctrl_mso_thresh(vv(1)), ctrl_mso_thresh(vv(2))],...
                       -1*[spkw_ctrl_resp(vv(1)),spkw_ctrl_resp(vv(2))], 1); 
THRESH_SPKW = xi;
hold on; 
L3 = line([xi,ctrl_mso_thresh(vv(2))],[yi,-1*spkw_ctrl_resp(vv(2))]);
L4 = line([xi,0],[yi,0]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Gr);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Gr);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Gr);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Gr);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Gr);
xlim([xmin,xmax]); ylim([ymin,ymax]); grid off; box on;
ylabel('LFP for 5.0 ms component');
ax = gca;
xlabel(ax, '');
ax1_pos = get(ax,'Position');
ax2 = axes('Position', ax1_pos + [0 -0.04 0 0]);
ax2.Position(:,4)=0.0010;
ax2.XLim = get(ax,'XLim') * Emeasured/5;
ax2.XTick = round(((0:15) * Emeasured/5),1);
ax2.FontSize = 8; 
xlabel('E (V/m)');


aa= 0.1;
xmin = 0; xmax = 15;
ymin = -0.5; ymax = 5;
lnstylefit='-';
lw=2;

figure('Color','w', 'Name', strcat(datestr,'B-top')); hold on;
set(gcf, 'Position', [44 551 717 1245]);

plot(ctrl_mso_thresh,-1*spk2_ctrl_resp, 'k'); %, 'Marker', 'o', 'MarkerFaceColor', Rd, 'Color',Rd,'LineStyle','None');
[xi,yi,L1,L2] = linexline([ctrl_mso_thresh(cc(1)), ctrl_mso_thresh(cc(2))],...
                          [0,0], ...
                          [ctrl_mso_thresh(tt(1)), ctrl_mso_thresh(tt(2))],...
                       -1*[spk2_ctrl_resp(tt(1)),spk2_ctrl_resp(tt(2))], 1); 
THRESH_SPK2 = xi;
hold on; 
L3 = line([xi,ctrl_mso_thresh(tt(2))],[yi,-1*spk2_ctrl_resp(tt(2))]);
L4 = line([xi,0],[yi,0]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Rd);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Rd);
L = line([THRESH_SPK2, THRESH_SPK2], [ymin,yi]); set(L, 'Color', Rd, 'LineStyle', '--', 'LineWidth', 1);

%----
k = (ymax-ymin)/9; 
plot(ctrl_mso_thresh,-1*spk1_ctrl_resp+k, 'k'); 
[xi,yi,L1,L2] = linexline([ctrl_mso_thresh(bb(1)), ctrl_mso_thresh(bb(2))],...
                          [0,0]+k, ...
                          [ctrl_mso_thresh(ss(1)), ctrl_mso_thresh(ss(2))],...
                       -1*[spk1_ctrl_resp(ss(1)),spk1_ctrl_resp(ss(2))]+k, 1); 
THRESH_SPK1 = xi;
hold on; 
L3 = line([xi,ctrl_mso_thresh(ss(2))],[yi,-1*spk1_ctrl_resp(ss(2))+k]);
L4 = line([xi,0],[yi,0+k]);
set(L1, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L2, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L3, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
set(L4, 'LineWidth', lw, 'LineStyle', lnstylefit, 'Color', Bl);
plot(xi,yi,'ko', 'MarkerSize', 15, 'MarkerFaceColor', Bl);
L = line([THRESH_SPK1, THRESH_SPK1], [ymin,yi]); set(L, 'Color', Bl, 'LineStyle', '--', 'LineWidth', 1);

xlim([xmin,xmax]); ylim([ymin,ymax]); grid off; box on;

ylabel('LFP at v-500');
ax = gca;
xlabel(ax, '');
ax1_pos = get(ax,'Position');
ax2 = axes('Position', ax1_pos + [0 -0.04 0 0]);
ax2.Position(:,4)=0.0010;
ax2.XLim = get(ax,'XLim') * Emeasured/5;
ax2.XTick = round(((0:15) * Emeasured/5),1);
ax2.FontSize = 8; %fsz;
xlabel('E (V/m)');

set(gcf, 'Position', [2, 1048, 1000,600]);
