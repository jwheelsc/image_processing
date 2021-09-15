close all
clear all

SEM1 = 'D:\Code\imageAnalysis\images\01_003.JPG';
SEM2 = 'D:\Code\imageAnalysis\images\01_006.JPG';
SEM3 = 'D:\Code\imageAnalysis\images\01_009.JPG';
SEM4 = 'D:\Code\imageAnalysis\images\01_012.JPG';

%% choose the image
% imArr = {'im1','im2','im3','im4','im5','im6','im7','im8','im9','im10',...
%     'im11','im12','im13','im14','im15'};
imArr = {'im15'}
%% choose the options for clipping, saving and creating image histogram
clipIt = 1;
saveIt = 1;
binHist = 0;

opt_1 = [clipIt,saveIt,binHist]
opt_1_str = {'clipIt','saveIt','binHist'}
%% How do you want to process the image (1 for yes, 0 for no)
gam = 0;   
neg = 0;
thresh = 0;
cont_str = 0;
hstEq = 0;
conc_conv = 1;

proc_opt = [gam,neg,thresh,cont_str,hstEq,conc_conv]
proc_opt_str = {'gam','neg','thresh','cont_st','hstEq','conc_conv'}

%%

for i = 1:length(imArr)
    spatialFilts(imArr{i},opt_1_str,opt_1,proc_opt_str,proc_opt)
    close all
end