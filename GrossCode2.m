close all;
clear all;
wn=50;
zeta=0.2;
num=2;%K value
den = [1/wn^2 2*zeta/wn 1];
t=0:0.01:2;
initialsig=3;
sys=tf(num,den);
step(sys+initialsig,t) 
title ('Step Response') 
xlabel('Time') 
ylabel('Output y(t)') 
axis([0 2 0 8]) 
text(0.4,6,'Final value = num + initial')