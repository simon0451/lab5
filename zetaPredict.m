function [zetaP] = zetaPredict(l)
l = l*.0254; %m, converting l from inches to meters
a = 343; %m/s, speed of sound in air
mew = .00001983; %absolute viscosity of air
d = .16*.0254; %inner diameter of the tube, converted to meters
zetaP = ((.5).^.5).*(16.*mew.*l)./(a.*(d.^2));
end