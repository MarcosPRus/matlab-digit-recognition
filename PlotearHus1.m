n = 1:25;

figure();
hold on
for i = 1:10
    plot(n, Hu(1,:,i));
end
hold off

figure();
hold on
for i = 1:10
    plot(n, Hu(2,:,i));
end
hold off

figure();
hold on
for i = 1:10
    plot(n, Hu(3,:,i));
end
hold off

figure();
hold on
for i = 1:10
    plot(n, Hu(4,:,i));
end
hold off
