%%
clear all; clc;close all 
L=1;
 t=1;
 alpha=.01;
 n=[6,12,24,48];  % number of spatial segments
 nt=10; % number of timestepsuetl0 = zeros(1,4);
 ten = zeros(1,4);
 five = zeros(1,4);
 for k = 1:length(n)
 dx=L/(n(k)+1);
 dt=.01;
 c=alpha*dt/dx^2;
 u0=1*ones(n(k)+1,1);  %initial condition
 u0(1) = 1;  % BC1
 u0(n(k)+1) = 2; %BC2
 u1(1)=u0(1);
 u1(n(k)+1)=u0(n(k)+1);
 figure(k); hold on;

 for j=1:nt
    for i=2:n(k)
        u1(i)=u0(i)+c*(u0(i+1)-2*u0(i)+u0(i-1));
    end
    plot(u1) 
    u0=u1;
    if j==5
        five(k)=u1(n(k))
    end
    if j==10
        ten(k)=u1(n(k))
    end
 end
 hold off
 end
 n1=(1./n)
figure(5)
hold on
loglog(n1,five)
loglog(n1,ten)