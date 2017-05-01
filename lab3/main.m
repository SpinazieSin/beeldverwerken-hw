%%% Beelverwerken Lab 3
% Thomas Groot 10658017


function main()
    %%
    box = im2double(rgb2gray(imread('attachments/box.png')));
    canny  = edge(box, 'canny', 0.1);
    imshow(canny)
end