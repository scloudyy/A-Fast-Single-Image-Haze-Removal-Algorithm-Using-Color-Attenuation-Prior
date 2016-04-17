clear;

fileFolder=fullfile('E:\WorkPlace\Code\matlab\A Fast Single Image Haze Removal Algorithm Using Color Attenuation Prior');
fileFolder_img = char(strcat(fileFolder, '\img'));
dirOutput=dir(fullfile(fileFolder_img,'*'));
fileNames={dirOutput.name};

for i = 1:1:length(fileNames)
    if sum(strfind(char(fileNames(i)), 'bmp')) || sum(strfind(char(fileNames(i)), 'jpg')) || sum(strfind(char(fileNames(i)), 'png'))
        src = im2double(imread(char(strcat('img\', fileNames(i)))));
        darkchannel = calcDarkChannel(src);
        A = calcAirlight(src, darkchannel);
        [height, width, nch] = size(src);
        hsv = rgb2hsv(src);
        d = zeros(height, width);
        d(:,:) = 0.121779 + 0.959710 * hsv(:,:,3) - 0.780245 * hsv(:,:,2) + 0.041337;
        new_d = d_patch(d, 5);
        guidedfilter_d = imguidedfilter(new_d, src);
        output = recover(src, A, guidedfilter_d);
        imwrite(output, char(strcat('Result\', fileNames(i), '_Guided.bmp')));

        output = recover(src, A, new_d);
        imwrite(output, char(strcat('Result\', fileNames(i), '_NoGuided.bmp')));
    end
end

