function [pks,dep,pidx,didx] = peaks(data,th)
yvalues = data(:,2);
xvalues = data(:,1);
[pks,dep,pidx,didx] = peakdet(yvalues,th); %[peak values, depression values, peak indices, depression indices]
pidx = xvalues(pidx); %peak x values
didx = xvalues(didx); %depression x values

end