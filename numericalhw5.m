clear,clc,close all

%boundary conditions
x0 = 0;
x1 = 1;
y0 = 0;
y1 = 1;
figure(1)
n = [4,10,14,20];
for i = 1:length(n)
    h = (x1-x0)/(n(i)-1); 
    Y = zeros(n(i),n(i));
    Y(1,1) = 1;
    Y(n(i),n(i)) = 1;
    z = 1;
    b = zeros(n(i),1);
    b(1) = y0;
    b(n(i)) = y1;
    for x = 2:n(i)-1
        Y(x,z) = (1-h);
        Y(x,z+1) = (h^2 - 2);
        Y(x,z+2) = (1+h);
        z = z+1;
    end
    %disp(Y)
    %disp(b)
    x = linspace(0,1,n(i));
    F = linsolve(Y,b);
    Err(i) = (.5*2.7182818284^(1-.5)) - ((F(n(i)/2) + F((n(i)/2)+1))/2);
    plot(x,F)
    hold on
end
hold off
figure(2)
plot(n,Err)



