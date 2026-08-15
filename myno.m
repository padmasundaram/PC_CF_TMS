

function lfp = myno(lfp, dr)

lfp(:) = -1*lfp(:);

srcmax = max(lfp(:));
srcmin = min(lfp(:));

if (isnan(dr))
    lfp = lfp/(srcmax-srcmin);
    offset = 1 - max(lfp(:));
    lfp = lfp + offset;
else
    lfp = lfp/dr;
end




