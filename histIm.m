function [] = histIm(daat,strSave,saveIm)

fh = figure
h1 = histogram(daat);
set(gca,'fontsize',24);
    xlabel('Instensity');
    ylabel('Frequency');
grid on;
h1.BinWidth = 10;
h1.BinLimits = [0 256];
h1.EdgeAlpha = 1;
h1.FaceAlpha = 0.5;
% set(gca,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[])
grid on

xlim([0 255])
%     keyboard
if saveIm 
    saveas(fh,strSave)
end