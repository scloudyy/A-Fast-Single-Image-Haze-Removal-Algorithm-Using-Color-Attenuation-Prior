function [ new_d ] = d_patch( d, r )
%D_PATCH Summary of this function goes here
%   Detailed explanation goes here
    [height, width, nch] = size(d);
    for i = 1:1:height
        for j = 1:1:width
            new_d(i, j) = get_min(d, i, j, r, height, width);
        end
    end
end

function [ min_d ] = get_min(d, i, j, r, height, width)
    i_up = i - r;
    i_down = i + r;
    j_left = j - r;
    j_right = j + r;
    
    if i_up < 1
        i_up = 1;
    end
    
    if i_down > height
        i_down = height;
    end
    
    if j_left < 1
        j_left = 1;
    end
    
    if j_right > width
        j_right = width;
    end
    
    patch = zeros((i_down - i_up + 1), (j_right - j_left + 1));
    patch(:,:) = d(i_up:i_down, j_left:j_right);
    min_d = min(min(patch));
end

