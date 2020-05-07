clear all
%f = @(x) x*sin(x)-1;
%fp =@(x) sin(x)+x*cos(x);
%x0=5;

f = @(x) x.^2-5;
fp =@(x) 2*x;
x0=0.1;

for i=1:100
    x1=x0-f(x0)/fp(x0);
    if abs(f(x1)-f(x0))<1e-12
        break;
    end
    x0=x1;
end
sq5=sqrt(5);
fprintf('root=%3.12f, sqrt(5)=%3.12f after %d iterations\n',x1,sq5,i);