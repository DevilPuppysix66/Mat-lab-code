%--------------------------------------------------------------------
% file: main.m
% main program for 2D FEM Matlab code for 4-node quadrilateral element
% application to a cantilever beam
%--------------------------------------------------------------------
clear, close all,;

nnode=4; %nodes per element
%MaxNgaus=3; %max number of Gauss points

% geometric parameters
L=16.0; c=2.0; 
xl=0.0;
xr=L;
yl=0.0;
yr=c;
h=2*c;
Inertia=h^3/12;

'Input number of elements in X and Y directions:'
numelex=input('numelex=');
numeley=input('numeley=');

% materials parameters
YoungModule=1.e7;
PossionRatio=0.3;

% load parameters
Q_force=-1.0e4;

% create the mesh for the beam
[coord,numnod,numele,node,tnd,bnd,lnd,rnd]=beammsh4(xl,xr,numelex,yl,yr,numeley);

% x and y nodal coordinates
x=coord(1,:);
y=coord(2,:);

ndof=2; %number of dimensions of freedom per node
numeqns=numnod*ndof; %number of dimensions of freedom for the whole system

% external force
force=zeros(1,numeqns);

% compute nodal forces due to tractions on the surfaces
force=traction(nnode,lnd,rnd,Inertia,L,c,Q_force,y);
  
% displacement boundary condition
ifix=[zeros(2,numnod)];
ifix(:,1)=1;
ifix(1,lnd(length(lnd)))=1;
ifix(1,bnd)=1;
 
young=YoungModule*ones(1,numele);
pr=PossionRatio*ones(1,numele);

% zero bigk matrix to prepare for assembly
bigk=zeros(numeqns,numeqns);

% vector of Gauss points
gauss=[-1.0/sqrt(3), 1.0/sqrt(3)];
%ngaus=3;  % the order of Gauss Quadrature for 9-node element

%----------------------------------------------
%  start loop over the elements
%----------------------------------------------
for e=1:numele
   % compute elemental stiffness matrix
   [ke] = elem4(node,x,y,gauss,young,pr,e);
   n1=ndof-1;    
   nlink  = 4;
   % assemble ke into bigk (global stiffness matrix)
   for i=1:nlink;
     for j=1:nlink;
        if ( (node(i,e) ~= 0 )  & (node(j,e) ~= 0) )
          rbk=ndof*(node(i,e)-1)+1;
          cbk=ndof*(node(j,e)-1)+1;
          re=ndof*(i-1)+1;
          ce=ndof*(j-1)+1;  
          bigk(rbk:rbk+n1,cbk:cbk+n1)=...
              bigk(rbk:rbk+n1,cbk:cbk+n1)+ke(re:re+n1,ce:ce+n1);
        end  % endif
     end  % endfor j
   end  % endfor i
end  % endfor e
%----------------------------------------------
%  end loop over the elements
%----------------------------------------------

% enforce constraints (boundary conditions)
for n=1:numnod
   for j=1:ndof
     if (ifix(j,n) == 1)
	     m=ndof*(n-1)+j;
         bigk(m,:)=zeros(1,numeqns);
         bigk(:,m)=zeros(numeqns,1);
         bigk(m,m)=1.0;
    	 force(m)=0;
     end
   end
end

% solve the stiffness equations (find nodal displacements)
disp=force/bigk;

% display the mesh for the original and deformed configurations
dispplot; % plots figures 1,2

% display the comparison of exact & FEM displ solns of the middle surface

xx=[xl:(xr-xl)/100:xr];
xbar=L-xx;
ExactDispCoordX=xx;
v=PossionRatio;
u2=xbar.^3 - L^3 -((4+5*v)*c*c + 3*L^2)*(xbar-L);
ExactDispY=Q_force/(6*YoungModule*Inertia)*u2;
fprintf('the exact of the bottom right node =%f',ExactDispY(101))

%output of bottom right node
fprintf('the displacement of the bottom right node =%f',disp((numelex+1)*2))

figure; %figure 3
plot(x(bnd),disp(2.*bnd),'-',ExactDispCoordX,ExactDispY,'-.');
title(['Comparison of Exact and FEM Displ Solns--mesh=',int2str(numelex),'*',int2str(numeley)]);
legend('FEM  Soln','Exact Soln');
xlabel('X');
ylabel('Displacement Component --- Uy');

% END OF FILE