%
% plot_setup
%

Rd = [228, 26,28]/255;
Or = [255,127, 0]/255;

Bl = [ 55,126,184]/255;
Bu = [152, 78,163]/255;

Gr = [ 77,175, 74]/255;


ww = 1200; hh = 800; zz = ww*2;
pos1 =   [28         921        ww        hh];
pos2 = pos1 + [ww 0 0 0];
pos3 = pos1 + [0 -hh 0 0]; pos3(3) = zz/3;
pos4 = pos3 + [ww  0 0 0]; pos4(1) = pos3(1)+pos3(3);
pos5 = pos4 + [ww  0 0 0]; pos5(1) = pos3(1)+2*pos3(3);

pos = [1800,900,1600,800];

xmin=1; xmax=11;
ymin=-0.05; ymax=1;

lnstyleraw = '-';
lnstylefit = '--';
lnstyleegs = '-.';
lnstyldots = ':';

Gy = [128, 128, 128]/255;

toff = 0;

fsz=10;