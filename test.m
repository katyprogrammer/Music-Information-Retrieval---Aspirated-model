clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                      %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;            %# time vector
nfft = 2^nextpow2(Fs);        %# n-point DFT
numUniq = ceil((nfft+1)/2);   %# half point
f = (0:numUniq-1)'*Fs/nfft;   %'# frequency vector (one sided)
dense = 1;
%%
sigwhole = [];
fftMagwhole = [];
pitchseq = [261,293,329,349,392,440];
num = 3;
for n = 1:num
    pitch = pitchseq(n);
    dur = 0.3;
    N = round(dur * Fs) * dense;
    time = (0:N-1) / Fs;
    maxe = 100;
    sigma= 30;
    pro = (1/((sqrt(2*pi))*sigma)) * 0.001;
    
    sig = zeros(1,N);
    % sig = cos(2*pi*pitch*time)*maxe;
    for i = 1 : 5000
        pitch_ = rand * 3000;
        %pitch_ = i;
        pro = 1 / abs(pitch_ - pitch);
        mul = (1/((sqrt(2*pi))*sigma))*exp(-((abs(pitch_-pitch)).^2)/(2*sigma.^2));
        sig = sig + (cos(2*pi*pitch_*time) * (maxe * mul + maxe * pro));
    end
    
    sig = sig';
    sig = sig .* hanning(length(sig));
    fftMag = 10*log10( abs(fft(sig,nfft)));
    [maxmag,fundfreq] = max(fftMag);
    
    sigwhole(:,n) = sig;
    fftMagwhole(:,n) = fftMag(1:numUniq);
end
sigcon = [];
for n = 1:num
    sig = sigwhole(:,n);
    sigcon = [sigcon;sig];
    fftMag = fftMagwhole(:,n);
    figure(1);
    plot(f, fftMag(1:numUniq));
    axis([0,4000,0,100]);
    p=audioplayer(sig .* hanning(length(sig)), Fs); playblocking(p);
end
% p=audioplayer(sigcon, Fs); playblocking(p);