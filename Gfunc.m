function [stepy] = Gfunc(rawDataArray,dataArray,wn,zeta)

t = dataArray(:,1);
voltages = rawDataArray(:,2);
initialsig = voltages(1);
finalsig = voltages(end);
num=finalsig-initialsig;%K value
den = [1/wn^2 2*zeta/wn 1];
sys=tf(num,den);
stepy = step(sys+initialsig,t);
end