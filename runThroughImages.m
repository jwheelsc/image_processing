close all
clear all

SEM1 = 'D:\Code\imageAnalysis\images\01_003.JPG';
SEM2 = 'D:\Code\imageAnalysis\images\01_006.JPG';
SEM3 = 'D:\Code\imageAnalysis\images\01_009.JPG';
SEM4 = 'D:\Code\imageAnalysis\images\01_012.JPG';


imc_1 = 'D:\Code\imageAnalysis\images\im1.JPG';
imc_2 = 'D:\Code\imageAnalysis\images\im2.JPG';
imc_3 = 'D:\Code\imageAnalysis\images\im3.JPG';
imc_4 = 'D:\Code\imageAnalysis\images\im4.JPG';
imc_5 = 'D:\Code\imageAnalysis\images\im5.JPG';
imc_6 = 'D:\Code\imageAnalysis\images\im6.JPG';
imc_7 = 'D:\Code\imageAnalysis\images\im7.JPG';
imc_8 = 'D:\Code\imageAnalysis\images\im8.JPG';
imc_9 = 'D:\Code\imageAnalysis\images\im9.JPG';
imc_10 = 'D:\Code\imageAnalysis\images\im10.JPG';
imc_11 = 'D:\Code\imageAnalysis\images\im11.JPG';
imc_12 = 'D:\Code\imageAnalysis\images\im12.JPG';
imc_13 = 'D:\Code\imageAnalysis\images\im13.JPG';
imc_14 = 'D:\Code\imageAnalysis\images\im14.JPG';
imc_15 = 'D:\Code\imageAnalysis\images\im14.JPG';


% imArr = {im1,im2,im3,im4}
% imArr = {imc_1,imc_2,imc_3,imc_4,imc_5,imc_6,imc_7,imc_8,imc_9,imc_10,...
%     imc_11,imc_12,imc_13,imc_14,imc_15}
imArr = {'im2'}
clipIt = 1;
saveIt = 1;

for i = 1:length(imArr)
    giveMeImage(imArr{i},clipIt,saveIt)
end