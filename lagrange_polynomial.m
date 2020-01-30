syms x x1 y y1 p w;
x = 16;
x1 = [10,15,20,22.5];
y1 = [227.04, 362.78, 517.5, 602.97];
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
    p(i) = w * y1(i);
    px = px + p(i);
end
disp(p)
disp(px)