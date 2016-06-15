addpath(genpath('..\MIRtoolbox1.6.1'));
%% extracting aspirated model from audio pieces
close all;clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                         %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;             %# time vector
nfft = 2^nextpow2(Fs);         %# n-point DFT
numUniq = ceil((nfft+1)/2);    %# half point
f = (0:numUniq-1)'*Fs/nfft;    %'# frequency vector (one sided)
dense = 1;
%%
[sig, Fs] = audioread('audioclip.wav');
% p=audioplayer(sig, Fs); playblocking(p);

spec = fft(sig,Fs);
spec = spec(1:end/2);
spec_abs = abs(spec);
spec_angle = angle(spec);

spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
sig = ifft(spec_,Fs);
sig = repmat(sig,4,1);

plot(1:Fs/2,spec_abs);
axis([0,2000,0,max(spec_abs)/50]);
% p=audioplayer(sig, Fs); playblocking(p);
%%

Fs = 65536;
dur = 1;
N = round(dur * Fs);
time = (0:N-1) / Fs;
pitch = 261;
sig =     cos(2*pi*  pitch*time)/30 *0.3;
sig = sig+cos(2*pi*2*pitch*time)/30 *1;
sig = sig+cos(2*pi*3*pitch*time)/30 *0.15;
sig = sig+cos(2*pi*4*pitch*time)/30 *0.45;
sig = sig+cos(2*pi*5*pitch*time)/30 *0.45;
sig = sig+cos(2*pi*6*pitch*time)/30 *0.2;
sig = sig+cos(2*pi*7*pitch*time)/30 *0.25;

spec = fft(sig,Fs);
spec = spec(1:end/2);
spec_abs = abs(spec);
spec_angle = angle(spec);
plot(1:Fs/2,spec_abs);
axis([0,2000,0,max(spec_abs)]);

hl = hanning(length(sig)/4);hl=hl(1:end/2);
hr = hanning(length(sig)/4);hr=hr(end/2+1:end);
h = [hl;ones(length(sig)/4*3,1);hr];
sig = sig / 10;
sig =sig + geneAsp2(pitch,dur,3000);
sig = sig .* h';
p=audioplayer(sig, Fs); playblocking(p);