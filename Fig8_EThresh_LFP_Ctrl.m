
%--------------------------------------------------------------------------
% Figure 8
% LFP for different components (1.2,2.0,5 ms) as a function of E-field
% Interpolating the xaxis (E-field) so we can average across the 5
% preparations
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------


load(fullfile(pwd, "Data", "Fig8_ECalib_N5_data.mat")); % Calibration info for the N=5 preps

msodata = ...
   [X{1}.THRESH_SPK1, X{1}.THRESH_SPK2, X{1}.THRESH_SPKW;...
    X{2}.THRESH_SPK1, X{2}.THRESH_SPK2, X{2}.THRESH_SPKW;...
    X{3}.THRESH_SPK1, X{3}.THRESH_SPK2, X{3}.THRESH_SPKW;...
    X{4}.THRESH_SPK1, X{4}.THRESH_SPK2, X{4}.THRESH_SPKW;...
    X{5}.THRESH_SPK1, X{5}.THRESH_SPK2, X{5}.THRESH_SPKW];

data = msodata;
for i=1:5
    data(i,:) = data(i,:)*X{i}.scale;
end

%-------

data_12w = mean(data,1); % avg thresholds for 1.2ms,2.0ms,5.0ms
std_12w = std(data,0,1); % stddev for 1.2ms,2.0ms,5.0ms thresh


%--------------------------------------------------------------------------
% Let's work with the 1.2 ms component first

ctrl_e = 10:1:100;
Thresh1ms = data_12w(1);
StdThresh1ms = std_12w(1);

mm = zeros(5,1);

shifted_e = cell(5,1);
spkresp_interp = cell(5,1);

deltaz = [4,2,1,0,-1];

for i=1:5
    ctrl_e_i  = X{i}.ctrl_mso*X{i}.scale;
    spkresp_i = X{i}.Data_1;
    spkresp_i_interp = interp1(ctrl_e_i, spkresp_i, ctrl_e);
    delta = deltaz(i); 
    
    spkresp_i_interp_shifted = spkresp_i_interp; 
    mm(i) = (max(spkresp_i_interp_shifted) - min(spkresp_i_interp_shifted)) * 1.0397;
    spkresp_i_interp_shifted = myno(-1*spkresp_i_interp_shifted, NaN) * 1.0397; 
    
    ctrl_e_i_shifted = ctrl_e + delta;
    shifted_e{i} = ctrl_e_i_shifted;
    spkresp_interp{i} = spkresp_i_interp_shifted;
end

shifted_e_spk1 = shifted_e{1}(1:end-5);

avg_spk1 =(spkresp_interp{1}(1:end-5)+...
           spkresp_interp{2}(3:end-3)+...
           spkresp_interp{3}(4:end-2)+...
           spkresp_interp{4}(5:end-1)+...
           spkresp_interp{5}(6:end))/5; 

std_spk1 = nanstd([spkresp_interp{1}(1:end-5);...
                   spkresp_interp{2}(3:end-3);...
                   spkresp_interp{3}(4:end-2);...
                   spkresp_interp{4}(5:end-1);...
                   spkresp_interp{5}(6:end)],1);


%-------------------------------------------------------------------------
% Now the 2.0 ms component

Thresh2ms = data_12w(2);
StdThresh2ms = std_12w(2);

shifted_e = cell(5,1);
spkresp_interp = cell(5,1);

deltaz = [4,2,0,-1,0];

for i=1:5
    ctrl_e_i  = X{i}.ctrl_mso*X{i}.scale;
    spkresp_i = X{i}.Data_2;
    spkresp_i_interp = interp1(ctrl_e_i, spkresp_i, ctrl_e);
    delta = deltaz(i); 

    spkresp_i_interp_shifted = spkresp_i_interp; 
    spkresp_i_interp_shifted = myno(-1*spkresp_i_interp_shifted, mm(i)); 
    
    ctrl_e_i_shifted = ctrl_e + delta;
    shifted_e{i} = ctrl_e_i_shifted;
    spkresp_interp{i} = spkresp_i_interp_shifted;
end

shifted_e_spk2 = shifted_e{1}(1:end-5);

avg_spk2 = (spkresp_interp{1}(1:end-5) + ...
            spkresp_interp{2}(3:end-3) +...
            spkresp_interp{3}(5:end-1) + ...
            spkresp_interp{4}(6:end  ) +...
            spkresp_interp{5}(5:end-1))/5;

std_spk2 = nanstd([spkresp_interp{1}(1:end-5); ...
                   spkresp_interp{2}(3:end-3); ...
                   spkresp_interp{3}(5:end-1); ...
                   spkresp_interp{4}(6:end  );...
                   spkresp_interp{5}(5:end-1)],1);

%-------------------------------------------------------------------------
% now onto the wave (4-5 ms component)

Threshw = data_12w(3);
StdThreshw = std_12w(3);

shifted_e = cell(5,1);
spkresp_interp = cell(5,1);

deltaz = [-13,-4,9,19,-23];
for i=1:5
    ctrl_e_i  = X{i}.ctrl_mso*X{i}.scale;
    spkresp_i = X{i}.Data_w;
    spkresp_i_interp = interp1(ctrl_e_i, spkresp_i, ctrl_e);
    delta = deltaz(i); %;
    
    spkresp_i_interp_shifted = spkresp_i_interp; 
    spkresp_i_interp_shifted = myno(-1*spkresp_i_interp_shifted, mm(i)); 
    ctrl_e_i_shifted = ctrl_e + delta;
    shifted_e{i} = ctrl_e_i_shifted;
    spkresp_interp{i} = spkresp_i_interp_shifted;    
end

shifted_e_spkw = shifted_e{1}(33:end-10);

avg_spkw = (spkresp_interp{1}(33:end-10) + ...
            spkresp_interp{2}(24:end-19) +...
            spkresp_interp{3}(11:end-32) + ...
            spkresp_interp{4}( 1:end-42) +...
            spkresp_interp{5}(43:end   ))/5;

std_spkw = nanstd([spkresp_interp{1}(33:end-10); ...
                   spkresp_interp{2}(24:end-19);...
                   spkresp_interp{3}(11:end-32); ...
                   spkresp_interp{4}( 1:end-42);...
                   spkresp_interp{5}(43:end   )],1);



Rd = [228,26,28]/255;
Gr = [77,175,74]/255;
Bl = [55,126,184]/255;
w = 1;
kkw=0.033;

%---------------
figure; set(gcf, 'Color', 'w'); hold on;

Rb = rectangle('Position', [Thresh1ms-StdThresh1ms,-0.2,2*StdThresh1ms, 0.2],'FaceColor',Bl,'FaceAlpha',0.1,'EdgeColor','None');
Rr = rectangle('Position', [Thresh2ms-StdThresh2ms,-0.2,2*StdThresh2ms, 0.25],'FaceColor',Rd,'FaceAlpha',0.1,'EdgeColor','None');
Rg = rectangle('Position', [Threshw-StdThreshw ,-0.2,2*StdThreshw, 0.2],     'FaceColor',Gr,'FaceAlpha',0.1,'EdgeColor','None');
L = line([Thresh1ms,Thresh1ms],[-0.2,0.2]); set(L, 'LineWidth', w, 'Color',  Bl, 'LineStyle', '--');
L = line([Thresh2ms,Thresh2ms],[-0.2,0.3]); set(L, 'LineWidth', w, 'Color',  Rd, 'LineStyle', '--');
L = line([Threshw  ,Threshw  ],[-0.2,0.2]); set(L, 'LineWidth', w, 'Color',  Gr, 'LineStyle', '--');
box on;
ylim([-0.3,1.0]);
xlabel('E field (V/m)');

set(gcf, 'Position', [100         100         1200         1200], 'color','w', 'Name', 'SpkCtrl_Combo');
%---------------
aa = 0.1;

h=shadedErrorBar(shifted_e_spk1, avg_spk1, std_spk1);
set(h.patch, 'FaceColor', Bl, 'FaceAlpha', aa); 
set(h.mainLine, 'Color', Bl, 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end

h=shadedErrorBar(shifted_e_spk2, avg_spk2, std_spk2);
set(h.patch, 'FaceColor', Rd, 'FaceAlpha', aa); 
set(h.mainLine, 'Color', Rd, 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end

h = shadedErrorBar([18,shifted_e_spkw(8:end)], [0, avg_spkw(8:end)-kkw], [std_spkw(1), std_spkw(8:end)]);
set(h.patch, 'FaceColor', Gr, 'FaceAlpha', aa); 
set(h.mainLine, 'Color', Gr, 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end



