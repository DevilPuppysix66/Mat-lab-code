clear,clc,close all
figure(1)
for N = [3,5,9,17]
    points = linspace(0, 1, N);
    h = 1/length(points);
    for i = 1:N
        values(i) = cos(2*pi*points(i));
    end
    derivative_values = derivative(h,values);
    plot(points,derivative_values); 
    hold on
end
hold off
clear,clc
figure(2)

for N = [3,5,9,17]
    points = linspace(0, .5, N);
    h = 0.5/length(points);
    for i = 1:N
        values(i) = sin(points(i));
    end
    derivative_values = derivative(h,values);
    for i = 1:N
        error(i) = abs(cos(points(i))-derivative_values(i));
    end
    loglog(points,error)
    hold on
end
grid on