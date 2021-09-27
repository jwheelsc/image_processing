function [] = color_seg(f,initCode,T,imNum,saveIm)

if initCode
    R = roipoly(f);
    save('D:\Code\imageAnalysis\mat_files\R_im15_brown.mat','R')
else
    load('D:\Code\imageAnalysis\mat_files\R_im15_brown.mat')
end

[M,N] = size(f(:,:,3));
f_out = f;

f_r = double(f(:,:,1));
f_g = double(f(:,:,2));
f_b = double(f(:,:,3));
R_ind = find(R==1);
f_R_r = (f_r(R==1));
f_R_g = (f_g(R==1));
f_R_b = (f_b(R==1));

A = ([f_R_r,f_R_g,f_R_b]);
covC = cov(A);
sig = inv(covC);
meanR = mean(f_R_r);
meanG = mean(f_R_g);
meanB = mean(f_R_b);
% T = mean(diag(covC));
% T = 2

if initCode 
    for i = 1:M
        for j = 1:N
            D2 = [(f_r(i,j)-meanR),(f_g(i,j)-meanG),(f_b(i,j)-meanB)]*sig*[(f_r(i,j)-meanR);(f_g(i,j)-meanG);(f_b(i,j)-meanB)];
            D(i,j) = sqrt(D2);
        end
    end
    save('D:\Code\imageAnalysis\mat_files\D_im15_brown.mat','D')
else
    load('D:\Code\imageAnalysis\mat_files\D_im15_brown.mat')
end
for i = 1:M
    for j = 1:N
        if D(i,j)>T
%             f_out(i,j,1) = uint8(255);
%             f_out(i,j,2) = uint8(0);
%             f_out(i,j,3) = uint8(0);
%         else
            f_out(i,j,1) = uint8(255);
            f_out(i,j,2) = uint8(255);
            f_out(i,j,3) = uint8(255);
        end
    end
end
% 
% el_LT = D<T;
% f_rout = f(:,:,1);
% f_rout = f_rout(el_LT);
% keyboard
% f_out = cat(3,f(el_LT,1),f(el_LT,2),f(el_LT,3));
figure 
imshow(f_out)
if saveIm
    
    imwrite(f_out,['D:\Code\imageAnalysis\images\processed\' imNum '_seg_' num2str(T) '.png'],'png','Comment','Original image')
end


