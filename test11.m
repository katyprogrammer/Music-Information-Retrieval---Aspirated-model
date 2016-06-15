% x = 1:Fs/2;
% a = 523;
% sigma = 10;
% y = (1/((sqrt(2*pi))*sigma))*exp(-((x-a).^2)/(2*sigma.^2));
% plot(y);axis([0,1000,0,max(y)]);

x = 1:Fs/2;
pitch = 523;
a = 10;
b = 100;
m = 5;
e = 1;
y = 1 ./ ( ( abs ( x - pitch ) .^ e ) .* a + b );
plot(y);axis([0,1000,0,max(y)]);
