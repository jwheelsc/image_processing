function [] = giveMeImage(imNum,opt_1_str,opt_1,proc_opt_str,proc_opt)
clips = opt_1(strcmp(opt_1_str,'clipIt'));
saveIm = opt_1(strcmp(opt_1_str,'saveIt'));
binHist = opt_1(strcmp(opt_1_str,'binHist'));

gamTran = proc_opt(strcmp(proc_opt_str,'gam'));
negTran = proc_opt(strcmp(proc_opt_str,'neg'));
threshTran = proc_opt(strcmp(proc_opt_str,'thresh'));
cont_str = proc_opt(strcmp(proc_opt_str,'cont_st'));
hstEq = proc_opt(strcmp(proc_opt_str,'hstEq'));
concv = proc_opt(strcmp(proc_opt_str,'conc_conv'));

pSqY = 500; % this is the number of pixles tall the clipped box will be
pSqX = 500; % this is the number of pixles long the clipped box will be

x1 = 300; % this is the top left x coord
y1 = 600; % this is the top left y coord
imString = ['D:\Code\imageAnalysis\images\' imNum '.JPG'] % this is where you keep your image stored
% keyboard
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

if binHist 
    strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_Gray_hist.pdf'];
    daat = G_I;
    histIm(daat,strSave,saveIm)
end

%% histogram equalization

if hstEq

    figure
%     G_I(G_I>150)=255;
%     f = histeq(G_I,255);
    f = adapthisteq(G_I,'NumTiles',[10 10]);
    imshow(f)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_histEq_10.png'],'png','Comment','converted to grayscale')
    end
    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_histEq_hist_10.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
    
end

%% convert the image to a negative with the choice of saving
if gamTran
    
    gamConst = 1
    f = imadjust(G_I,[0.5 0.75],[0 1],gamConst); %%make a negative of the image using built in M. function
    figure
    imshow(f)
    title(imString)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_gamma.png'],'png','Comment','negative')
    end
    
    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_gamma_hist.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
    
end


%% convert the image usnig a gamma transformation

if negTran
    
    f = imadjust(G_I,[0 1],[1 0]); %%make a negative of the image using built in M. function
    figure
    imshow(f)
    title(imString)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_Neg.png'],'png','Comment','negative')
    end

    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_Neg_hist.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
end


%% filter the image so that all pixels with intensity greater that threshold value of 100 are white

if threshTran
    f(f>100) = 255;
    f3 = figure
    imshow(f)
    title(imString)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_Neg_Thld.png'],'png','Comment','negative and masked')
    end
    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_Neg_Thld_hist.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
end

%% filter the image using contrast-strethcing function
if cont_str
    E = 20 % here is the slope 
    m = 125 % here is the central moment
    f_out = (1./(1+((m./G_I).^E)))*255;
    f = f_out;
%     f = interp1(f_out)
% keyboard
    f3 = figure
    imshow(f)
    title(imString)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_cont_str.png'],'png','Comment','negative and masked')
    end
    % here is a plot so that you can see the function
    x = [0:1:255];
    y = (1./(1+((m./x).^E)))*255;
    figure
    plot(x,y);
    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_cont_str_hist.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
end

%% convert the image usnig a gamma transformation

if concv
    
    w = fspecial('laplacian',0);
    w = [1,1,1;1,-8,1;1,1,1]
    f = imfilter(G_I,w,'replicate'); %%correlation or convolution using built in .M function
    figure
    imshow(f)
    title(imString)
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_lap8.png'],'png','Comment','laplacian')
    end
    
    figure
    g8 = G_I-f;
    imshow(g8)
    if saveIm
        imwrite(g8,['D:\Code\imageAnalysis\images\processed\' imNum '_lap8_added.png'],'png','Comment','laplacian')
    end
 
    return
    
    if saveIm
        imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_concv.png'],'png','Comment','correlation')
    end

    if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_concv_hist.pdf'];
        daat = f;
        histIm(daat,strSave,saveIm)
    end
    
end