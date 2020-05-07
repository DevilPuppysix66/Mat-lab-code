clear,clc;
syms x x1 y y1 p w funct;
%x = 16;
funct = 0;
x1 = [-2.2,-.3,.8,1.9];
y1 = [15.180,10.962,1.920,-2.040];
p = zeros (length(x1),1);
px = 0;
w = 1;
for i = (1:length(x1))
    w = 1;
    for z = (1:length(x1))
        if z == i
            %nothing
        else
           w = w * (x - x1(z))/(x1(i)-x1(z));  
        end
    end
    if(isfloat(w))
        p(i) = w * y1(i);
        px = px + p(i);
    else
        funct = funct + w * y1(i);
    end
    
end
if(isfloat(w))
    disp(p)
    disp(px)
else
    funct = expand(funct);
    disp(funct)
end
    
