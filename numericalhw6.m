clear,clc,close all
%double u 
%dudx = (u1 - u0)/2h
%d2udx2 = (u0 -
syms u
%boundary conditions
x0 = 0;
x1 = 4;
y0 = 1;
y1 = 2;
v = .2;
figure(1)
n = [5,10,20,40,80];
for i = 1:length(n)
    u = ones(n(i)+1,1);
    h = (x1-x0)/(n(i)); 
    Y = zeros(n(i)+1,1);
    z = 0;
    J = zeros(n(i)+1,n(i)+1);
    while 1
        J(1,1) = 1;
        J(n(i)+1,n(i)+1) = 1;
        Y(1) = u(1)-1;
        Y(n(i)+1) = u(n(i)+1)-2;
        for x = 2:n(i)
            Y(x)=h*u(x)*u(x+1)-h*u(x)*u(x-1)+2*v*u(x+1)-4*v*u(x)+2*v*u(x-1);
            J(x,x) = h*u(x+1)-h*u(x-1)-4*v;
            J(x,x+1) = h*u(x)+2*v;
            J(x,x-1) = -h*u(x)+2*v;
        end
        u1 = u - inv(J)*Y;
        if abs(max(u1-u))< 1e-12
            z = z+1;
            break
        else
            u = u1;
            z = z+1;
        end
       
    end
%     disp(z)
%     disp(Y)
    hold on
    x = linspace(x0,x1,n(i)+1);
    plot(x,u)
end
