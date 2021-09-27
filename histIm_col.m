function [] = histIm_col(daat,strSave,saveIm,col)

fh = figure
h1 = histogram(daat);
set(gca,'fontsize',24);
% xlabel('Instensity');
% ylabel('Frequency');

if col == 'r'
    colS = 'R'
elseif col == 'g'
    colS = 'G'
elseif col == 'b'
    colS = 'B'
end

text(0.05,0.9,colS,'units','normalized','fontsize',36)
grid on;
h1.BinWidth = 10;
h1.BinLimits = [0 256];
h1.FaceColor = col;
h1.EdgeAlpha = 1;
h1.FaceAlpha = 1;
set(gca,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[])
grid on

xlim([0 255])
%     keyboard
if saveIm 
    saveas(fh,strSave)
end