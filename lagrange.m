clear,clc,close all;

syms x y l;

x2 = linspace(0,1,100);
px1 = zeros (1,length(x2));
w = 1;
for N = (3:2:7)
    x1 = linspace(0,1,N);
    y1 = zeros(length(x1));
    p = zeros (length(x1),1);
    px = 0;
    for i = (1:length(x1))
        y1(i) = cos(2*pi*x1(i));
    end
    k = 1;
    for x = linspace(0,1,length(x2 - 1))
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
       px1(k) = px;
       k = k+1;
    end
    figure(1)
    hold on 
    plot(x2,px1)
end
fplot(cos(2*pi*l))
xlim([0 1])
title('interp')
xlabel('x')
ylabel('y')
hold off

k = 1;
px1 = zeros (1,9);
px2 = zeros (1,9);
for N = (1:9)
    x1 = linspace(0,1,N);
    y1 = zeros(length(x1));
    p = zeros (length(x1),1);
    px = 0;
    for i = (1:length(x1))
        y1(i) = cos(2*pi*x1(i));
    end
    
    for x = 1/9
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
       px1(k) = px - cos(2*pi*1/9);
       px2(k) = (px - cos(2*pi*1/9))/px;
       k = k+1;
    end
    
end
x = 1:9;
figure(2)
semilogy(px1,x)
title('absolute error')
xlabel('Error')
ylabel('N')


figure(3)
semilogy(px2,x)
title('relative error')
xlabel('Error')
ylabel('N')
