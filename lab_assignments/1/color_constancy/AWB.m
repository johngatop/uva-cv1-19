function [Ic] = AWB(I)


    I = im2double(I);

    % get the values for the color channels
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);

    % get means of color channels
    Rm = mean(R(:));
    Gm = mean(G(:));
    Bm = mean(B(:));

    % generate the corrected grayworld 128 part
    r = 128/Rm;
    g = 128/Gm;
    b = 128/Bm;

    % initialize the "corrected" image with zeros
    [h, w, channels] = size(I);
    Ic = zeros(h, w, channels);

    % now we can do the correction
    % by multiplying the values
    % maybe this can be vectorized
    Ic(:,:,1) = I(:,:,1) * r;
    Ic(:,:,2) = I(:,:,2) * g;
    Ic(:,:,3) = I(:,:,3) * b;

    Ic = uint8(Ic);

    % and show the figure
    figure(3)
    subplot(1,2,1)
    imshow(I)
    title('Original picture')
    subplot(1,2,2)
    imshow(Ic);
    title('Modified to be color constant')

end


