Colores = {[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[0,0,0],[0.5,0.1,0.8],[0.1,0.5,0.8],[0.8,0.5,0.1]};

figure()
hold on
for i=1:10
    %plot3(Hu_ord1_(i,:),Hu_ord2_(i,:),Hu_ord3_(i,:),'LineStyle','none','color',Colores{i},'marker','*');
    plot(Hu_ord2_(i,:),Hu_ord3_(i,:),'LineStyle','none','color',Colores{i},'marker','*');
end
hold off
legend('0','1','2','3','4','5','6','7','8','9');
xlabel('Momento Hu de orden 2');
ylabel('Momento Hu de orden 3');
zlabel('Momento Hu de orden 3');