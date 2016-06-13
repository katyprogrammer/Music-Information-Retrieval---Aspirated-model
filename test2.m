% x = linspace(0,2 * pi ,10000);
a = 10;
b = 100;
x = linspace(0,100,10000);
y = 1./((a.*x+b));
plot(x,y);

s1 = sum(y);

a = 1000;
b = 100;
x = linspace(0,100,10000);
y = 1./((a.*x+b));
plot(x,y);

s2 = sum(y);

x = linspace(0,10000,10000);
a = 10000;
c = sum(1./((10.*x+100)))/ sum(1./((a.*x+100)))