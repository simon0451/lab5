function [stepy] = Gfunc(wn,zeta,t)

num=2;%K value
den = [1/wn^2 2*zeta/wn 1];
initialsig=3;
sys=tf(num,den);
stepy = step(sys+initialsig,t);
end