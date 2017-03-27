function [dampingRatio] = dRatio1(pks)
%this function uses the fist method, with pks as an input

Y = pks; %renaming it for convenience
Y1 = Y(1);

for n = 2:length(Y)
    alpha = (log(Y1/Y(n)))/(n-1);
end

dampingRatio = alpha./((4.*pi.^2+alpha.^2).^.5);

end