function [] = giveMeImage(imNum,clips,saveIm)

pSqY = 1000; % this is the number of pixles tall the clipped box will be
pSqX = 500; % this is the number of pixles long the clipped box will be

x1 = 600; % this is the top left x coord
y1 = 300; % this is the top left y coord
imString = ['D:\Code\imageAnalysis\images\' imNum '.JPG'] % this is where you keep your image stored

%% load the color image and view figure with the choive of clipping and saving
[f,map] = imread(imString);
figure
imshow(f)
if clips
    f_ic(:,:,1) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],1);
    f_ic(:,:,2) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],2);
    f_ic(:,:,3) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],3);
    if saveIm
        imwrite(f_ic,['D:\Code\imageAnalysis\images\processed\' imNum '_orginal.png'],'png','Comment','Original image')
    end

end
title(imString)
if saveIm
    imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_original.png'],'png','Comment','Original image')
end


%% convert the image to grayscale intensity with the choice of clipping and saving
G_I = rgb2gray(f);
if clips
    G_I = G_I([x1:(x1+pSqX)],[y1:(y1+pSqY)]);
end
figure
imshow(G_I)
title(imString)
if saveIm
    imwrite(G_I,['D:\Code\imageAnalysis\images\processed\' imNum '_Gray.png'],'png','Comment','converted to grayscale')
end


%% convert the image to a negative with the choice of saving
f_Neg = imadjust(G_I,[0 1],[1 0]); %%make a negative of the image using built in M. function
figure
imshow(f_Neg)
title(imString)
if saveIm
    imwrite(f_Neg,['D:\Code\imageAnalysis\images\processed\' imNum '_Neg.png'],'png','Comment','negative')
end

%% filter the image so that all pixels with intensity greater that threshold value of 100 are white
f_Neg(f_Neg>100) = 255;
f3 = figure
imshow(f_Neg)
title(imString)
if saveIm
    imwrite(f_Neg,['D:\Code\imageAnalysis\images\processed\' imNum '_Neg_Thld.png'],'png','Comment','negative and masked')
end


                                                                                                                
% %%
% m = 50
% g = [1:1:255]
% ee = 10
% gi_3 = 2./(1+(m./gi).^ee);
% figure
% % plot(g,gi_3,'.')
% histogram(gi_3)