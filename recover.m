function [ output ] = recover( I, A, d )
%RECOVER Summary of this function goes here
%   Detailed explanation goes here
    [height, width, nch] = size(I);
    value = zeros(height, width);
    output = zeros(height, width, nch);
    for i = 1:1:height
        for j = 1:1:width
            tmp = 2.718281828459^(-d(i, j));
            if tmp > 0.1
                max = tmp;
            else
                max = 0.1;
            end
            if max < 0.9
                value(i, j) = max;
            else
                value(i, j) = 0.9;
            end
        end
    end
    
    for c = 1:1:nch
        for i = 1:1:height
            for j = 1:1:width
                output(i, j, c) = (I(i, j, c) - A(c)) / value(i, j) + A(c);
            end
         end
    end
end

