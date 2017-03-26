%use GrossCode2 instead
close all;
clear all;
ao=.07;
a2=ao*45;
a1=ao*3;
num=1/ao;
den=[a2/ao a1/ao ao/ao];
t=0:0.01:500;
initialsig=10;
sys=tf(num,den);
step(sys+initialsig,t)
title ('Step Response')
xlabel('Time')
ylabel('Output y(t)')
axis([0 500 0 35])
text(150,27,'Saturated value = initial + 1/ao')