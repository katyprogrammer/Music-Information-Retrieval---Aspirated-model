addpath(genpath('..\MIRtoolbox1.6.1'));
%%
close all;clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                      %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;            %# time vector
nfft = 2^nextpow2(Fs);        %# n-point DFT
numUniq = ceil((nfft+1)/2);   %# half point
f = (0:numUniq-1)'*Fs/nfft;   %'# frequency vector (one sided)
dense = 1;
%%
[sig, fs] = audioread('audioclip.wav');
% p=audioplayer(sig, fs); playblocking(p);

w = 1024;
h = w/8;
nfft = w; % size of the fft
spec = stft(sig, w, h, nfft, fs);
spec_abs = abs(spec);
spec_angle = angle(spec);
x=linspace(0,fs/2,w/2+1);
% thre = 20;
% spec_abs(spec_abs>thre) = thre;
for i = 1:length(spec)
    th = mean(spec_abs(:,i));
%     spec_abs(spec_abs(:,i)>th,i) = th;
    spec_abs(:,i) = spec_abs(:,i) - th*2;
    spec_abs(spec_abs(:,i)<0,i) = 0;
    
%     findpeaks(spec_abs(:,i));
%     axis([0,100,0,20]);
%     plot(x,spec_abs(:,i));
%     axis([0,3000,0,20]);
%     drawnow
end
spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
sig_ = istft(spec_, h, nfft, fs);

p=audioplayer(sig_, fs); playblocking(p);