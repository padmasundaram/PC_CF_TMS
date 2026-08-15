
%--------------------------------------------------------------------------
% Potential line profile: E-field Calibration expt
% Prep2
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
datatitle = 'Prep2';

Fs = 500e3; % sampling rate 500 kHz
gain = 10; %10;

start = 49;

load(fullfile(pwd, "Data", "Fig6A_ECalib_Prep2_data.mat"));

%-------------------------
z = [-3.1 -2.85 -2.6 -2.3500    -2.1000    -1.8500    -1.6000    -1.3500    -1.1000    -0.8500    -0.6000    -0.3500 ...
    0 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9];


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
Epot = zeros(length(z),30);
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
sal_indx = 1:15; 
c_sal = polyfit(z(sal_indx), meanEpot(sal_indx, :), 1);
cb_indx = 16:30; 
c_cb  = polyfit(z(cb_indx), meanEpot(cb_indx, :), 1);
Epot_est_cb = polyval(c_cb, z);
Epot_est_sal = polyval(c_sal, z);

[xint, yint, ~, ~] = linexline([z(1), z(end)], [Epot_est_cb(1), Epot_est_cb(end)], [z(1), z(end)], [Epot_est_sal(1), Epot_est_sal(end)],0);



%-------------------------------------------------------------------------
fig = figure('color','w'); hold on;

figure(fig); plot(z, meanEpot, 'o', 'Color', gry1, 'MarkerFaceColor', gry1, 'LineStyle', 'none');

figure(fig); 

Epot_est_cb = polyval(c_cb, [xint z(cb_indx(1:end-1)) ]);
plot([xint z(cb_indx(1:end-1)) ], Epot_est_cb, 'Color', red, 'LineWidth', 4);
slope_cb = c_cb(1)*1e3; % V/m

Epot_est_sal = polyval(c_sal, [z(sal_indx(1:end-3)) xint]);
plot([z(sal_indx(1:end-3)) xint], Epot_est_sal, 'Color', blu, 'LineWidth', 4);
slope_sal = c_sal(1)*1e3; % V/m

text( 0, -0.48, sprintf('%5.1f V/m', slope_cb), 'color','r');
text(-2, -0.48, sprintf('%5.1f V/m', slope_sal), 'color','b');

title("Prep2");

L1 = line(xint+[0,0],[-0.53,-0.38]); set(L1, 'LineStyle', '--', 'Color', 'k');
L2 = line([0.85,0.85],[-0.53,-0.38]); set(L2, 'LineStyle', '--', 'Color', 'k');

box on;

ylabel('Potential (V)');

xlabel('Distance (mm)');

set(gcf, 'Position', pos);
set(gca, 'FontSize', fsz);

xlim([-3.0,1.1]);
ylim([-0.53, -0.38]);

%%%%......................................................................

xticks_sal = z(sal_indx(1:end-3));
xticks_cb = [xint 0 0.1 0.15 z(cb_indx) ];
xticks([xticks_sal xticks_cb]);
xticklabels([xticks_sal xticks_cb] - xint)

vals = [xticks_sal xticks_cb] - xint;
labels = arrayfun(@(x) sprintf('%.2f', x), vals, 'UniformOutput', false);
set(gca, 'XTickLabel', labels);
set(gca, 'FontSize', 12);

ax = gca;
grid on;
ax.YGrid = 'off';


set(gca, 'YLim', [-0.5165,-0.4165]);
set(gca, 'YTick',  [-0.5165   -0.5065   -0.4965   -0.4865   -0.4765   -0.4665   -0.4565   -0.4465   -0.4365   -0.4265   -0.4165]);

set(gca, 'YTickLabel',  ['-0.05'; '-0.04'; '-0.03'; '-0.02'; '-0.01'; ...
                         ' 0.00';  ...
                         ' 0.01'; ' 0.02'; ' 0.03'; ' 0.04'; ' 0.05']);
