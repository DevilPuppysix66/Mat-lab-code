% HEADER
% Name:         Aaron Brethower
% Course:       ME212-02
% HWex:  	    Rokcet Science
% Date:        	Feb 4, 2020

%% PROGRAM DESCRIPTION
% this program calculates and plots the path of a rocket  

clear all;
close all;
%% VARIABLE DESCRIPTION
%ag	        Grav. acceleration
%athrust	Thrust accel.*
%atotal	    Total acceleration *
%dtime	    Length of time step
%fthrust	Force of thrust *
%height	    Elevation *
%i	        Index, or counter*
%ke	        Kinetic energy *
%mcase	    Casing mass
%mfuel	    Fuel mass *
%mtot	    Total mass *
%pe	        Potential energy *
%time	    Elapsed time *
%te	        Total energy *
%vel 	    Velocity*

%* Changes with time 


%% INITIAL CONDITIONS
% Initial height:       +1m.
% Initial acceleration: 9.81m/s^2
% Initial elevation: 	1m
%Casing mass:		    16 kg
%Fuel mass:		        134 kg
%Fuel burn rate:		4.7 kg/sec
%Initial time:		    0.0 sec
%Time increments:	    0.05 sec
%coeficient of drag:    0.0075 (N sec^2/m^2)
%Force of thrust:	    1560 N



time(1) = 0;
dtime = 0.05;
height(1) = 1;  
vel(1) = 0;              
ag = -9.81;
athrust(1) = 0;
atotal(1) = athrust(1) + ag;
fthrust(1) = 1560;
mfuel(1) = 134;
mcase = 16;
mtot(1) = mcase + mfuel(1);
cr = 0.85; 
PE(1) = mtot(1)*height(1);
KE(1) = (1/2) * (mtot(1) / ag) * vel^2;
TE(1) = PE(1) + KE(1);
fdrag(1) = vel(1)^2 * -.0075;
adrag(1) = fdrag(1) / mtot(1);
%% PROGRAM
i=2;
h=0;
while(h >= 0)
    
   %conditions required for both before and after
    vel(i) = vel(i-1) + atotal(i-1)*dtime;
    fdrag(i) = (vel(i)^2 * -.0075) * vel(i) / abs(vel(i));
    
    %conditions before fuel runs out
    if(mfuel > 0)
        mfuel(i) = mfuel(i-1) - 4.7*dtime;
        mtot(i) = mcase + mfuel(i-1);
        adrag(i) = fdrag(i) / mtot(i);
        athrust(i) = fthrust(1)/mtot(i);
        atotal(i) = athrust(i) +  ag + adrag(i);
        fthrust(i) = fthrust(i-1);
        
        %conditions after fuel runs out
    else
        mtot(i) = mcase;
        fthrust(i) = 0;
        adrag(i) = fdrag(i) / mtot(i);
        atotal(i) = ag + adrag(i);
    end
    
    %conditions indirectly dependant of fuel mass
    
    height(i) = height(i-1) + vel(i)*dtime;
    PE(i) = mtot(i-1)*height(i-1);
    KE(i) = (1/2) * (mtot(i) / -ag) * abs(vel(i)^2);
    TE(i) =PE(i) + KE(i);
    time(i) = time(i-1)+dtime;
    h = height(i-1);
    
    
    i = i + 1;
end


%% OUTPUT

%height vs time graph
figure(1)
subplot(2,2,2)
plot(time,height);
grid
title('height vs time')
xlabel('time(sec)')
ylabel('height(m)')

 
%time vs velocity graph
subplot(2,2,3)
plot(time,vel);
grid
title('time vs velocity')
xlabel('time(sec)')
ylabel('velocity(m/s)')
 

%time vs acceleration graph
subplot(2,2,4)
plot(time,atotal)
grid
title('time vs acceleration')
xlabel('time(sec)')
ylabel('acceleration(m/sec^2)')


%time vs mass graph
subplot(2,2,1)
plot(time,mtot)
grid
title('time vs Total Mass')
xlabel('time(sec)')
ylabel('Mass(Kg)')
 

figure(2)
%time vs force of thrust graph

plot(time,fthrust)
grid
title('time vs thrust force')
xlabel('time(sec')
ylabel('thrust(N)')


figure(3)

%time vs kenetic,potential,total energy graph
plot(time,KE,time,TE,time,PE)
grid
legend('KE','TE','PE')
title('time vs kenetic energy')
xlabel('time(sec)')
ylabel('Kenetic(N*m)')


figure(4)
%time vs force of wind resistance graph

plot(time,fdrag)
grid
title('time vs wind force')
xlabel('time(sec)')
ylabel('drag(N)')


% %time vs Potential energy graph
% plot(time,PE,'r')
% grid
% title('time vs potential energy')
% xlabel('time(sec)')
% ylabel('Potential(N m)')
% pause(2) 
% 
% %time vs total energy graph
% plot(time,TE,'m')
% grid
% title('time vs total energy')
% xlabel('time(sec)')
% ylabel('Total(N m)')
% pause(2)