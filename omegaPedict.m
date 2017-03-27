function [omegaP] = omegaPedict(l)
%takes input of tube length in inches and outputs the damped natural
%frequency

l = l*.0254; %converting from inches to meters
a = 343; %m/s, speed of sound in air
omegaP = a./(l.*(.5).^.5); %solving for the prediction of omega

end