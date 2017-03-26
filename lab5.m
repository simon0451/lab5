%% HEADER
%Simon Popecki
%26 March 2017
%ME646
%Pressure Tap Lab, lab 5

%% Loading Data
clear all;
close all;
%importing structured arrays
nheaderlines = 29; %Data starts on line 30
LBs = importdata('LongBalloon.lvm','\t',nheaderlines); %data for the balloon with long tube
LTs = importdata('LongTube.lvm','\t',nheaderlines); %data for the long tube using a valve
MBs = importdata('MediumBalloon.lvm','\t',nheaderlines); %data for the balloon with medium length tube
MTs = importdata('MediumTube.lvm','\t',nheaderlines); %data for the medium tube using a valve
SBs = importdata('SmallBalloon.lvm','\t',nheaderlines); %data for the balloon attached to the small tube
STs = importdata('SmallTube.lvm','\t',nheaderlines); %data for the small tube with no balloon

%extracting data from structured arrays
%these are the unsmoothed data
LBr = LBs.data; %column 1 is time in seconds, column 2 is voltage (same for all otherr arrays)
LTr = LTs.data;
MBr = MBs.data;
MTr = MTs.data;
SBr = SBs.data;
STr = STs.data;

%signal processing - smooths data, trims away time less than zero, normalizes data
LB = signalProcess(LBr,115);
LT = signalProcess(LTr,9);
MB = signalProcess(MBr,115);
MT = signalProcess(MTr,115);
SB = signalProcess(SBr,155);
ST = signalProcess(STr,25);

%peak detection

%for LB - balloon with long tube
th = .002;
[LBpks,LBdep,LBpidx,LBdidx] = peaks(LB,th); %[peak y values, depression y values, peak x values, depression x values]

%% Plotting
figure(1)
plot(LB(:,1),LB(:,2))
title('Balloon with Long Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .1;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')

figure(2)
plot(LT(:,1),LT(:,2))
title('Long Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .1;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')

figure(3)
plot(MB(:,1),MB(:,2))
title('Balloon with Medium Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .1;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')

figure(4)
plot(MT(:,1),MT(:,2))
title('Medium Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .1;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')

figure(5)
plot(SB(:,1),SB(:,2))
title('Balloon with Short Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.03;
ymax = .03;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')

figure(6)
plot(ST(:,1),ST(:,2))
title('Short Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .1;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results')




