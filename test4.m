close all;clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                      %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;            %# time vector
nfft = 2^nextpow2(Fs);        %# n-point DFT
numUniq = ceil((nfft+1)/2);   %# half point
f = (0:numUniq-1)'*Fs/nfft;   %'# frequency vector (one sided)
dense = 1;
%%
pitch = 261;
dur = 1;
N = round(dur * Fs) * dense;
x = (0:N-1) / Fs;
y = zeros(1,N);
cnt = 0;
for i = (0.5)/pitch : 1/pitch : dur
    a = i; sigma=0.01/pitch;
    y = y + (1/((sqrt(2*pi))*sigma))*exp(-((x-a).^2)/(2*sigma.^2));
    cnt = cnt + 1;
end
y = y / cnt;
p=audioplayer(y * 10, Fs); playblocking(p);
subplot(2,1,1);
plot(x,y);
axis([0,0.01,0,10]);

subplot(2,1,2);
fftMag = 10*log10( abs(fft(y,nfft)));
plot(f, fftMag(1:numUniq));
axis([0,4000,0,100]);

% y =  0.1 * cos(2*pi*pitch*x);
% p=audioplayer(y * 10, Fs); playblocking(p);