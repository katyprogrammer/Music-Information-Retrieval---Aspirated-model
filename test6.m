addpath(genpath('..\MIRtoolbox1.6.1'));
%% low pass filter
%%
close all;clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                         %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;             %# time vector
nfft = 2^nextpow2(Fs);         %# n-point DFT
numUniq = ceil((nfft+1)/2);    %# half point
f = (0:numUniq-1)'*Fs/nfft;    %'# frequency vector (one sided)
dense = 1;
%%
pitch = 632;
dur = 1;
N = round(dur * Fs) * dense;
time = (0:N-1) / Fs;
maxe = 1; %%%%%%%%%%%%%%%%%%%%%
range = 3000;
sig = zeros(1,N);
for i = 1 : 10000
    pitch_ = i;
    sig = sig + (maxe * cos(2*pi*pitch_*time));
end
% a = 100;
% b = 100;
% exponential = 1;
% volumn = 100;
% sampnum = 1000;
% pitch_ = pitch;
% for i = 1 : sampnum
%     sig = sig + (maxe * cos(2*pi*pitch_*time) / ( ( ( abs ( pitch_ - pitch ) ^ exponential ) * a + b )));
%     pitch_ = rand * range;
% end 
% sig = sig / norm(sig, 2) * volumn;
sig = sig';

w = 1024;
h = w/8;
nfft = w;
spec = stft(sig, w, h, nfft, Fs);
spec_abs = abs(spec);
spec_angle = angle(spec);
x=linspace(0,Fs/2,w/2+1);
for i = 1:size(spec_abs,2);
    spec_abs(9,i) = spec_abs(9,i) * 100;
    %spec_abs(1:3,i) = 0;
%   spec_abs(end/10:end,i) = 0;
    plot(x,spec_abs(:,i));
    axis([0,Fs/2,0,20]);
    drawnow
end
spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
sig_ = istft(spec_, h, nfft, Fs);
%%p=audioplayer(sig_, Fs); playblocking(p);