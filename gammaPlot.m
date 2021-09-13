close all
gArr = [0.5,1,2];
A = 1;
x = [0:0.01:1];

for i = 1:length(gArr)
    hold on
    y = A*x.^gArr(i);
    plot(x,y,'k-','linewidth',2)
end

grid on
xlabel('Input intensity, r')
ylabel('Output intensity, s')
set(gca,'fontsize',18)
