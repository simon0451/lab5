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
ST = signalProcess(STr,25); %short tube has pretty shitty data, so it will get a manual shift
STm = .008+ST(:,2); %shifting all the y values up
STms = ST(:,1); %keeping time as is
ST = [STms,STm]; %reconstructing ST array with modified values

%signal processing again - these are the waveforms for plotting
LBrs = signalProcess2(LBr,115);
LTrs = signalProcess2(LTr,9);
MBrs = signalProcess2(MBr,115);
MTrs = signalProcess2(MTr,115);
SBrs = signalProcess2(SBr,155);
STrs = signalProcess2(STr,25); %short tube has pretty shitty data, so it will get a manual shift

%peak detection
%for LB - balloon with long tube
th = .002;
[LBpks,LBdep,LBpidx,LBdidx] = peaks(LB,th); %[peak y values, depression y values, peak x values, depression x values]

th = .002;
[LTpks,LTdep,LTpidx,LTdidx] = peaks(LT,th);

th = .01;
[MBpks,MBdep,MBpidx,MBdidx] = peaks(MB,th);

th = .01;
[MTpks,MTdep,MTpidx,MTdidx] = peaks(MT,th);

th = .005;
[SBpks,SBdep,SBpidx,SBdidx] = peaks(SB,th);

th = .001;
[STpks,STdep,STpidx,STdidx] = peaks(ST,th);
STpks=[STpks(1) STpks(2)]; %taking only first two peaks
STpidx=[STpidx(1) STpidx(2)];

%finding the damped natural frequencies
LBTd = LBpidx(3)-LBpidx(2); %distance between the third and second peak
LBomegaD = (2*pi)./LBTd; %this is the damped natural frequency, units should be Hz
LBomegaDs = num2str(LBomegaD,3);
LBtxt = strcat('Damped Natural Frequency: ',LBomegaDs,' Hz');

LTTd = LTpidx(3)-LTpidx(2);
LTomegaD = (2*pi)./LTTd;
LTomegaDs = num2str(LTomegaD,3);
LTtxt = strcat('Damped Natural Frequency: ',LTomegaDs,' Hz');

MBTd = MBpidx(3)-MBpidx(2);
MBomegaD = (2*pi)./MBTd;
MBomegaDs = num2str(MBomegaD,3);
MBtxt = strcat('Damped Natural Frequency: ',MBomegaDs,' Hz');

MTTd = MTpidx(3)-MTpidx(2);
MTomegaD = (2*pi)./MTTd;
MTomegaDs = num2str(MTomegaD,3);
MTtxt = strcat('Damped Natural Frequency: ',MTomegaDs,' Hz');

SBTd = SBpidx(3)-SBpidx(2);
SBomegaD = (2*pi)./SBTd;
SBomegaDs = num2str(SBomegaD,3);
SBtxt = strcat('Damped Natural Frequency: ',SBomegaDs,' Hz');

STTd = STpidx(2)-STpidx(1); %for ST, peaks 2 and 1 are used due to poor data
STomegaD = (2*pi)./STTd;
STomegaDs = num2str(STomegaD,3);
STtxt = strcat('Damped Natural Frequency: ',STomegaDs,' Hz');

%finding the damping ratios
LBDR2 = dRatio1(LBpks); %creates an array of damping ratios for the second method (put this in a table)
LBzeta = mean(LBDR2); %finding the arithmetic mean of the damping ratios from method 2 (results in single DR number)
LBzetas = num2str(LBzeta,3);
LBtxt2 = strcat('Damping Ratio: ',LBzetas);

LTDR2 = dRatio1(LTpks);
LTzeta = mean(LTDR2);
LTzetas = num2str(LTzeta,3);
LTtxt2 = strcat('Damping Ratio: ',LTzetas);

MBDR2 = dRatio1(MBpks);
MBzeta = mean(MBDR2);
MBzetas = num2str(MBzeta,3);
MBtxt2 = strcat('Damping Ratio: ',MBzetas);

MTDR2 = dRatio1(MTpks);
MTzeta = mean(MTDR2);
MTzetas = num2str(MTzeta,3);
MTtxt2 = strcat('Damping Ratio: ',MTzetas);

SBDR2 = dRatio1(SBpks);
SBzeta = mean(SBDR2);
SBzetas = num2str(SBzeta,3);
SBtxt2 = strcat('Damping Ratio: ',SBzetas);

STDR2 = dRatio1(STpks);
STzeta = mean(STDR2);
STzetas = num2str(STzeta,3);
STtxt2 = strcat('Damping Ratio: ',STzetas);

% simulating functions
LBS = Gfunc(LBr,LBrs,LBomegaD,LBzeta);
LTS = Gfunc(LTr,LTrs,LTomegaD,LTzeta);
MBS = Gfunc(MBr,MBrs,MBomegaD,MBzeta);
MTS = Gfunc(MTr,MTrs,MTomegaD,MTzeta);
SBS = Gfunc(SBr,SBrs,SBomegaD,SBzeta);
STS = Gfunc(STr,STrs,STomegaD,STzeta);
%% Deliverable 1 Plotting
figure(1)
plot(LBrs(:,1),LBrs(:,2),LB(:,1),LBS,'b:')
title('Balloon with Long Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.02;
xmax = .19;
ymin = -.12;
ymax = .14;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.45*xmax,.8*ymin,LBtxt)
text(.45*xmax,.9*ymin,LBtxt2)

figure(2)
plot(LTrs(:,1),LTrs(:,2),LT(:,1),LTS,'b:')
title('Long Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .55;
ymin = -.5;
ymax = 4.5;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.45*xmax,.05*ymax,LTtxt)
text(.45*xmax,0,LTtxt2)

figure(3)
plot(MBrs(:,1),MBrs(:,2),MB(:,1),MBS,'b:')
title('Balloon with Medium Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .19;
ymin = -.1;
ymax = .15;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.45*xmax,.8*ymin,MBtxt)
text(.45*xmax,.9*ymin,MBtxt2)

figure(4)
plot(MTrs(:,1),MTrs(:,2),MT(:,1),MTS,'b:')
title('Medium Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .12;
ymin = -.5;
ymax = 4.5;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.45*xmax,.05*ymax,MTtxt)
text(.45*xmax,0,MTtxt2)

figure(5)
plot(SBrs(:,1),SBrs(:,2),SB(:,1),SBS,'b:')
title('Balloon with Short Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.02;
xmax = .19;
ymin = -.1;
ymax = .13;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.39*xmax,.8*ymin,SBtxt)
text(.39*xmax,.9*ymin,SBtxt2)

figure(6)
plot(STrs(:,1),STrs(:,2),ST(:,1),STS,'b:')
title('Short Tube')
xlabel('Time (s)')
ylabel('Pressure (Volts)')
xmin = -0.01;
xmax = .1;
ymin = 0;
ymax = 4.5;
axis ([xmin xmax ymin ymax])
grid on
legend('Experimental Results','Simulated Response')
text(.4*xmax,.1*ymax,STtxt)
text(.4*xmax,.05*ymax,STtxt2)

%% Deliverable 2
omegas = [LBomegaD MBomegaD SBomegaD]; %Hz, damped natural frequencies of each tube
zetas = [LBzeta MBzeta SBzeta]; %damping ratio
lengths = [42.75 34 7.375]; %inches, legnth of the tubes
inverseLs = 1./lengths; %1/inches, inverse lengths of the tubes
BF1 = polyfit(inverseLs,omegas,1);
omegaMBF = BF1(1)*inverseLs+BF1(2);
BF2 = polyfit(lengths,zetas,1);
zetaMBF = BF2(1)*lengths+BF2(2);

omegaP = omegaPedict(lengths); %predicting the natural frequency based on the lengths of the tubes in inches
BF3 = polyfit(inverseLs,omegaP,1);
omegaPBF = BF3(1)*inverseLs+BF3(2);

zetaP = zetaPredict(lengths); %predicting the damping ratios based on the lengths of the tubes in inches
BF4 = polyfit(lengths,zetaP,1);
zetaPBF = BF4(1)*lengths+BF4(2);

figure(7)
plot(inverseLs,omegas,'o',inverseLs,omegaMBF,'b',inverseLs,omegaPBF,'r--')
title('Comparison of Response to System Parameters')
xlabel('Inverse Length (1/inches)')
ylabel('Damped Natural Frequency')
legend('Measurements','Measurement Fit','Predicted Values','location','northwest')
grid on

figure(8)
plot(lengths,zetas,'o',lengths,zetaMBF,'b',lengths,zetaPBF,'r--')
title('Comparison of Response to System Parameters')
xlabel('Length (inches)')
ylabel('Damping Ratio')
legend('Measurements','Measurement Fit','Predicted Values','location','northwest')
grid on

