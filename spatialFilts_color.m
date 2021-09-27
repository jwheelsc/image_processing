function [] = spatialFilts(imNum,opt_1_str,opt_1,proc_opt_str,proc_opt)
clips = opt_1(strcmp(opt_1_str,'clipIt'));
saveIm = opt_1(strcmp(opt_1_str,'saveIt'));
binHist = opt_1(strcmp(opt_1_str,'binHist'));

gamTran = proc_opt(strcmp(proc_opt_str,'gam'));
negTran = proc_opt(strcmp(proc_opt_str,'neg'));
threshTran = proc_opt(strcmp(proc_opt_str,'thresh'));
cont_str = proc_opt(strcmp(proc_opt_str,'cont_st'));
hstEq = proc_opt(strcmp(proc_opt_str,'hstEq'));
concv = proc_opt(strcmp(proc_opt_str,'conc_conv'));
sobl = proc_opt(strcmp(proc_opt_str,'sob_filt'));


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
initCode = 0
T =3;
color_seg(f,initCode,T,imNum,saveIm)

title(imString)
if clips
    f_ic(:,:,1) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],1);
    f_ic(:,:,2) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],2);
    f_ic(:,:,3) = f([x1:(x1+pSqX)],[y1:(y1+pSqY)],3);
    f = f_ic;
end
if saveIm
    imwrite(f,['D:\Code\imageAnalysis\images\processed\' imNum '_orginal.png'],'png','Comment','Original image')
end


%% display the color components

f_r = f(:,:,1);
f_g = f(:,:,2);
f_b = f(:,:,3);
if binHist 
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_red_hist.pdf'];
        histIm_col(f_r,strSave,saveIm,'r')
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_green_hist.pdf'];
        histIm_col(f_g,strSave,saveIm,'g')
        strSave = ['D:\Code\imageAnalysis\images\processed\' imNum '_blue_hist.pdf'];
        histIm_col(f_b,strSave,saveIm,'b')
end

f_col = cat(3,f_r,f_g,f_b);

%% filter the image using contrast-strethcing function
if cont_str
    
    E = 10 % here is the slope 
    m = 125 % here is the central moment
    f_rF = (1./(1+((m./f_r).^E)))*255;
    f_gF = (1./(1+((m./f_g).^E)))*255;
    f_bF = (1./(1+((m./f_b).^E)))*255;
    f = cat(3,f_rF,f_gF,f_bF);
%     f = interp1(f_out)
% keyboard
    f3 = figure
    imshow(f)
%     title(imString)
    title('contrast stretching')
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

%% convert the image usnig a convolution transformation

if concv
    
%     w = fspecial('laplacian',0);
    w = [1,1,1;1,-8,1;1,1,1]
    f_rF = imfilter(f_r,w,'replicate'); %%correlation or convolution using built in .M function
    f_gF = imfilter(f_g,w,'replicate'); %%correlation or convolution using built in .M function
    f_bF = imfilter(f_b,w,'replicate'); %%correlation or convolution using built in .M function

    f_col_filt = cat(3,f_rF,f_gF,f_bF);
    
    figure
    imshow(f_col_filt)
    title(imString)
    if saveIm
        imwrite(f_col_filt,['D:\Code\imageAnalysis\images\processed\' imNum '_lap8.png'],'png','Comment','laplacian')
    end
        
    figure
    g8 = f_col-f_col_filt;
    imshow(g8)
    if saveIm
        imwrite(g8,['D:\Code\imageAnalysis\images\processed\' imNum '_lap8_added.png'],'png','Comment','laplacian')
    end
    
end

%%
if sobl
    
    w_x = [fspecial('sobel',0)]';
    w_y = [fspecial('sobel',0)]'';
%     w = [1,1,1;1,-8,1;1,1,1]
    f_rF_x = imfilter(f_r,w_x,'replicate'); %%correlation or convolution using built in .M function
    f_gF = imfilter(f_g,w,'replicate'); %%correlation or convolution using built in .M function
    f_bF = imfilter(f_b,w,'replicate'); %%correlation or convolution using built in .M function

    f_col_filt = cat(3,f_rF,f_gF,f_bF);
    
    figure
    imshow(f_col_filt)
    title(imString)
    if saveIm
        imwrite(f_col,['D:\Code\imageAnalysis\images\processed\' imNum '_lap8.png'],'png','Comment','laplacian')
    end
    
    figure
    g8 = f_col-f_col_filt;
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