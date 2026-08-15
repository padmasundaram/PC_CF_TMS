%------------------------------------------------------------------
%
% Fig5AB_CSD9
%
% Generates the average CSD Profiles for the 1.2 ms, 2.0 ms and
% "5.0 ms" components in normal and KYNA saline
%
% P. Sundaram Aug 2026
%------------------------------------------------------------------

grn = [0.13,0.51,0.13];
myblu = [33,102,172]/255;
myred = [178,24,43]/255;

w=1;
alpha=0.2;
ymin=-0.7e6; ymax=0.7e6;
aa=0.15;

load(fullfile("Data", "Fig5_CSD9.mat"));
N = size(data,2);

ctrl_depth = [-1000 -900 -800 -700 -600 -500 -400 -300 -200 -100 0];
kyna_depth = [-1000 -900 -800 -700 -600 -500 -400 -300 -200 -100 0];


%---- ctrl hi blu --------------------------------------------------------
array_ctrl_blu = zeros(length(ctrl_depth),N);
for i=1:length(data)
    array_ctrl_blu(:,i) = data{i}.ctrlhi_blu;
end
mean_ctrlhi_blu = mean(array_ctrl_blu,2);%, 
std_ctrlhi_blu  = std( array_ctrl_blu')/sqrt(N); %, 

%---- ctrl hi red --------------------------------------------------------
array_ctrl_red = zeros(length(ctrl_depth),N);
for i=1:length(data)
    array_ctrl_red = [array_ctrl_red, data{i}.ctrlhi_red];
end
mean_ctrlhi_red = mean(array_ctrl_red,2);%, 
std_ctrlhi_red  = std( array_ctrl_red')/sqrt(N); %, 

%---- ctrl hi wav --------------------------------------------------------
array_ctrl_wav = zeros(length(ctrl_depth),N);
for i=1:length(data)
    array_ctrl_wav = [array_ctrl_wav, data{i}.ctrlhi_wav];
end
mean_ctrlhi_wav= mean(array_ctrl_wav,2);%, 
std_ctrlhi_wav  = std( array_ctrl_wav')/sqrt(N); %, 

%---- kyna blu --------------------------------------------------------
array_kyna_blu = [];
for i=1:length(data)
    array_kyna_blu = [array_kyna_blu, data{i}.kyna_blu];
end
mean_kyna_blu = mean(array_kyna_blu,2);%, 
std_kyna_blu  = std( array_kyna_blu')/sqrt(N); %, 

%---- kyna red --------------------------------------------------------
array_kyna_red = [];
for i=1:length(data)
    array_kyna_red = [array_kyna_red, data{i}.kyna_red];
end
mean_kyna_red = mean(array_kyna_red,2);%, 
std_kyna_red  = std( array_kyna_red')/sqrt(N); %, 




% %------------------------------------------------------- 
f2=figure('Color', 'w', 'Name', 'redbluwav');
hold on;
h = shadedErrorBar(ctrl_depth, mean_ctrlhi_blu, std_ctrlhi_blu); 
set(h.patch, 'FaceColor', 'cyan', 'FaceAlpha',aa); 
set(h.mainLine, 'Color', 'b', 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end

h = shadedErrorBar(ctrl_depth, mean_ctrlhi_red, std_ctrlhi_red); 
set(h.patch, 'FaceColor', 'r', 'FaceAlpha', aa); 
set(h.mainLine, 'Color', 'r', 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end
box on; ylim([ymin,ymax]);

h = shadedErrorBar(ctrl_depth, mean_ctrlhi_wav, std_ctrlhi_wav); 
set(h.patch, 'FaceColor', grn, 'FaceAlpha', aa); 
set(h.mainLine, 'Color', grn, 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end
box on; ylim([ymin,ymax]);


% %------------------------------------------------------- 
f3=figure('Color', 'w', 'Name', 'redblu');
hold on;
h = shadedErrorBar(kyna_depth, mean_kyna_blu, std_kyna_blu); 
set(h.patch, 'FaceColor', 'cyan', 'FaceAlpha', aa); 
set(h.mainLine, 'Color', 'b', 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end

h = shadedErrorBar(kyna_depth, mean_kyna_red, std_kyna_red); 
set(h.patch, 'FaceColor', 'r', 'FaceAlpha', aa); 
set(h.mainLine, 'Color', 'r', 'LineWidth', 1);
for i=1:2, set(h.edge(i), 'LineStyle', 'none'); end
box on; ylim([ymin,ymax]);

title('kyna');

figure(f2); L = line([-1000,0],[0,0]); set(L, 'Color', 'k', 'LineStyle', '--');
figure(f3); L = line([-1000,0],[0,0]); set(L, 'Color', 'k', 'LineStyle', '--');

















