
%--------------------------------------------------------------------------
% Potential line profile: E-field Calibration expt
% Prep1
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------

% Setup
blu = [55,126,184]/255;
red = [228,26,28]/255;
gry1 = [153,153,153]/255;
gry2 = [77,77,77]/255;
pos = [100,100,1600,800];
fsz = 14;
datatitle = 'Prep1';

Fs = 500e3; % sampling rate 500 kHz
gain = 10;

start = 72; % to read the correct files

load(fullfile(pwd, "Data", "Fig6A_ECalib_Prep1_data.mat"));

%-------------------------------------------------------------------------
z =[-2.77 -2.52 -2.27 -2.02 -1.77 -1.52 -1.27 -1.02 -0.77 -0.52 -0.27  ... 
    0 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9];


Epot = zeros(length(z),29);
Epot_all = zeros(length(z),10,length(times{1,1}));
for i = 1:length(z)
    cnt=1;
    for f = 1:length(files{i})
        fi = files{i}(f)-start+1;
        pot = avg{fi,1};
        Epot_all(i, cnt, :) = pot/gain; cnt=cnt+1;
        Epot(i,f) = min(pot)/gain; 
    end
end
meanEpot = zeros(length(z),1);
stdEpot = zeros(length(z),1);
for i=1:length(z)
    e = Epot(i,:);
    meanEpot(i) = mean(e(e~=0));
    stdEpot(i) = std(e(e~=0));
end


% 
sal_indx = 1:12;
c_sal = polyfit(z(sal_indx), meanEpot(sal_indx, :), 1);
cb_indx = 14:28;
c_cb  = polyfit(z(cb_indx), meanEpot(cb_indx, :), 1);
Epot_est_cb = polyval(c_cb, z);
Epot_est_sal = polyval(c_sal, z);
%figure();
[xint, yint, ~, ~] = linexline([z(1), z(end)], [Epot_est_cb(1), Epot_est_cb(end)], [z(1), z(end)], [Epot_est_sal(1), Epot_est_sal(end)],0);


% %-------------------------------------------------------------------------
fig = figure('color','w'); hold on;

figure(fig); plot(z, meanEpot, 'o', 'Color', gry1, 'MarkerFaceColor', gry1, 'LineStyle', 'none');

figure(fig); 

Epot_est_cb = polyval(c_cb, [xint z(cb_indx) xint+1.0]);
plot([xint z(cb_indx) xint+1.0], Epot_est_cb, 'Color', red, 'LineWidth', 4);
slope_cb = c_cb(1)*1e3; % V/m

Epot_est_sal = polyval(c_sal, [z(sal_indx(1:end-1)) xint]);
plot([z(sal_indx(1:end-1)) xint], Epot_est_sal, 'Color', blu, 'LineWidth', 4);
slope_sal = c_sal(1)*1e3; % V/m

text( 0, -0.51, sprintf('%5.1f V/m', slope_cb), 'color','r');
text(-2, -0.51, sprintf('%5.1f V/m', slope_sal), 'color','b');

title('Prep1');

L1 = line(xint+[0,0],[-0.6,-0.45]); set(L1, 'LineStyle', '--', 'Color', 'k');
L2 = line(xint+[1,1],[-0.6,-0.45]); set(L2, 'LineStyle', '--', 'Color', 'k');

box on;

ylabel('Potential (V)');

xlabel('Distance (mm)');

set(gcf, 'Position', pos);
set(gca, 'FontSize', fsz);

xlim([-3.0,1.1]);

%%%%......................................................................

xticks_sal = z(sal_indx(1:end-1));
xticks_cb = [xint 0 0.1 z(cb_indx) ];
xticks([xticks_sal xticks_cb]);
xticklabels([xticks_sal xticks_cb] - xint);

vals = [xticks_sal xticks_cb] - xint;
labels = arrayfun(@(x) sprintf('%.2f', x), vals, 'UniformOutput', false);
set(gca, 'XTickLabel', labels);
set(gca, 'FontSize', 12);

ax = gca;
grid on;
ax.YGrid = 'off';


set(gca, 'YLim', [-0.5906,-0.4906]);

set(gca, 'YTick', [-0.5906   -0.5806   -0.5706   -0.5606   -0.5506   -0.5406   -0.5306   -0.5206   -0.5106   -0.5006   -0.4906]);

set(gca, 'YTickLabel',  ['-0.05'; '-0.04'; '-0.03'; '-0.02'; '-0.01'; ...
                         ' 0.00';  ...
                         ' 0.01'; ' 0.02'; ' 0.03'; ' 0.04'; ' 0.05']);

