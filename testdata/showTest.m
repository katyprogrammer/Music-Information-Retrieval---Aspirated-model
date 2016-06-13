load GT526.mat
yaxis = 2;
fs = 44100;
resolud = 2;
maxf = 2000;
lowlim = 400;
highlim = 700;
l = fs/resolud;
ll = maxf/resolud;
freq = linspace(0,maxf-1,ll);
filtval = 0.2;

qfplot= qfplot * yaxis / max(qfplot);
qfplotwithfreq = [qfplot;freq];
qfplotwithfreq = qfplotwithfreq(:,qfplotwithfreq(1,:) > filtval);
plot(qfplotwithfreq(2,:),qfplotwithfreq(1,:),'-k');grid on;axis([lowlim,highlim, 0, yaxis]);

curmaxqfsig = repmat(curmaxqfsig,100,1);
p=audioplayer(curmaxqfsig, fs); play(p);