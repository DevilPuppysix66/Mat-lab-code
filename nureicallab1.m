clear,clc,close all;

syms x x1 y y1 p w;
x2 = 1:30;
x1 = [20,22.5,10,15];
y1 = [517.5, 602.97,227.04, 362.78];
p = zeros (length(x1),1);
px = 0;
px1 = zeros (1,length(x2));
w = 1;
for x = (1:length(x2))
    px = 0;
    for i = (1:length(x1))
        w = 1;
        for z = (1:length(x1))
            if z == i
                %nothing
            else
                w = w * (x - x1(z))/(x1(i)-x1(z));  
            end
        end
        p(i) = w * y1(i);
        px = px + p(i);
    end
    px1(x) = px;
end
disp(p)
disp(px)

step = 0:30;

%funct = interp1(x1,y1,step,'spline');

plot(x1,y1,'o--',x2,px1,'o--');%,step,funct,':.')

xlim([0 30]);
title('lagrange interpolation')
legend('data points','interpolated values','location','southeast')
xlabel('x')
ylabel('y')