function [derivative_values] = derivative(h,values)
    for i = 1:(length(values))
        if i==1
            derivative_values(i) = (values(i+1)-values(i))/(h);
        else if i==length(values)
                derivative_values(i) = (values(i)-values(i-1))/(h);
            else
        derivative_values(i) = (values(i+1)-values(i-1))/(2*h);
            end
        
    end

end