
%--------------------------------------------------------------------------
% Avg Potential line profile: E-field Calibration expt
%
% Figure 6B (bottom)
% Looking at the average electic potential profile across 5 preparations
% Prep 1-5
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------

blu = [55,126,184]/255;
red = [228,26,28]/255;
gry1 = [153,153,153]/255;
gry2 = [77,77,77]/255;
pos = [100,100,1600,800];
fsz = 12;

load(fullfile(pwd, "Data", "Fig6B_ECalib_AcrossPrep_data.mat"));


%-----------------
figure('color','w'); hold on;

%--- saline part
zsal = -2.2:0.2:0; 
Epot1 = Data_Nov15_trk2.meanEpot_nov15_Trk2(1:5);
z1    = Data_Nov15_trk2.z_nov15_Trk2(1:5);
Epot1_resamp = interp1(z1,Epot1,zsal);

Epot2 = Data_Nov17_trk2.meanEpot_nov17_Trk2(1:6);
z2    = Data_Nov17_trk2.z_nov17_Trk2(1:6);
Epot2_resamp = interp1(z2,Epot2,zsal);

Epot3 = Data_Nov28_trk1.meanEpot_nov28_Trk1(1:13);
z3    = Data_Nov28_trk1.z_nov28_Trk1(1:13);
Epot3_resamp = interp1(z3,Epot3,zsal);

Epot4 = Data_Nov29_trk1.meanEpot_nov29_Trk1(1:13);
z4    = Data_Nov29_trk1.z_nov29_Trk1(1:13);
Epot4_resamp = interp1(z4,Epot4,zsal);

Epot5 = Data_Dec05_trk1.meanEpot_dec05_Trk1(1:13);
z5    = Data_Dec05_trk1.z_dec05_Trk1(1:13);
Epot5_resamp = interp1(z5, Epot5,zsal);

stdzsal = std([Epot1_resamp; Epot2_resamp; Epot3_resamp; Epot4_resamp; Epot5_resamp],'omitnan');
meanEpot = mean([Epot1_resamp; Epot2_resamp; Epot3_resamp; Epot4_resamp; Epot5_resamp],'omitnan');
plot(zsal, meanEpot, 'o', 'Color', gry1, 'MarkerFaceColor',gry1, 'LineWidth', 2); meanEpotsal = meanEpot;

meanEpot = mean([Epot1_resamp; Epot2_resamp; Epot3_resamp; Epot4_resamp; Epot5_resamp],'omitnan');

z = zsal;
sal_indx = 1:length(zsal); %-1;
c_sal  = polyfit(z(sal_indx), meanEpot(sal_indx), 1);
slope_sal = c_sal(1)*1e3; % V/m

text(-2, 0, num2str(slope_sal), 'color','r');

Epot_est_sal = polyval(c_sal, z(sal_indx));
plot(z(sal_indx), Epot_est_sal-0.0006, 'Color', blu, 'LineWidth',4);

ymin = -0.05; ymax = 0.05;
for j=2:length(zsal)
    L = line([zsal(j),zsal(j)], [ymin,ymax]); set(L, 'LineStyle', ':','Color','k');
end


%--------------------------------------------------------------------------
%--- cb part
zcb = 0:0.05:0.9;

Epot1 = Data_Nov15_trk2.meanEpot_nov15_Trk2(6:end);
z1 = Data_Nov15_trk2.z_nov15_Trk2(6:end);
Epot1_resamp = interp1(z1,Epot1,zcb);

Epot2 = Data_Nov17_trk2.meanEpot_nov17_Trk2(7:end);
z2 = Data_Nov17_trk2.z_nov17_Trk2(7:end);
Epot2_resamp = interp1(z2,Epot2,zcb);

Epot3 = Data_Nov28_trk1.meanEpot_nov28_Trk1(13:end);
z3 = Data_Nov28_trk1.z_nov28_Trk1(13:end);
Epot3_resamp = interp1(z3,Epot3, zcb);

Epot4 = Data_Nov29_trk1.meanEpot_nov29_Trk1(13:end);
z4 = Data_Nov29_trk1.z_nov29_Trk1(13:end);
Epot4_resamp = interp1(z4,Epot4, zcb);

Epot5 = Data_Dec05_trk1.meanEpot_dec05_Trk1(13:end);
z5 = Data_Dec05_trk1.z_dec05_Trk1(13:end);
Epot5_resamp = interp1(z5,Epot5, zcb);


stdzcb = std([Epot1_resamp; Epot2_resamp; Epot3_resamp; Epot4_resamp; Epot5_resamp],'omitnan'); 
meanEpot = mean([Epot1_resamp; Epot2_resamp; Epot3_resamp; Epot4_resamp; Epot5_resamp],'omitnan'); 
plot(zcb, meanEpot,'o', 'Color', gry1, 'MarkerFaceColor', gry1, 'LineWidth', 2); meanEpotcb = meanEpot;
colorcb = [0.97,0.53,0.82];


z = zcb;

%------ across the whole cb ctx
cb_indx = 1:19; 
c_cb  = polyfit(z(cb_indx), meanEpot(cb_indx), 1);
slope_cb = c_cb(1)*1e3; % V/m

text(0.4, 0, num2str(slope_cb), 'color','r');

Epot_est_cb = polyval(c_cb, z(cb_indx));
plot(z(cb_indx), Epot_est_cb+0.0006, 'Color', red, 'LineWidth', 4);

% cond_ratio = slope_cb/slope_sal;
% cond_ratio_theory = 1.33/0.2;
% text(-2, 0.02, num2str(cond_ratio), 'color','r');
% text(-2, 0.015, num2str(cond_ratio_theory), 'color','m');
box on;

% %----
for j=2:length(zcb)
    L = line([zcb(j),zcb(j)], [ymin,ymax]); set(L, 'LineStyle', ':','Color','k');
end


L1 = line([0,0],[ymin,ymax]); set(L1,'LineStyle','--', 'color','k'); 
L2 = line([1,1],[ymin,ymax]); set(L2,'LineStyle','--','color','k');
ylim([ymin,ymax]); 
xlim([-2.3,1.1]); 

set(gcf, 'Position', pos);
set(gca, 'FontSize', fsz);

offset = 0.0020121;
set(gca, 'YTick', [-0.05 -0.04 -0.03 -0.0200 -0.0100 0 0.0100 0.0200 0.0300 0.0400 0.05] + offset);
set(gca, 'YLim', [-0.048, 0.0521]);

set(gca, 'YTickLabel',  ['-0.05'; '-0.04'; '-0.03'; '-0.02'; '-0.01'; ...
                         ' 0.00';  ...
                         ' 0.01'; ' 0.02'; ' 0.03'; ' 0.04'; ' 0.05']);

