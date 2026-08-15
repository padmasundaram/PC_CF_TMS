
%--------------------------------------------------------------------------
% Figure 9B
% Reporting Group-Level Thresholds
% EThresh-Ctrl-KYNA
%
% P. Sundaram Aug 2026
%--------------------------------------------------------------------------


group = 1;
txt = cell(4,1);
txt{1} = "kyna1"; txt{2} = "kyna2";
txt{3} = "ctrl1"; txt{4} = "ctrl2";

if (group)
    % kyna1, kyna2, ctrl1, ctrl2
    A = [...
        23.72 22.40 25.60 26.50; % Prep2
        25.40 24.51 25.60 24.93; % Prep3
        26.62 25.42 25.60 24.02; % Prep from Fig 9A
        26.56 27.26 25.60 25.83; % Prep4
        22.19 24.36 25.60 23.43; % Prep5
        ];
    THRESH_SPK1_AVG_KYNA = mean(A(:,1));
    THRESH_SPK2_AVG_KYNA = mean(A(:,2));
    THRESH_SPK1_AVG_CTRL = mean(A(:,3));
    THRESH_SPK2_AVG_CTRL = mean(A(:,4));    
    STD_THRESH_SPK1_AVG_KYNA = std(A(:,1));
    STD_THRESH_SPK2_AVG_KYNA = std(A(:,2));
    %
    STD_THRESH_SPK2_AVG_CTRL = std(A(:,4));
    
    for i=1:4
        fprintf('%s: %5.2f +- %5.2f\n', txt{i}, mean(A(:,i)), std(A(:,i)));
    end
   
    figure('Color','w'); hold on;
    L = line([THRESH_SPK2_AVG_CTRL,THRESH_SPK2_AVG_CTRL],[-3,3]); set(L, 'Color', Rd, 'LineStyle', '--');
    L = line([THRESH_SPK1_AVG_CTRL,THRESH_SPK1_AVG_CTRL],[-3,2]); set(L, 'Color', Bl, 'LineStyle', '--');

    L = line([THRESH_SPK2_AVG_KYNA,THRESH_SPK2_AVG_KYNA],[-3,4]); set(L, 'Color', Or, 'LineStyle', '--');
    L = line([THRESH_SPK1_AVG_KYNA,THRESH_SPK1_AVG_KYNA],[-3,5]); set(L, 'Color', Bu, 'LineStyle', '--')


    R = rectangle('Position', [THRESH_SPK2_AVG_CTRL-STD_THRESH_SPK2_AVG_CTRL, -1.25, 2*STD_THRESH_SPK2_AVG_CTRL, 0.5]);
    set(R, 'FaceColor', Rd); 

    R = rectangle('Position', [THRESH_SPK2_AVG_KYNA-STD_THRESH_SPK2_AVG_KYNA, -2, 2*STD_THRESH_SPK2_AVG_KYNA, 0.5]);
    set(R, 'FaceColor', Or); 

    R = rectangle('Position', [THRESH_SPK1_AVG_KYNA-STD_THRESH_SPK1_AVG_KYNA, -2.5, 2*STD_THRESH_SPK1_AVG_KYNA, 0.5]);
    set(R, 'FaceColor', Bu);

    xlim([0,63.9]);
    
    xlabel('E (V/m)');
end

box on;