clear;
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

load GT526.mat
specA = curmaxqfspe;
specA = specA(l/2+1:end);
load GT1052.mat
specB = curmaxqfspe;
specB = specB(l/2+1:end);
cmp = cmpSpec(specA,specB)

