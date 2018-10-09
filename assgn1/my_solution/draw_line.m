d = 0:pi/100:2*pi;
l1 = 10 * cos(d) + 10 * sin(d);
plot(d, l1)
grid on
hold on

l2 = 20 * cos(d) + 20 * sin(d);
plot(d, l2)

l3 = 30 * cos(d) + 30 * sin(d);
plot(d, l3)

legend('p(10, 10)' , 'p(20,20)', 'p(30,30)')

hold off