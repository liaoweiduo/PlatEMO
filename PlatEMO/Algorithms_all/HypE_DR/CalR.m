function [r] = CalR(a,b,c,x)
%  calculate reference point position r
%  r = ax^2 + bx + c
    r = a .* x .* x + b .* x + c;
end