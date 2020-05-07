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
v = 1;
figure(1)
n = [6,12,24,48,96];
for i = 1:length(n)
    u = ones(n(i)+1,1);
    h = (x1-x0)/(n(i)); 
    hlist(i) = h;
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
    umid(i) = u(ceil(length(u)/2));
end
for i=1:4
udiff(i) = umid(i)-umid(i+1);
end
figure(1)
loglog(hlist(1:4),udiff)

a = log((umid(3)-umid(4))/(umid(4)-umid(5)))/log(2);
c = (umid(4)-umid(5))/((hlist(4)^a) - (hlist(5)^a));
uexact = umid(5) + c*hlist(5)^a;

err = abs((uexact - umid)/uexact)*100;
figure(2)
loglog(n,err)